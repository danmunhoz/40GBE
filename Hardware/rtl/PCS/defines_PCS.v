`ifdef DEFINES_LOADED

`else
  `define DEFINES_LOADED

 `define TPDB #0.1
 `define TPDA #0.1
 `define SD #0.1
 `define USE_BERT_80_64

// `define SCAN_FIX
`define PMA_SPEED "9_64"
//`define BUS_MODE_64
//`define INT_WIDTH_2B
 `define INT_WIDTH_4B
//`define FAB_WIDTH_2B
 `define FAB_WIDTH_4B
// `define FAB_WIDTH_8B
 
/*************  DON'T USE THESE, STRICTLY FOR DEBUGGING  *********************/ 
//`define SIMULATION
//`define PMA_MODE_28_20
//`define PMA_MODE_20_40
//`define PMA_LOOPBACK_20_40
//`define DEBUG_WIDTH
//`define INCLUDE_BLACK_BOX
//`define TOP_MGTS_ONLY
`define KILL_MGT_REFCLK
`define KILL_MGT_REFCLK2
/*************************  END DON'T USE THESE  *****************************/ 

// Define this if you want direct connection from RX to TX in loopback mode
//`define NO_MGT_LB_FIFO
 

/************************ Definitions for different PMA_SPEED modes *********/
// Define this if buswidth is going to be 8, 16, 32 or 64, else comment out


/******** Define this if implemantation uses 32/40 bit MGT interface ********/
// `define MGT_INTERFACE_DOUBLE_RATE


/***********  DON't USE THESE YET  *********************/
/* Define this if implemantation uses 16/20 bit MGT interface */
/***** Not implemented 10/13/03 *****/
//`define MGT_INTERFACE_QUAD_RATE
/* Define this if implemantation uses 8/10 bit MGT interface */
/***** Not implemented 10/13/03 *****/
//`define MGT_INTERFACE_OCT_RATE
/***********  END DON't USE THESE YET  *****************/



`ifdef BUS_MODE_64
/***********************  8, 16, 32 or 64  buswidth  ************************/
  `define BUS_W 	64
  `define BUS_W_DIV2 	32
  // `define BUS_W_80
  
  // Constants for BERT range
  `define BERT_CNT_RANGE0	29'd8 
  `define BERT_CNT_RANGE1	29'd15625 
  `define BERT_CNT_RANGE2	29'd3906250 
  `define BERT_CNT_RANGE3	29'd244140625 
  `define BERT_CNT_RANGE4	29'd238418579 

  `define BERT_LFSR_DEFVAL	64'hffffffffffffffff 

  // Constants for BERT error forcing
  `define BERT_FORCE_ERR1	64'h0000000000000100 
  `define BERT_FORCE_ERR2	64'h0010000000000010 
  `define BERT_FORCE_ERR3	64'h0010000000200010 
  `define BERT_FORCE_ERR4	64'h0010000003000010 
  `define BERT_FORCE_ERR5	64'h0010000003004010 
  `define BERT_FORCE_ERR6	64'h0010004003020010 
  `define BERT_FORCE_ERR7	64'h0010070003000010
  `define BERT_FORCE_ERR8	64'h1010040101012010 

  
`else
  /***********************  10, 20, 40 or 80  buswidth  ***************************/
  `define BUS_W 	80
  `define BUS_W_DIV2 	40
  `define BUS_W_80
  
  // Constants for BERT range
  `define BERT_CNT_RANGE0	29'd6 
  `define BERT_CNT_RANGE1	29'd12500 
  `define BERT_CNT_RANGE2	29'd3125000 
  `define BERT_CNT_RANGE3	29'd195312500 
  `define BERT_CNT_RANGE4	29'd190734863 

  `define BERT_LFSR_DEFVAL	80'hffffffffffffffffffff 

  // Constants for BERT error forcing
  `define BERT_FORCE_ERR1	80'h00000000000000000100 
  `define BERT_FORCE_ERR2	80'h00000010000000000010 
  `define BERT_FORCE_ERR3	80'h00000010000000200010 
  `define BERT_FORCE_ERR4	80'h00000010000003000010 
  `define BERT_FORCE_ERR5	80'h00000010000003004010 
  `define BERT_FORCE_ERR6	80'h00000010004003020010 
  `define BERT_FORCE_ERR7	80'h00000010070003000010
  `define BERT_FORCE_ERR8	80'h00001010040101012010 
