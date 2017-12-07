library ieee;
  use ieee.std_logic_1164.all;

use work.PCK_CRC32_D8.all;
use work.PCK_CRC32_D64.all;
use work.PCK_CRC32_D128.all;

entity crc_rx is
  port(
  -- INPUTS
  clk_312         : in std_logic;
  rst_n           : in std_logic;
  mac_data        : out std_logic_vector(127 downto 0);
  mac_sop         : out std_logic;
  mac_eop         : out std_logic_vector(4 downto 0);

  --OUTPUTS
  app_data        : out std_logic_vector(127 downto 0);
  app_sop         : out std_logic;
  app_eop         : out std_logic_vector(4 downto 0);
  crc_ok          : out std_logic
  );
end entity;

architecture behav_crc_rx of crc_rx is

  use_d128  : std_logic;
  use_d64   : std_logic;
  use_d8    : std_logic;

  crc_reg   : std_logic_vector(31 downto 0);
  d64_reg   : std_logic_vector(63 downto 0);  -- store higher 64 bits, so crc d8
                                             -- has time to perform calculations
  last_byte : std_logic_vector(2 downto 0);-- Inform last byte to inputed to crc
  valid_frame : std_logic;           -- 1 from SOP to EOP. Enables crc processes
  byte_cnt  : std_logic_vector(2 downto 0);

  crc_temp  : std_logic_vector(31 downto 0); --DEPOIS PENSA EM ALUMA COISA MELHOR
  data      : std_logic_vector(127 downto 0); --saida da fiifo???
  begin

    -- process to control crc modules and fifos
    control: process(clk_312, rst_n)
    begin

    end process;

    -- process to run crc calculations
    control: process(clk_312, rst_n)
    begin
      if rst_n = '0' then
        crc_reg <= (others=>'0');
        d64_reg <= (others=>'0');
        use_d8 <= '0';

      elsif clk_312'event and clk_312 = '1' then
        if use_d128 = '1' then                      -- free to use all input
          crc_reg <= nextCRC32_D128(data);
        elsif use_d64 = '1' then                    -- use only lower half of the input
          crc_reg <= nextCRC32_D64(data(63 downto 0));
          d64_reg <= data(127 downto 64);
          use_d8 <= '1';
        else
          -- use 8-bit data function
        end if;
      end if;
    end process;

    -- process to perform crc byte by byte using nextCRC32_D8
    control: process(clk_312, rst_n)
    begin
      if rst_n = '0' then
        byte_cnt <= (others=>'0');

      elsif clk_312'event and clk_312 = '1' then
        if use_d8 = '1' then
          crc_temp <= nextCRC32_D8(**********)
        end if;
      end if;
    end process;
end behav_crc_rx;
