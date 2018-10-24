--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- PARALLEL AND PIPELINED LFSR ARCHITECTURE DEVELOPED BY MATHEUS LEMES FERRONATO
-- AND GABRIEL SUSIN. BASED UPON OLD ARCHITECTURE FROM 10GB PROJECT
-- NEW ARCHITECTURE CREATED TO ADDRESS ANY BITS DATA AND ANY PIPELINE STAGES
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Generic LSFR
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity lsfr_generic_reg_gen is
           generic( DATA_SIZE : integer := 256);
           port (
            rst_n:	        in std_logic;
            parallel_reg: in std_logic_vector(DATA_SIZE-1 downto 0);
            random:		    out std_logic_vector(DATA_SIZE-1 downto 0);
            poly:         in  std_logic_vector(1 downto 0)
            --seed_I:		    in std_logic_vector(DATA_SIZE-1 downto 0)
         );
end lsfr_generic_reg_gen;


architecture lsfr_generic_r of lsfr_generic_reg_gen is
  signal intermediate: std_logic_vector(DATA_SIZE-1 downto 0);
  signal tap : std_logic;
  begin
    tap <= '0' when rst_n = '0' else
           parallel_reg(30) xor parallel_reg(27) when poly="00" else
           parallel_reg(22) xor parallel_reg(17) when poly="01" else
           parallel_reg(14) xor parallel_reg(13) when poly="10" else
           parallel_reg(6)  xor parallel_reg(5)  when poly="11";

    intermediate <= parallel_reg(DATA_SIZE-2 downto 0) & tap when rst_n = '1';

    random <= intermediate;

end lsfr_generic_r;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- LSFR PARALLEL
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity LFSR_GEN is
  generic
  (
    DATA_SIZE   : integer := 256;
    PPL_SIZE   : integer := 4
  );
  port
  (
    clock               : in  std_logic;
    reset_N             : in  std_logic;
    seed                : in  std_logic_vector(DATA_SIZE-1 downto 0);
    valid_seed          : in  std_logic;
    polynomial          : in  std_logic_vector(1 downto 0);
    data_in             : in  std_logic_vector(DATA_SIZE-1 downto 0);
    start               : in  std_logic;
    preset              : in  std_logic;
    data_out            : out std_logic_vector(DATA_SIZE-1 downto 0)

  );
end LFSR_GEN;

architecture arch_lfsr of LFSR_GEN is

  -------------------------------------------------------------------------------
  -- Debug
  -------------------------------------------------------------------------------
  type lfsr_table is array (0 to PPL_SIZE-1, 0 to ((DATA_SIZE / PPL_SIZE)-1)) of std_logic_vector (DATA_SIZE-1 downto 0);
  signal linear_feedback : lfsr_table;

  type time_shift_table is array (0 to PPL_SIZE-1) of std_logic_vector (DATA_SIZE-1 downto 0);
  signal time_shift_seed : time_shift_table;

  signal reg_i, Delay_B0, Delay_B1, Delay_B2 : std_logic_vector (DATA_SIZE-1 downto 0);
  signal start_run, reset_run, secure_send : std_logic := '0';
  signal count_TS : integer range 0 to 15;
  signal count_SS : integer range 0 to 7;


begin


  start_run <= start or preset or secure_send;
  data_out <= linear_feedback(3,63);

  lfsr0_0 : entity work.lsfr_generic_reg_gen generic map (DATA_SIZE=> DATA_SIZE) port map (rst_n => reset_N, parallel_reg => reg_i, random => linear_feedback(0,0), poly => polynomial);
  lfsr1_0 : entity work.lsfr_generic_reg_gen generic map (DATA_SIZE=> DATA_SIZE) port map (rst_n => reset_N, parallel_reg => Delay_B0, random => linear_feedback(1,0), poly => polynomial);
  lfsr2_0 : entity work.lsfr_generic_reg_gen generic map (DATA_SIZE=> DATA_SIZE) port map (rst_n => reset_N, parallel_reg => Delay_B1, random => linear_feedback(2,0), poly => polynomial);
  lfsr3_0 : entity work.lsfr_generic_reg_gen generic map (DATA_SIZE=> DATA_SIZE) port map (rst_n => reset_N, parallel_reg => Delay_B2, random => linear_feedback(3,0), poly => polynomial);


  generate_ppl : for i in 0 to  PPL_SIZE-1 generate
    generate_lfsr : for j in 1 to  ((DATA_SIZE / PPL_SIZE)-1)  generate
        lfsrn : entity work.lsfr_generic_reg_gen generic map (DATA_SIZE=> DATA_SIZE)
                     port map (rst_n => reset_N, parallel_reg => linear_feedback(i,j-1), random => linear_feedback(i,j), poly => polynomial);
    end generate generate_lfsr;
  end generate generate_ppl;

 LSFRPipe: process (clock, reset_N)
 begin
   if reset_N = '0' then
      reg_i <= seed;
      Delay_B0 <= (others => '0');
      Delay_B1 <= (others => '0');
      Delay_B2 <= (others => '0');
    else
      if (clock'event and clock = '1') then
        if start_run = '1' then
          reg_i <= data_in;
          Delay_B0 <= linear_feedback(0,63);
          Delay_B1 <= linear_feedback(1,63);
          Delay_B2 <= linear_feedback(2,63);
        elsif reset_run = '1' Then
          reg_i <= time_shift_seed(0);
          Delay_B0 <= time_shift_seed(1);
          Delay_B1 <= time_shift_seed(2);
          Delay_B2 <= time_shift_seed(3);
        end if;
      end if;
    end if;
  end process;

 TimeShift: process (clock, reset_N)
 begin
   if reset_N = '0' then
     count_TS <= 0;
     time_shift_seed(0) <= (others => '0');
     time_shift_seed(1) <= (others => '0');
     time_shift_seed(2) <= (others => '0');
     time_shift_seed(3) <= (others => '0');
    else
      if (clock'event and clock = '1') then
        if preset = '1' then
           count_TS <= count_TS + 1;
           if(count_TS = 3) then time_shift_seed(3) <= linear_feedback(3,63);
           elsif(count_TS = 6) then time_shift_seed(2) <= linear_feedback(2,63);
           elsif(count_TS = 9) then time_shift_seed(1) <= linear_feedback(1,63);
           elsif(count_TS = 12) then
             time_shift_seed(0) <= linear_feedback(0,63);
             reset_run <= '1';
             count_TS <= 0;
          end if;
        else reset_run <= '0';
        end if;
      end if;
    end if;
  end process;

  SecureSend : process (clock, reset_N)
  begin
    if reset_N = '0' then
      count_SS <= 0;
     else
       if (clock'event and clock = '1') then
        if secure_send = '1' then
          count_SS <= count_SS + 1;
          if (count_SS = 3) then
            count_SS <= 0;
            secure_send <= '0';
          end if;
        elsif start = '1' then
          secure_send <= '1';
          count_SS <= count_SS + 1;
        end if;
      end if;
     end if;
   end process;


end arch_lfsr;