`endif



// Define below if you want 2VP20 implementation with everyting else except GT10 MGTs
// MGTs are replaced with TX -> RX parallel loopback
// `define MK322_2VP20_IMPLEMENTATION


/* PCIF defines */
`define PCIF_START_SYMBOL 		8'h3a
`define PCIF_END_SYMBOL 		8'h3b
`define PCIF_TIMEOUT_COUNT 		16'h1000
`define DIV_LATCH_FOR_BAUD_RATE 	8'h10

/* GT10 defines */
`define GT10_CTRL_BUS_WIDTH   48            
`define GT10_PMA_CTRL_UNUSED   48'h000100000000            
`define GT10_PMA_DATA_UNUSED   64'd0  
/* Set RegStrobe to high */          
`define GT10_PMA_ATTR_UNUSED   16'h4000            

/* Register addresses */
`define REG_AD_VERSION   	0    
`define REG_AD_SYSCTRL   	1            
`define REG_AD_SYSSTAT   	2            
`define REG_AD_CLKCTRL   	3         
`define REG_AD_TEST   		4           
     
`define REG_AD_BERCTRL_T   	8            
`define REG_AD_BERSTAT0_T  	9            
`define REG_AD_BERSTAT1_T   	10            
`define REG_AD_PMACTRL_T   	11            
`define REG_AD_PMATXCTRL_T   	12           
`define REG_AD_PMARXCTRL_T   	13           
`define REG_AD_PMASTAT_T   	14           
`define REG_AD_TXFIXED64_T_D0  	15            
`define REG_AD_TXFIXED64_T_D1  	16           
`define REG_AD_TXFIXED64_T_D2  	17           
`define REG_AD_TXFIXED64_T_D3  	18           
`define REG_AD_RXFIXED64_T_D0  	19            
`define REG_AD_RXFIXED64_T_D1  	20            
`define REG_AD_RXFIXED64_T_D2  	21           
`define REG_AD_RXFIXED64_T_D3  	22           

`define REG_AD_BERCTRL_B   	24            
`define REG_AD_BERSTAT0_B   	25            
`define REG_AD_BERSTAT1_B   	26            
`define REG_AD_PMACTRL_B   	27            
`define REG_AD_PMATXCTRL_B   	28            
`define REG_AD_PMARXCTRL_B   	29            
`define REG_AD_PMASTAT_B   	30           
`define REG_AD_TXFIXED64_B_D0   31            
`define REG_AD_TXFIXED64_B_D1   32            
`define REG_AD_TXFIXED64_B_D2   33           
`define REG_AD_TXFIXED64_B_D3   34           
`define REG_AD_RXFIXED64_B_D0   35            
`define REG_AD_RXFIXED64_B_D1   36            
`define REG_AD_RXFIXED64_B_D2   37           
`define REG_AD_RXFIXED64_B_D3   38           

`define REG_AD_TXFIXED64_T_D4   39           
`define REG_AD_TXFIXED64_B_D4   40           
`define REG_AD_TXSEL	        41           


// Version control SW-version, BusWidth, mode, increment
// SW-version :	PC-interface version
// BusWidth : 	3'b000 = 64 bits
//		3'b001 = 32 bits
//		3'b010 = 16 bits
//		3'b011 = 8 bits
//		3'b100 = 80 bits
//		3'b101 = 40 bits
//		3'b110 = 20 bits
//		3'b111 = 10 bits
// Mode:	5 bit value from 0 - 31		
// Increment:	Implementation version		

`define CURRENT_VERSION		{4'b0001, 3'b000, 5'b01000, 4'b0001}           

/* Register Defaults */
`ifdef SIMULATION
  `define REG_DEF_BERCTRL       16'h0803
  `define REG_DEF_SYSCTRL       16'h0008
  `define REG_DEF_CLKCTRL       16'h0000
  `define REG_DEF_TEST          16'h0000
  `define REG_DEF_TXSEL		16'h0000
`else
  `define REG_DEF_BERCTRL   	16'h0800  
  `define REG_DEF_SYSCTRL   	16'h0000   
  `define REG_DEF_CLKCTRL   	16'h0000   
  `define REG_DEF_TEST   	16'h0000   
  `define REG_DEF_TXSEL		16'h0000
`endif

