library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

entity pcs_selector is
  port(
  -- INPUTS
      clk        : in std_logic;
      rst_n      : in std_logic;
      old_data   : in std_logic_vector(63 downto 0);
      old_header : in std_logic_vector( 1 downto 0);
      data_in    : in std_logic_vector(63 downto 0);
      header_in  : in std_logic_vector( 1 downto 0);
  -- OUTPUTS
      data_out   : out std_logic_vector(63 downto 0);
      header_out : out std_logic_vector( 1 downto 0)
      );
end entity;

architecture behav_pcs_selector of pcs_selector is
  signal old_data_0   : std_logic_vector(63 downto 0);
  signal old_header_0 : std_logic_vector( 1 downto 0);
  signal old_data_1   : std_logic_vector(63 downto 0);
  signal old_header_1 : std_logic_vector( 1 downto 0);
  signal old_data_2   : std_logic_vector(63 downto 0);
  signal old_header_2 : std_logic_vector( 1 downto 0);

  signal data_0   : std_logic_vector(63 downto 0);
  signal header_0 : std_logic_vector( 1 downto 0);
  signal data_1   : std_logic_vector(63 downto 0);
  signal header_1 : std_logic_vector( 1 downto 0);

  signal round_robin : std_logic;

begin

  old_block_d_0: entity work.regnbit generic map (size=>64) port map (ck=>clk, rst=>rst_n, ce=>'1', D=>old_data,     Q=>old_data_0);
  old_block_h_0: entity work.regnbit generic map (size=>2)  port map (ck=>clk, rst=>rst_n, ce=>'1', D=>old_header,   Q=>old_header_0);
  old_block_d_1: entity work.regnbit generic map (size=>64) port map (ck=>clk, rst=>rst_n, ce=>'1', D=>old_data_0,   Q=>old_data_1);
  old_block_h_1: entity work.regnbit generic map (size=>2)  port map (ck=>clk, rst=>rst_n, ce=>'1', D=>old_header_0, Q=>old_header_1);
  old_block_d_2: entity work.regnbit generic map (size=>64) port map (ck=>clk, rst=>rst_n, ce=>'1', D=>old_data_1,   Q=>old_data_2);
  old_block_h_2: entity work.regnbit generic map (size=>2)  port map (ck=>clk, rst=>rst_n, ce=>'1', D=>old_header_1, Q=>old_header_2);

  block_d_0: entity work.regnbit generic map (size=>64) port map (ck=>clk, rst=>rst_n, ce=>'1', D=>data_in,     Q=>data_0);
  block_h_0: entity work.regnbit generic map (size=>2)  port map (ck=>clk, rst=>rst_n, ce=>'1', D=>header_in,   Q=>header_0);
  block_d_1: entity work.regnbit generic map (size=>64) port map (ck=>clk, rst=>rst_n, ce=>'1', D=>data_0,   Q=>data_1);
  block_h_1: entity work.regnbit generic map (size=>2)  port map (ck=>clk, rst=>rst_n, ce=>'1', D=>header_0, Q=>header_1);

  process(clk, rst_n)
  begin
    if (rst_n = '0') then
      round_robin <= '0';
    elsif clk'event and clk = '1' then
      if (round_robin = '0') then
        data_out   <= data_1;
        header_out <= header_1;
      else
        data_out   <= old_data_2;
        header_out <= old_header_2;
      end if;
    end if;
  end process;

end behav_pcs_selector;
