--   Control Interface 
--   
--  
--
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
    use xil_defaultlib.common_pkg.all;

entity control_interface is
    Port (  clock       : in std_logic;
            areset      : in std_logic;
            
            -- serial transmission
            tx_data     : out std_logic_vector(7 downto 0);     -- data to UART Serial
            tx_start    : out std_logic;                        -- start UART tx (pulse)
            tx_busy     : in std_logic;                         -- tx transmitting (busy) 
            
            -- serial reception
            rx_data     : in std_logic_vector(7 downto 0);      -- data from UART Serial
            rx_av       : in std_logic;                         -- rx data available
            
            -- interface with XGETH_TESTER (uPC Interface)
            addr_out_r  : out vector12_type(3 downto 0);    -- uPC interface read address  
            addr_out_w  : out vector12_type(3 downto 0);    -- uPC interface write address
            data_out    : out vector16_type(3 downto 0);     -- data to uPC interface
            data_in     : in  vector16_type(3 downto 0);    -- data from uPC interface
            wen         : out std_logic_vector(3 downto 0); -- write enable
            ren         : out std_logic_vector(3 downto 0)  -- read  enable

            );
end control_interface;

architecture control_interface of control_interface is

    type STATE_TYPE is (S_IDLE , 
                        S_RESET,
                        S_RDH,   -- Read Data High
                        S_RDL,   -- Read Data Low
                        S_RAH,   -- Read Address High
                        S_RAL,   -- Read Address Low
                        S_W,     -- Write uPC Int Reg
                        S_R,     -- Read from uPC Int Reg
                        S_TXH,   -- Transmit data high to UART Interface 
                        S_TXL,   -- Transmit data low to UART Interface 
                        S_BUSY_H,-- Waits until transmission is done
                        S_BUSY_L  
                        );

    
    signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

    signal tester_addr,reg_addr: std_logic_vector(7 downto 0);
    signal data  : std_logic_vector(15 downto 0);
    signal op_reg : std_logic;

begin

    -- process commands from LUA
    -- example write: WFFFF0000
    -- example read : RFFFF
   

    STATE_PROC : process (clock, areset)
    begin
        if areset = '1' then
            CURRENT_STATE <= S_RESET;
        elsif rising_edge(clock) then 
            CURRENT_STATE <=  NEXT_STATE;
        end if;

    end process;

    COMMAND_RECEPTION: process(clock, areset)

    begin

        if areset = '1' then
   
            NEXT_STATE <= S_RESET;
   
            --data_received <= (others => '0');
            tester_addr <= (others => '0');
            reg_addr <= (others => '0');
            data <= (others => '0');

        elsif rising_edge(clock) then

            --NEXT_STATE <= CURRENT_STATE;
            wen <= (others=>'0');
            ren <= (others=>'0');
            tx_start <= '0';
            
            case CURRENT_STATE is
                
                when S_RESET =>     
                    NEXT_STATE <= S_IDLE;      
               
                when S_IDLE =>
                    tester_addr <= (others => '0');
                    reg_addr <= (others => '0');
                    data <= (others => '0');
                    
                    if rx_av = '1' then -- Waits until data available from UART   
                        if (rx_data = "01010111" or rx_data = "01110111") then --   ASCII 'W' (lower or upper case)
                            op_reg <= '1'; -- Write Operation
                            NEXT_STATE <= S_RAH;
                        elsif (rx_data = "01010010" or rx_data = "01110010") then --   ASCII 'R' (lower or upper case)
                            op_reg <= '0'; -- Read Operation
                            NEXT_STATE <= S_RAH;
                        end if;
                    end if;

                when S_RAH => 
                    if rx_av = '1' then
                        tester_addr <= rx_data; -- Store byte with address high
                        NEXT_STATE <= S_RAL;
                    end if;

                when S_RAL =>
                    if rx_av = '1' then 
                        reg_addr <= rx_data; -- Store byte with address low
                       if op_reg <= '0' then
                            NEXT_STATE <= S_R;
                       else 
                            NEXT_STATE <= S_RDH;
                       end if;
                    end if;

                when S_RDH =>
                    if rx_av = '1' then 
                        data(15 downto 8) <= rx_data; -- Store byte with data high 
                        NEXT_STATE <= S_RDL;
                    end if;

                when S_RDL =>
                    if rx_av = '1' then  
                        data(7 downto 0) <= rx_data; -- Store byte with data low       
                        NEXT_STATE <= S_W;    
                    end if;
                
                when S_W =>
                    NEXT_STATE <= S_IDLE;
                    if tester_addr  < x"04" then -- guarantees that data will be written only if address is correct
                        addr_out_w  (to_integer(unsigned(tester_addr))) <= (x"0" & reg_addr(7 downto 0));
                        data_out    (to_integer(unsigned(tester_addr))) <= data;
                        wen         (to_integer(unsigned(tester_addr))) <= '1';  
                    end if;
                
                when S_R =>
                   NEXT_STATE <= S_TXH;
                   addr_out_r    (to_integer(unsigned(tester_addr))) <= (x"0" & reg_addr(7 downto 0));
                   data_out      (to_integer(unsigned(tester_addr))) <= data;
                   ren           (to_integer(unsigned(tester_addr))) <= '1';
                  
                    
                when S_TXH =>
                   NEXT_STATE <= S_BUSY_H;
                   tx_data <= data_in(to_integer(unsigned(tester_addr)))(15 downto 8);
                   tx_start <= '1';    
                   
                
                when S_BUSY_H =>
                    if tx_busy = '0' then
                        NEXT_STATE <= S_TXL; 
                    end if;
                    
                when S_TXL =>
                   tx_data <= data_in(to_integer(unsigned(tester_addr)))(7 downto 0);
                   tx_start <= '1';
                   NEXT_STATE <= S_BUSY_L;
                
                when S_BUSY_L =>
                    if tx_busy = '0' then
                        NEXT_STATE <= S_IDLE; 
                    end if;
                    
                when others =>
                        NEXT_STATE <= S_RESET;
                end case;
    
            end if;
        end process;

end control_interface;