/* Data during Start of Packet and End of Packet*/
`ifdef FAB_WIDTH_8B
  `define SOP_DATA		64'h07070707070707fb
  `define SOP_CHARISK		8'h01
  `define EOP_DATA		64'h07070707070707fd
  `define EOP_CHARISK		8'hff
`else
  `define SOP_DATA		64'h07070707070707fb
  `define SOP_CHARISK		8'h01
  `define EOP_DATA		64'h07070707070707fd
  `define EOP_CHARISK		8'hff
`endif 

/* Register PMACTRL Default values 
						DEF_VAL				
user_POWERDOWN  	= PmaCtrl[0]		1'b1
user_LOOPBACK  		= PmaCtrl[2:1] 		2'b00
user_PMAINIT	  	= PmaCtrl[3] 		1'b0
user_ENCHANSYNC		= PmaCtrl[4] 		1'b0
user_ENMCOMMAALIGN  	= PmaCtrl[5] 		1'b0
user_ENPCOMMAALIGN  	= PmaCtrl[6] 		1'b0
user_REFCLKBSEL  	= PmaCtrl[7] 		1'b1
user_REFCLKSEL  	= PmaCtrl[8] 		1'b0
user_PMARXLOCKSEL  	= PmaCtrl[10:9] 	2'b00
*/
//`define REG_DEF_PMACTRL   	16'h0081
//`define REG_DEF_PMACTRL   	16'h0082
// RefClk and loopback
`define REG_DEF_PMACTRL   	16'h0000
   
/* Register PMATXCTRL Default values 
user_TXRESET	  	= PmaTxCtrl[15] 	1'b0
user_SOPENA	  	= PmaTxCtrl[13] 	1'b0
user_IDLE_ENA	  	= PmaTxCtrl[11] 	1'b0
user_TXBYPASS8B10B  	= PmaTxCtrl[11] 	1'b1
user_TXINHIBIT  	= PmaTxCtrl[10] 	1'b0 
user_TXGEARBOX64B66BUSE	= PmaTxCtrl[9] 		1'b0 
user_TXFORCECRCERR  	= PmaTxCtrl[8] 		1'b0 
user_TXINTDATAWIDTH  	= PmaTxCtrl[7:6] 	2'b10 (32 bits wide) 
user_TXDATAWIDTH  	= PmaTxCtrl[5:4] 	2'b11 (64 bits wide) 
user_TXSCRAM64B66BUSE  	= PmaTxCtrl[3] 		1'b0
user_TXENC8B10BUSE  	= PmaTxCtrl[2] 		1'b0 
user_TXENC64B66BUSE  	= PmaTxCtrl[1] 		1'b0 
user_TXPOLARITY  	= PmaTxCtrl[0] 		1'b0
*/

/* Register PMARXCTRL Default values
						DEF_VAL				
user_RXRESET  		= PmaRxCtrl[15] 	1'b0
user_RXSLIDE  		= PmaRxCtrl[11] 	1'b0
user_RXIGNOREBTF  	= PmaRxCtrl[10] 	1'b0 
user_RXCOMMADETUSE	= PmaRxCtrl[9] 		1'b0 
user_RXBLOCKSYNC64B66BUSE = PmaRxCtrl[8] 	1'b0 
user_RXINTDATAWIDTH  	= PmaRxCtrl[7:6] 	2'b10 (32 bits wide) 
user_RXDATAWIDTH  	= PmaRxCtrl[5:4] 	2'b11 (64 bits wide) 
user_RXDESCRAM64B66BUSE	= PmaRxCtrl[3] 		1'b0
user_RXDEC8B10BUSE  	= PmaRxCtrl[2] 		1'b0 
user_RXDEC64B66BUSE  	= PmaRxCtrl[1] 		1'b0 
user_RXPOLARITY  	= PmaRxCtrl[0] 		1'b0
*/

`ifdef BUS_MODE_64
  `ifdef FAB_WIDTH_1B
     // Set TXINTDATAWIDTH to 16 bits and TXDATAWIDTH to 8 bits by default
     // PmaTxCtrl[7:4] = 4'b0000
     `define REG_DEF_PMATXCTRL   	16'h0800
     `define REG_DEF_PMARXCTRL   	16'h0000
  `else 
     `ifdef FAB_WIDTH_2B
  	// Set TXINTDATAWIDTH to 16 bits and TXDATAWIDTH to 16 bits by default
        // PmaTxCtrl[7:4] = 4'b0001
        `define REG_DEF_PMATXCTRL   	16'h0810
        `define REG_DEF_PMARXCTRL   	16'h0010
     `else
        `ifdef FAB_WIDTH_4B
           `ifdef INT_WIDTH_2B
               // Set TXINTDATAWIDTH to 16 bits and TXDATAWIDTH to 32 bits 
               // PmaTxCtrl[7:4] = 4'b0010
               `define REG_DEF_PMATXCTRL 16'h0820
               `define REG_DEF_PMARXCTRL 16'h0020
           `else
               // Set TXINTDATAWIDTH to 32 bits and TXDATAWIDTH to 32 bits 
               // PmaTxCtrl[7:4] = 4'b1010
               `define REG_DEF_PMATXCTRL 16'h08a0
               `define REG_DEF_PMARXCTRL 16'h00a0
           `endif
        `else 
            // Set TXINTDATAWIDTH to 32 bits and TXDATAWIDTH to 64 bits 
            // PmaTxCtrl[7:4] = 4'b1011
            `define REG_DEF_PMATXCTRL 16'h08b0
            `define REG_DEF_PMARXCTRL 16'h00b0
        `endif
     `endif
  `endif
