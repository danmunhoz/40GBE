--#############################################################################
--
--   módulo serial com autobaud - versão sem CTS nem RTS!
--  
--    clock     -- clock
--    reset     -- reset (ativo em 0)
--    rx_data   -- byte a ser transmitido para o pc
--    rx_start  -- indica byte disponivel no rx_data (ativo em 1) 
--    rx_busy   -- fica em '1' enquando envia ao PC (do rx_start ao fim)
--    rxd       -- envia dados pela serial
--    txd       -- dados vindos da serial
--    tx_data   -- barramento que contem o byte que vem do pc
--    tx_av     -- indica que existe um dado disponivel no tx_data
-- 
--          +------------------+
--          | SERIAL           |                   
--          |    +--------+    |
--     TXD  |    |        |    |
--     --------->|        |=========> tx_data (8bits)
--          |    | TRANS. |    |
--          |    |        |---------> tx_av
--          |    |        |    |
--          |    +--------+    |
--          |                  |
--          |    +--------+    |
--          |    |        |    |
--     RXD  |    |        |<========== rx_data (8bits)
--     <---------| RECEP. |<---------- rx_start
--          |    |        |----------> rx_busy
--          |    |        |    |
--          |    +--------+    |
--          +------------------+
--
--  Revisado por Fernando Moraes em 20/maio/2002
--
--#############################################################################

--*******************************************************************   
--   módulo serial
--*******************************************************************   
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity serial_interface is

generic (

    enable_simulation : boolean := false
);

port(
    clock: in std_logic;                        
    reset: in std_logic;                        
    rx_data: in std_logic_vector (7 downto 0);  
    rx_start: in std_logic;                     
    rx_busy: out std_logic;                     
    rxd: out std_logic;                         
    txd: in std_logic;                          
    tx_data: out std_logic_vector (7 downto 0); 
    tx_av: out std_logic                        
  );
end serial_interface;
 
architecture serial_interface of serial_interface is

 -- geracao do clock da serial    
 signal ck_cycles  : STD_LOGIC_VECTOR(13 downto 0);      
 signal contador   : STD_LOGIC_VECTOR(13 downto 0);
 signal serial_clk : STD_LOGIC; 
 -- recepção
 signal word, busy : STD_LOGIC_VECTOR (8 downto 0);
 signal go         : STD_LOGIC;
 -- transmissão
 signal regin     : STD_LOGIC_VECTOR(9 downto 0);   -- 10 bits:  start/byte/stop
 signal resync, r : STD_LOGIC;
begin                                                                            
    

    -- configuracao para baudrate 115200 
    -- quando em modo de simulação, o baudrate é aumentado para acelerar o processo.
    ck_cycles(11 downto 0) <= x"2A6" when enable_simulation = false else x"002" ; -- configuracao para 115200
    ck_cycles(13 downto 12) <= "00" when enable_simulation = false else "00" ; -- configuracao para 115200


   --#############################################################################
   -- geracao do clock para a serial. de tempos em tempos ele e' resincronizado
   -- para ajuste da recepcao dos dados procenientes do PC  
   --#############################################################################
    process(resync, clock, reset)
    begin 
        if resync='1' or reset = '0' then
            contador <= (0=>'1', others=>'0');
            serial_clk <='0';

        elsif falling_edge(clock) then

            if contador = ck_cycles then
                serial_clk <= not serial_clk;
                contador <= (0=>'1', others=>'0');

            else
                contador <= contador + 1;

            end if;
        end if;
    end process;
                                 
   --#############################################################################
   -- ENVIO DOS DADOS: DESTINO hardware do usuário, sinais tx_data (byte) e tx_av
   --#############################################################################

   -- registrador de deslocamento que lê o dado vindo da serial. TODOS OS
   -- bits em um no momento da detecção do resync (start bit)
    process (resync, serial_clk)
    begin
        if  resync = '1' then 
            regin <= (others=>'1');

        elsif rising_edge(serial_clk) then
            regin <= txd & regin(9 downto 1);

        end if;
    end process;
  
   -- *****  detecta o start bit, gerando o sinal de resincronismo ******* --
    process (clock, ck_cycles,reset)
    begin
        if ck_cycles = 0 or reset = '0' then 
            r <= '0';
            resync <= '1';
            tx_data <= (others=>'0'); 
            tx_av <= '0';

        elsif rising_edge(clock) then

            if r = '0' and txd = '0' then  --- start bit
                r <= '1';
                resync <= '1';    
                tx_av <= '0';

            elsif r = '1' and regin(0) = '0' then  --- start bit chegou no último bit
                r <= '0';
                tx_data <= regin(8 downto 1); 
                tx_av <= '1';

            else
                resync <= '0'; 
                tx_av <= '0';

            end if;
        end if;
    end process;
  
   --#############################################################################
   -- PARTE RELATIVA À RECEPÇÃO DOS DADOS: DESTINO PC, sinais rxd e rxd_busy
   --#############################################################################
 
   -- registrador de desolocamento que fica colocando sempre '1' na linha de dados
   -- quando o usuário requer dados (pulso em rx_start) é colocado o start bit e o
   -- byte a ser transmitido
    process(rx_start, reset, serial_clk)
    begin     
        if rx_start='1' or reset='0' then   
            go <= rx_start;
            rx_busy <= rx_start;
            word <= (others=>'1');
            if reset='0' then
                busy <= (others=>'0');
            else
                busy <= (others=>'1');
            end if;

        elsif rising_edge(serial_clk) then
            go <= '0';  -- desce o go um ciclo depois
            if go='1' then      
                word <= rx_data & '0';   -- armazena o byte que é enviado à serial 
                busy <= (8=>'0', others=>'1');
            else
                word <= '1' & word(8 downto 1); 
                busy <= '0' & busy(8 downto 1); 
                rx_busy <= busy(0);
            end if;
        end if; 
    end process;    
    
    rxd <= word(0);   -- bit de saida, que vai para o PC
   
end serial_interface;