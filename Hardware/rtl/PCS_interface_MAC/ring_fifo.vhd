library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

entity ring_fifo is
	generic (
		WIDTH    : integer := 256; -- 256 (Data)
    N        : integer := 5;
    DEPTH    : integer := 32 -- where DEPTH = 2^N
	);
	port (
		clk_w      : in  std_logic;
    clk_r      : in  std_logic;
		rst_n	     : in  std_logic;
    data_in	   : in  std_logic_vector (WIDTH-1 downto 0);
    data_out   : out std_logic_vector (WIDTH/2-1 downto 0);
    is_sop_in  : in  std_logic;
    eop_addr_in: in  std_logic_vector(5 downto 0);
    is_sop_out : out  std_logic;
    eop_addr_out: out  std_logic_vector(4 downto 0);
    wen        : in  std_logic;
		ren	       : in  std_logic;
		empty	     : out std_logic;
		full	     : out std_logic
	);
end ring_fifo;

--------------------------------------------------------------------
-- SOP and EOP flags:
-- SOP: 1 - sop present / 0 - not present
-- EOP: BV & ADDRESS
--  -> BV = 1 - eop present / 0 - not present
--  -> ADDRESS = eop address from byte 0 to 31 (256-bit data bus)
--------------------------------------------------------------------

architecture behav of ring_fifo is
  type MEM_data is array (DEPTH-1 downto 0) of std_logic_vector(WIDTH/2-1 downto 0);
  type MEM_flags is array (DEPTH-1 downto 0) of std_logic_vector(3 downto 0);
  signal mem_low  : MEM_data;
  signal mem_high : MEM_data;
  signal mem_eop_high : MEM_flags;
  signal mem_eop_low  : MEM_flags;
  signal mem_eop_bv_h   : std_logic_vector(DEPTH-1 downto 0);
  signal mem_eop_bv_l   : std_logic_vector(DEPTH-1 downto 0);
  signal mem_sop  : std_logic_vector(DEPTH-1 downto 0);   -- SOP will be always in the low fifo
  -- 1 (SOP present) + 6 (Points to the EOP) - Separeted from data bus for now...

  signal w_ptr   : std_logic_vector(N-1 downto 0);
  signal r_ptr_l : std_logic_vector(N-1 downto 0);
  signal r_ptr_h : std_logic_vector(N-1 downto 0);
  signal rr      : std_logic;                   -- Round Robbin between fifos when reading

  -- signal last_op : std_logic; -- 1 - last operation = write / 0 - last operation = read
  signal last_w  : std_logic; -- A write happened last cycle
  signal last_r  : std_logic; -- A read happened last cycle
begin

  sync_w: process(clk_w, rst_n)
  begin
    if rst_n = '0' then
      mem_high <= (others=>(others=>'0'));
      mem_low  <= (others=>(others=>'0'));
      mem_eop_high <= (others=>(others=>'0'));
      mem_eop_low <= (others=>(others=>'0'));
      mem_sop <= (others=>'0');
      mem_eop_bv_h <= (others=>'0');
      mem_eop_bv_l <= (others=>'0');
      w_ptr <= (others=>'0');
    elsif clk_w'event and clk_w = '1' then
        if wen = '1' then                 -- Does not check full, will overwrite
          mem_high(conv_integer(w_ptr)) <= data_in(WIDTH-1 downto WIDTH/2);
          mem_low(conv_integer(w_ptr))  <= data_in(WIDTH/2-1 downto 0);

          if eop_addr_in(5) = '0' then
            -- Valid EOP value
            if eop_addr_in(4) = '1' then
              -- EOP is in the higher half
              mem_eop_bv_h(conv_integer(w_ptr)) <= '1';
              mem_eop_bv_l(conv_integer(w_ptr)) <= '0';
              mem_eop_high(conv_integer(w_ptr)) <= eop_addr_in(3 downto 0);
              mem_eop_low(conv_integer(w_ptr)) <= (others=>'0');
            else
              -- EOP is in the lower half
              mem_eop_bv_h(conv_integer(w_ptr)) <= '0';
              mem_eop_bv_l(conv_integer(w_ptr)) <= '1';
              mem_eop_low(conv_integer(w_ptr)) <= eop_addr_in(3 downto 0);
              mem_eop_high(conv_integer(w_ptr)) <= (others=>'0');
            end if;
          else
            -- No EOP this time
            mem_eop_bv_h(conv_integer(w_ptr)) <= '0';
            mem_eop_bv_l(conv_integer(w_ptr)) <= '0';
            mem_eop_low(conv_integer(w_ptr)) <= (others=>'0');
            mem_eop_high(conv_integer(w_ptr)) <= (others=>'0');
          end if;

          if is_sop_in = '1' then
            mem_sop(conv_integer(w_ptr)) <= '1';
          else
            mem_sop(conv_integer(w_ptr)) <= '0';
          end if;

          w_ptr <= w_ptr + 1;
          last_w <= '1';
        else
          last_w <= '0';
        end if;
    end if;
  end process;

  sync_r: process(clk_r, rst_n)
  begin
    if rst_n = '0' then
      data_out <= (others=>'0');
      is_sop_out <= '0';
      eop_addr_out <= (others=>'0');
      r_ptr_l  <= (others=>'0');
      r_ptr_h  <= (others=>'0');
      rr <= '0';
    elsif clk_r'event and clk_r = '1' then
      if ren = '1' then                 -- Does not check empty, will underwrite
        if rr = '0' then
          data_out <= mem_low(conv_integer(r_ptr_l));
          eop_addr_out <= mem_eop_bv_l(conv_integer(r_ptr_l)) & mem_eop_low(conv_integer(r_ptr_l));
          is_sop_out <= mem_sop(conv_integer(r_ptr_l));
          r_ptr_l <= r_ptr_l + 1;
        else
          data_out <= mem_high(conv_integer(r_ptr_h));
          eop_addr_out <= mem_eop_bv_h(conv_integer(r_ptr_h)) & mem_eop_high(conv_integer(r_ptr_h));
          is_sop_out <= '0';
          r_ptr_h <= r_ptr_h + 1;
        end if;
        rr <= not rr;
      end if;
    end if;
  end process;

  comb: process(w_ptr, r_ptr_l, r_ptr_h, last_w)
  begin
    if w_ptr = r_ptr_h and w_ptr = r_ptr_l then -- For at least one cycle they will be equal
      if last_w = '1' then
        full <= '1';
        empty <= '0';
      else
        full <= '0';
        empty <= '1';
      end if;
    else
      full <= '0';
      empty <= '0';
    end if;
  end process;

end behav;
