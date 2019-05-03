--////////////////////////////////////////////////////////////////////////
--////                                                                ////
--//// File name "tester_4xgth.vhd"                                   ////
--////                                                                ////
--//// This file is part of "Testset X40G" project                    ////
--////                                                                ////
--//// Author(s):                                                     ////
--//// - Matheus Lemes Ferronato                                      ////
--////                                                                ////
--////////////////////////////////////////////////////////////////////////

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity TB_4XGTH is


end TB_4XGTH;

architecture ARCH_TB_4XGTH of TB_4XGTH is
  type array_data64_type  is array (0 to 3) of std_logic_vector (63 downto 0);
  type array_data32_type  is array (0 to 1) of std_logic_vector (31 downto 0);
  type array_address_type is array (0 to 3) of std_logic_vector (6 downto 0);
  type array_header_type  is array (0 to 3) of std_logic_vector (1 downto 0);
  type array_bit_type   is array (0 to 3) of std_logic;

  signal clk_156                 : std_logic := '0'; -- Clock 156.25 MHz
  signal clk_250                 : std_logic := '0'; -- Clock 156.25 MHz
  signal tx_clk161               : std_logic := '0';
  signal rx_clk161               : std_logic := '0';
  signal clk_312                 : std_logic := '0'; -- Clock 312 MHz
  signal clk_312_n               : std_logic := '0';
  signal rst_n                   : std_logic; -- Reset (Active Hi
  signal async_reset_n           : std_logic;
  signal reset_tx_n              : std_logic;
  signal reset_rx_n              : std_logic;

 signal RDEN_FIFO_PCS40         : std_logic;

 signal tx_data_0               : array_data64_type;
 signal tx_data_1               : array_data64_type;
 signal tx_data_2               : array_data64_type;
 signal tx_data_3               : array_data64_type;
 signal tx_header_0             : array_header_type;
 signal tx_header_1             : array_header_type;
 signal tx_header_2             : array_header_type;
 signal tx_header_3             : array_header_type;
 signal tx_valid_0              : array_bit_type;
 signal tx_valid_1              : array_bit_type;
 signal tx_valid_2              : array_bit_type;
 signal tx_valid_3              : array_bit_type;

 signal start_fifo               : std_logic;
 signal start_fifo_rd            : std_logic;

 signal xgeth_waddr              :  array_address_type;
 signal xgeth_wdata              :  array_data32_type;
 signal xgeth_raddr              :  array_address_type;
 signal xgeth_rdata              :  array_data32_type;
 signal xgeth_wen                :  std_logic_vector(1 downto 0);

 signal eth_rx_los               :  array_bit_type;
 signal on_frame_sent            :  array_bit_type;
 signal on_frame_received        :  array_bit_type;
 signal verify_system            :  array_bit_type;
 signal linkstatus               :  array_bit_type;

 signal pkt_rx_avail_in          : std_logic;
 signal start_tx_begin_delay     : std_logic;
 signal start_tx_begin           : std_logic := '0';

 signal index                     : std_logic_vector(6 downto 0) := (others => '0');
 signal xgeth_wdata_0_reg         : std_logic_vector(31 downto 0);
 signal xgeth_wdata_1_reg         : std_logic_vector(31 downto 0);

 type reg_values is array (0 to 28) of std_logic_vector(31 downto 0);

 constant reg_values_0_in: reg_values := (x"00000000", x"00000000", x"000005EE", x"0000000A", x"00000010",
    x"00000000", x"00000000",   x"00AA11BB", x"000022CC", x"AA00BB11", x"0000CC22", x"0ABCDE01", x"0ABCDE02",
    x"0000000A",   x"00000000", x"00000003", x"0000000C", x"00000000", x"00000000", x"00000000", x"00000000",
    x"00000000", x"00000000",x"00000000", x"0000002E", x"00000032", x"00000001", x"00000001", x"00000000");

 constant reg_values_1_in: reg_values := (x"00000000", x"00000000", x"000005EE", x"0000000A", x"00000010",
  x"00000000", x"00000000",   x"AA00BB11", x"0000CC22", x"00AA11BB", x"000022CC",  x"0ABCDE02", x"0ABCDE01",
  x"0000000A",   x"00000000", x"00000003", x"0000000C",x"00000000", x"00000000", x"00000000", x"00000000",
  x"00000000", x"00000000" , x"00000000", x"0000002E", x"00000032", x"00000001", x"00000001", x"00000000");

  signal estado : std_logic;

begin
  --///////////////////////////////////////////////////////////////////////////////////////////////////
  --//STIMULUS GENERATOR///////////////////////////////////////////////////////////////////////////////
  --///////////////////////////////////////////////////////////////////////////////////////////////////

    tx_clk161  <= not tx_clk161 after 3.10559006 ns;
    rx_clk161  <= not tx_clk161 after 3.10559006 ns;
    tx_clk161  <= not tx_clk161 after 3.10559006 ns;
    clk_312    <= not clk_312 after 1.6 ns;
    clk_312_n  <= not clk_312;
    clk_250    <= not clk_250 after 2 ns;

    clock156: process (clk_312)
    begin
      if rising_edge(clk_312) then
        clk_156 <= not clk_156;
      end if;
    end process;

    rst_n           <= '0','1' after 35 ns;
    async_reset_n   <= '0','1' after 35 ns;
    reset_tx_n      <= '0','1' after 40 ns;
    reset_rx_n      <= '0','1' after 40 ns;
    pkt_rx_avail_in <= '0','1' after 5000 ns;
    start_fifo      <= '0', '1' after 65 ns;
    start_fifo_rd   <= '0', '1' after 150 ns;  -- Tanauan, testando repeticao mii
    RDEN_FIFO_PCS40 <= '0', '1' after 4000 ns;

    xgeth_wdata(0)  <= reg_values_0_in(to_integer(unsigned(index)));
    xgeth_wdata(1)  <= reg_values_1_in(to_integer(unsigned(index)));
    xgeth_waddr(0)  <= index;
    xgeth_waddr(1)  <= index;

    regs_iterator : process(clk_250, rst_n)
    begin
      if rst_n = '0' then
        estado            <= '0';
        index             <= (others => '0');
        xgeth_wdata_0_reg <= (others => '0');
        xgeth_wdata_1_reg <= (others => '0');
        xgeth_wen         <= "00";
      elsif (rising_edge(clk_250)) then
        if (estado = '0') then
          xgeth_wen         <= "11";
          estado <= '1';
        elsif index < 28 then
          index <= index + '1';
        else
          xgeth_wen <= "00";
        end if;
      end if;
    end process;


    --///////////////////////////////////////////////////////////////////////////////////////////////////
    --//TESTER 0 ////////////////////////////////////////////////////////////////////////////////////////
    --///////////////////////////////////////////////////////////////////////////////////////////////////

    TESTER_0  : entity work.TESTER_4XGTH
    port map(

      -- CLOCKS

      clk_156             =>clk_156,
      rx_clk161           =>rx_clk161,
      tx_clk161           =>tx_clk161,
      clk_250             =>clk_250,
      clk_312             =>clk_312,
      clk_312_n           =>clk_312_n, -- Clock 312 MHz
      pkt_rx_avail_in =>  pkt_rx_avail_in,

      --reset

      rst_n               =>rst_n, -- Reset (Active High);
      async_reset_n       =>async_reset_n,
      reset_tx_n          =>reset_tx_n, -- Reset (Active High);
      reset_rx_n          =>reset_rx_n, -- Reset (Active High);

      -- uPC interface

      xgeth_waddr         =>xgeth_waddr(0),
      xgeth_wdata         =>xgeth_wdata(0),
      xgeth_raddr         =>xgeth_waddr(0),
      xgeth_rdata         =>xgeth_rdata(0),
      xgeth_wen           =>xgeth_wen(0),

      eth_rx_los          =>eth_rx_los(0),

      on_frame_sent       =>on_frame_sent(0),
      on_frame_received   =>on_frame_received(0),
      verify_system       =>verify_system(0),

      -- RX

    --Labe Reorder
    --INPUTS
      rx_data_in_0        =>tx_data_0(1),
      rx_data_in_1        =>tx_data_1(1),
      rx_data_in_2        =>tx_data_2(1),
      rx_data_in_3        =>tx_data_3(1),
      rx_header_in_0      =>tx_header_0(1),
      rx_header_in_1      =>tx_header_1(1),
      rx_header_in_2      =>tx_header_2(1),
      rx_header_in_3      =>tx_header_3(1),
      rx_valid_in_0       =>tx_valid_0(1),
      rx_valid_in_1       =>tx_valid_1(1),
      rx_valid_in_2       =>tx_valid_2(1),
      rx_valid_in_3       =>tx_valid_3(1),

      --PCS_RX
      --inputs
      RDEN_FIFO_PCS40     =>RDEN_FIFO_PCS40,
      start_fifo          =>start_fifo,
      start_fifo_rd       =>start_fifo_rd,
      linkstatus_out      =>linkstatus(0),

      -- TX

      tx_data_out_0       =>tx_data_0(0),
      tx_data_out_1       =>tx_data_1(0),
      tx_data_out_2       =>tx_data_2(0),
      tx_data_out_3       =>tx_data_3(0),
      tx_header_out_0     =>tx_header_0(0),
      tx_header_out_1     =>tx_header_1(0),
      tx_header_out_2     =>tx_header_2(0),
      tx_header_out_3     =>tx_header_3(0),
      tx_valid_out_0      =>tx_valid_0(0),
      tx_valid_out_1      =>tx_valid_1(0),
      tx_valid_out_2      =>tx_valid_2(0),
      tx_valid_out_3      =>tx_valid_3(0),

      TBD_0               => "11",
      TBD_1               => '0'
    );

    --///////////////////////////////////////////////////////////////////////////////////////////////////
    --//TESTER 1 ////////////////////////////////////////////////////////////////////////////////////////
    --///////////////////////////////////////////////////////////////////////////////////////////////////

    TESTER_1  : entity work.TESTER_4XGTH
    port map(

      -- CLOCKS

      clk_156             =>clk_156,
      rx_clk161           =>rx_clk161,
      tx_clk161           =>tx_clk161,
      clk_250             =>clk_250,
      clk_312             =>clk_312,
      clk_312_n           =>clk_312_n, -- Clock 312 MHz
      pkt_rx_avail_in =>  pkt_rx_avail_in,

      --reset

      rst_n               =>rst_n, -- Reset (Active High);
      async_reset_n       =>async_reset_n,
      reset_tx_n          =>reset_tx_n, -- Reset (Active High);
      reset_rx_n          =>reset_rx_n, -- Reset (Active High);

      -- uPC interface

      xgeth_waddr         =>xgeth_waddr(1),
      xgeth_wdata         =>xgeth_wdata(1),
      xgeth_raddr         =>xgeth_waddr(1),
      xgeth_rdata         =>xgeth_rdata(1),
      xgeth_wen           =>xgeth_wen(1),

      eth_rx_los          =>eth_rx_los(1),

      on_frame_sent       =>on_frame_sent(1),
      on_frame_received   =>on_frame_received(1),
      verify_system       =>verify_system(1),

      -- RX

    --Labe Reorder
    --INPUTS
      rx_data_in_0        =>tx_data_0(0),
      rx_data_in_1        =>tx_data_1(0),
      rx_data_in_2        =>tx_data_2(0),
      rx_data_in_3        =>tx_data_3(0),
      rx_header_in_0      =>tx_header_0(0),
      rx_header_in_1      =>tx_header_1(0),
      rx_header_in_2      =>tx_header_2(0),
      rx_header_in_3      =>tx_header_3(0),
      rx_valid_in_0       =>tx_valid_0(0),
      rx_valid_in_1       =>tx_valid_1(0),
      rx_valid_in_2       =>tx_valid_2(0),
      rx_valid_in_3       =>tx_valid_3(0),

      --PCS_RX
      --inputs
      RDEN_FIFO_PCS40     =>RDEN_FIFO_PCS40,
      start_fifo          =>start_fifo,
      start_fifo_rd       =>start_fifo_rd,
      linkstatus_out      =>linkstatus(1),

      -- TX

      tx_data_out_0       =>tx_data_0(1),
      tx_data_out_1       =>tx_data_1(1),
      tx_data_out_2       =>tx_data_2(1),
      tx_data_out_3       =>tx_data_3(1),
      tx_header_out_0     =>tx_header_0(1),
      tx_header_out_1     =>tx_header_1(1),
      tx_header_out_2     =>tx_header_2(1),
      tx_header_out_3     =>tx_header_3(1),
      tx_valid_out_0      =>tx_valid_0(1),
      tx_valid_out_1      =>tx_valid_1(1),
      tx_valid_out_2      =>tx_valid_2(1),
      tx_valid_out_3      =>tx_valid_3(1),
      TBD_0               => "10",
      TBD_1               => '0'
    );
end ARCH_TB_4XGTH;