`else 
  `ifdef FAB_WIDTH_1B
     // Set TXINTDATAWIDTH to 20 bits and TXDATAWIDTH to 10 bits by default
     // PmaTxCtrl[7:4] = 4'b0100
     `define REG_DEF_PMATXCTRL   	16'h0840
     `define REG_DEF_PMARXCTRL   	16'h0040
  `else 
     `ifdef FAB_WIDTH_2B
  	// Set TXINTDATAWIDTH to 20 bits and TXDATAWIDTH to 20 bits by default
        // PmaTxCtrl[7:4] = 4'b0101
        `define REG_DEF_PMATXCTRL   	16'h0850
        `define REG_DEF_PMARXCTRL   	16'h0050
     `else
        `ifdef FAB_WIDTH_4B
           `ifdef INT_WIDTH_2B
               // Set TXINTDATAWIDTH to 20 bits and TXDATAWIDTH to 40 bits 
               // PmaTxCtrl[7:4] = 4'b0110
               `define REG_DEF_PMATXCTRL 16'h0860
               `define REG_DEF_PMARXCTRL 16'h0060
           `else
               // Set TXINTDATAWIDTH to 40 bits and TXDATAWIDTH to 40 bits 
               // PmaTxCtrl[7:4] = 4'b1110
               `define REG_DEF_PMATXCTRL 16'h08e0
               `define REG_DEF_PMARXCTRL 16'h00e0
           `endif
        `else 
            // Set TXINTDATAWIDTH to 40 bits and TXDATAWIDTH to 80 bits 
            // PmaTxCtrl[7:4] = 4'b1111
            `define REG_DEF_PMATXCTRL 16'h08f0
            `define REG_DEF_PMARXCTRL 16'h00f0
        `endif
     `endif
  `endif
`endif

  
`define REG_DEF_TXFIXED64_D0   	16'h0123   
`define REG_DEF_TXFIXED64_D1   	16'h4567   
`define REG_DEF_TXFIXED64_D2   	16'h89ab   
`define REG_DEF_TXFIXED64_D3   	16'hcdef   
`define REG_DEF_TXFIXED64_D4   	16'h048c   

`define MGT_TOP_0_SEL   	4'h0   
`define MGT_TOP_1_SEL   	4'h1   
`define MGT_TOP_2_SEL   	4'h2   
`define MGT_TOP_3_SEL   	4'h3   

`define REG_DEF_MGT_TX_SEL	16'h0

`endif
