library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity i2c_interface is
     Port ( clock       : in std_logic;
            reset       : in std_logic;
            SDA         : inout std_logic;
            SCL         : inout std_logic;
            i2c_ok      : out std_logic_vector(1 downto 0);
            i2c_ack     : out std_logic_vector(1 downto 0)
        );
end i2c_interface;

architecture i2c_interface of i2c_interface is

    type STATE_TYPE is (IDLE, S_INIT, S_W1, S_W2, S_W3, S_W00, S_W0, S_W4, S_W5, S_W6, S_W7, S_W8, S_ADDR0, S_ADDR1, S_DATA, S_WAIT);
    signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

    subtype regflit_8 is std_logic_vector(7 downto 0);
    subtype regflit_7 is std_logic_vector(6 downto 0);
    type dataArray is array(0 to 42) of regflit_8;
    type addrArray is array(0 to 42) of regflit_7;

    signal ena_reg, rw_reg, busy_reg, ack_err_reg, sda_reg, scl_reg : std_logic;
    signal addr_reg : std_logic_vector(6 downto 0);
    signal data_wr_reg, data_rd_reg : std_logic_vector(7 downto 0);
    signal dataArr: dataArray;
    signal byteAddrArr: dataArray;


begin
    byteAddrArr(0) <=  x"00";     dataArr(0) <= x"54";    --  
    byteAddrArr( 1) <= x"01";     dataArr( 1) <= x"E4";    -- 
    byteAddrArr( 2) <= x"02";     dataArr( 2) <= x"42";    -- 
    byteAddrArr( 3) <= x"03";     dataArr( 3) <= x"15";    -- 
    byteAddrArr( 4) <= x"04";     dataArr( 4) <= x"92";    -- 
    byteAddrArr( 5) <= x"05";     dataArr( 5) <= x"ED";    -- 
    byteAddrArr( 6) <= x"06";     dataArr( 6) <= x"2D";    -- 
    byteAddrArr( 7) <= x"07";     dataArr( 7) <= x"2A";    -- 
    byteAddrArr( 8) <= x"08";     dataArr( 8) <= x"00";    -- 
    byteAddrArr( 9) <= x"09";     dataArr( 9) <= x"C0";    -- 
    byteAddrArr(10) <= x"0A";     dataArr(10) <= x"00";    -- 
    byteAddrArr(11) <= x"0B";     dataArr(11) <= x"40";    -- 
    byteAddrArr(12) <= x"13";     dataArr(12) <= x"29";    -- 
    byteAddrArr(13) <= x"14";     dataArr(13) <= x"3E";    -- 
    byteAddrArr(14) <= x"15";     dataArr(14) <= x"FF";    -- 
    byteAddrArr(15) <= x"16";     dataArr(15) <= x"DF";    -- 
    byteAddrArr(16) <= x"17";     dataArr(16) <= x"1F";    -- 
    byteAddrArr(17) <= x"18";     dataArr(17) <= x"3F";    -- 
    byteAddrArr(18) <= x"19";     dataArr(18) <= x"A0";    -- 
    byteAddrArr(19) <= x"1F";     dataArr(19) <= x"00";    -- 
    byteAddrArr(20) <= x"20";     dataArr(20) <= x"00";    -- 
    byteAddrArr(21) <= x"21";     dataArr(21) <= x"03";    -- 
    byteAddrArr(22) <= x"22";     dataArr(22) <= x"00";    -- 
    byteAddrArr(23) <= x"23";     dataArr(23) <= x"00";    -- 
    byteAddrArr(24) <= x"24";     dataArr(24) <= x"03";    -- 
    byteAddrArr(25) <= x"28";     dataArr(25) <= x"60";    -- 
    byteAddrArr(26) <= x"29";     dataArr(26) <= x"9C";    -- 
    byteAddrArr(27) <= x"2A";     dataArr(27) <= x"39";    -- 
    byteAddrArr(28) <= x"2B";     dataArr(28) <= x"00";    -- 
    byteAddrArr(29) <= x"2C";     dataArr(29) <= x"16";    -- 
    byteAddrArr(30) <= x"2D";     dataArr(30) <= x"37";    -- 
    byteAddrArr(31) <= x"2E";     dataArr(31) <= x"00";    -- 
    byteAddrArr(32) <= x"2F";     dataArr(32) <= x"16";    -- 
    byteAddrArr(33) <= x"30";     dataArr(33) <= x"37";    -- 
    byteAddrArr(34) <= x"37";     dataArr(34) <= x"00";    -- 
    byteAddrArr(35) <= x"83";     dataArr(35) <= x"1F";    -- 
    byteAddrArr(36) <= x"84";     dataArr(36) <= x"02";    -- 
    byteAddrArr(37) <= x"89";     dataArr(37) <= x"01";    -- 
    byteAddrArr(38) <= x"8A";     dataArr(38) <= x"0F";    -- 
    byteAddrArr(39) <= x"8B";     dataArr(39) <= x"FF";    -- 
    byteAddrArr(40) <= x"8E";     dataArr(40) <= x"00";    -- 
    byteAddrArr(41) <= x"8F";     dataArr(41) <= x"00";    -- 
    byteAddrArr(42) <= x"88";     dataArr(42) <= x"40";    -- 

    SDA <= sda_reg;
    SCL <= scl_reg;

    process(clock,reset)
    begin
        if reset = '1' then
            i2c_ack <= (others => '0');
        elsif rising_edge(clock) then
            if ack_err_reg = '1' then
                i2c_ack(0) <= '1';
            end if;
        end if;
    end process;

    I2C_MASTER : entity work.i2c_master

        port map (  clk         => clock,
                    reset_n     => not reset,
                    ena         => ena_reg,
                    addr        => addr_reg,
                    rw          => rw_reg,
                    data_wr     => data_wr_reg,
                    busy        => busy_reg,
                    data_rd     => data_rd_reg,
                    ack_error   => ack_err_reg,
                    sda         => sda_reg,
                    scl         => scl_reg );

    CURRENT_STATE <= IDLE when reset = '1' else NEXT_STATE;
    
    process(clock, reset)
        variable cont: integer := 0;
    begin
        if reset = '1' then
            NEXT_STATE <= IDLE;
            ena_reg <= '0';
            rw_reg <= '0';
            data_wr_reg <= (others => '0');
            addr_reg <= (others => '0');
            i2c_ok <= (others => '0');

        elsif rising_edge(clock) then            
            rw_reg <= '0';
            NEXT_STATE <= CURRENT_STATE;

            case CURRENT_STATE is
                when IDLE => 
                    if busy_reg = '0' and ack_err_reg = '0' then
                        NEXT_STATE <= S_INIT;
                    end if;

                when S_INIT => --mux  PCA9548
                    if busy_reg = '0' and ack_err_reg = '0' then
                        addr_reg <= "111" & x"4"; --0X74
                        data_wr_reg <= x"10"; 
                        ena_reg <= '1'; 
                        cont := 0; 
                        NEXT_STATE <= S_W00;
                    end if;              
                    
                when S_W00 => 
                    if busy_reg = '1' then
                       ena_reg <= '0';
                       NEXT_STATE <= S_W0;
                    end if;                     
                
                when S_W0 =>
 
                    if busy_reg = '0' and ack_err_reg = '0' then
                        addr_reg <= "110" & x"8"; --0x68
                        ena_reg <= '1';  
                        data_wr_reg <= byteAddrArr(cont);
                        NEXT_STATE <= S_W1;
                    end if;
                when S_W1 => --SI5324                    
                    if busy_reg = '0' and ack_err_reg = '0' then   
                        ena_reg <= '1';  
                        if cont = 0 then
                            i2c_ok(1) <= '1'; -- LED - Configurou MUX
			            end if;
                        NEXT_STATE <= S_W2;
                    end if;
                when S_W2 => --SI5324                    
                    if busy_reg = '1' and ack_err_reg = '0' then 
                        data_wr_reg <= dataArr(cont);
                        NEXT_STATE <= S_W3;
                    end if;
                when S_W3 => --SI5324
                    if busy_reg = '0' and ack_err_reg = '0' then
                        ena_reg <= '0';
                        NEXT_STATE <= S_W4;
                    end if;
                when S_W4 => 
                    if busy_reg = '1' and cont < 42 and ack_err_reg = '0' then
                        cont := cont + 1;
                        NEXT_STATE <= S_W0;
                    elsif cont = 42 then 
                        i2c_ok(0) <= '1'; -- Terminou configuração do si5324
                    end if;
                when others =>
            end case;
        end if;
    end process;

end i2c_interface;


