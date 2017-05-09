////////////////////////////////////////////////////////////////////////
////                                ////
//// File name "10g_eth_tester_top.v"                 ////
////                                ////
//// This file is part of the "Testset X10G" project        ////
//// testeset10g/design/10g_eth_tester_top              ////
////                                ////
//// Author(s):                           ////
//// - Bruno Goulart de Oliveira (bruno.goulart@acad.pucrs.br)    ////
////                                ////
//// Description: read document x10giga_eth_tester_functional.pdf   ////
////                                ////
////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps

//`include "../../xge_mac/rtl/include/utils.v"

module top (


);

  //NEWXGETH WIRES
    wire Q8_CLK0_GTREFCLK_PAD_N_IN;
    wire Q8_CLK0_GTREFCLK_PAD_N_IN_I;
    wire Q8_CLK0_GTREFCLK_PAD_P_IN;
    wire Q8_CLK0_GTREFCLK_PAD_P_IN_I;
    
    wire SYSCLK_IN_P;
    wire SYSCLK_IN_N;
    
    
    wire ETH1_MOD_DETECT;
    wire ETH1_RX_LOS;
    
    wire ETH2_MOD_DETECT;
    wire ETH2_RX_LOS;
    
    wire ETH3_MOD_DETECT;
    wire ETH3_RX_LOS;
    
    wire ETH4_MOD_DETECT;
    wire ETH4_RX_LOS;
    
   
   
    wire [1:0] ETH1_LED;
    wire [1:0] ETH2_LED;
    wire [1:0] ETH3_LED;
    wire [1:0] ETH4_LED;
    wire [1:0] BTN;
    wire I2C_MUX_RESET;            
    wire SFP_CLK_RST;
   
    
    wire ETH1_RX_P;   
    wire ETH1_RX_N;   
    wire ETH1_TX_P;   
    wire ETH1_TX_N;   
    
    wire ETH2_RX_P;   
    wire ETH2_RX_N;   
    wire ETH2_TX_P;   
    wire ETH2_TX_N;   
    
    wire ETH3_RX_P;   
    wire ETH3_RX_N;   
    wire ETH3_TX_P;   
    wire ETH3_TX_N;   
    
    wire ETH4_RX_P;   
    wire ETH4_RX_N;   
    wire ETH4_TX_P;   
    wire ETH4_TX_N;   

    reg     clk_156;
    reg     clk_200;          // period = 5.0ns
    reg     soft_reset;

    
    //Interface uPC

    parameter STATUS_ADDR              = 0;
    parameter RFC_TYPE_ADDR            = 1;
    parameter PKT_LENGTH_ADDR          = 2;
    parameter IDLE_NUMBER_ADDR         = 3;
    parameter PKT_NUMBER_L_ADDR        = 4;
    parameter PKT_NUMBER_H_ADDR        = 5;
    parameter TIMESTAMP_POS_L_ADDR     = 6;
    parameter TIMESTAMP_POS_H_ADDR     = 7;
    parameter MAC_SRC_L_ADDR           = 8;
    parameter MAC_SRC_M_ADDR           = 9;
    parameter MAC_SRC_H_ADDR           = 10;
    parameter MAC_DST_L_ADDR           = 11;
    parameter MAC_DST_M_ADDR           = 12;
    parameter MAC_DST_H_ADDR           = 13;
    parameter IP_SRC_L_ADDR            = 14;
    parameter IP_SRC_H_ADDR            = 15;
    parameter IP_DST_L_ADDR            = 16;
    parameter IP_DST_H_ADDR            = 17;
    parameter TIMEOUT_ADDR             = 18;
    parameter PKT_SEQUENCE_ADDR        = 19;

    parameter PKT_RX_L_ADDR            = 20;
    parameter PKT_RX_H_ADDR            = 21;
    parameter LATENCY_L_ADDR           = 22;
    parameter LATENCY_M_ADDR           = 23;
    parameter LATENCY_H_ADDR           = 24;


    // RFC
    wire initialize;
    wire [4:0] RFC_type;
    wire [15:0] IDLE_number;
    wire [15:0] TIMEOUT_number;
    wire [31:0] PKT_number;
    wire [31:0] PKT_timestamp_pos;
    wire [47:0] PKT_timestamp;
    wire [47:0] latency;
    wire [31:0] PKT_rx;
    wire [2:0]  PKT_length;
    wire verify_system_rec;
    wire RFC_end;
    wire RFC_ack;


    reg lose_pkt_start;
    reg [15:0] lose_pkt_skip;

    //Receiver to Client

    wire [47:0] mac_source_rx;
    wire [47:0] mac_destination_rx;
    wire [31:0] ip_source_rx;
    wire [31:0] ip_destination_rx;
    wire [2:0]  packet_length_rx;
    wire received_packet_rx;
    wire [47:0] time_stamp_rx;
    wire pkt_sequence_error;
    wire [7:0] pkt_sequence_in;

    // Latency related
    wire  [47:0] time_stamp_out;
    wire  end_latency;
    wire  time_stamp_flag;


    // UART 
    
    reg [7:0] rx_data = 0;
    reg rx_start = 0;
    wire rx_busy;
    wire UART_RXD_OUT;
    wire UART_TXD_IN;
    wire [7:0] tx_data;
    wire tx_av;
    

    int txXgmiiFile, rxXgmiiFile, txMACFile, rxMACFile;
    int rxRFCFile, logRFCFile, testRFCFile;

    int txXgmiiFifoFullFile;

    function int getSizePacketCODE(string bytes);

        case (bytes)

            "64":
                getSizePacketCODE = 0;
            "128":
                getSizePacketCODE = 1;
            "256":
                getSizePacketCODE = 2;
            "512":
                getSizePacketCODE = 3;
            "768":
                getSizePacketCODE = 4;
            "1024":
                getSizePacketCODE = 5;
            "1280":
                getSizePacketCODE = 6;
            "1518":
                getSizePacketCODE = 7;
            default:
                getSizePacketCODE = -1;

        endcase;

    endfunction




    task write_xgeth;

        input [15:0] data;
        input [11:0] addr;

        $fdisplay(logRFCFile,"Writing at register bank! Data = 0x%x | Address: 0x%02x",data,addr);

        rx_data = 8'h57; // Send Write Command 'W'
        
        rx_start = 1'b1;
        Wait156(1);     
        rx_start = 1'b0;
        Wait156(1);

        wait(!rx_busy);
        Wait156(1);
        
        rx_data =  {4'b0,addr[11:8]}; // Send addr high
        
        rx_start = 1'b1;
        Wait156(1);     
        rx_start = 1'b0;
        Wait156(1);
            
        wait(!rx_busy);
        Wait156(1);
        
        rx_data =  addr[7:0]; // Send addr low 
        
        rx_start = 1'b1;
        Wait156(1);     
        rx_start = 1'b0;
        Wait156(1); 
                
        wait(!rx_busy);
        Wait156(1);
        
        rx_data =  data[15:8]; // Send data high 
        
        rx_start = 1'b1;       
        Wait156(1);     
        rx_start = 1'b0;        
        Wait156(1);
        
        wait(!rx_busy);         
        Wait156(1);
         
        rx_data =  data[7:0]; // Send data low 
       
        rx_start = 1'b1;
        Wait156(1);     
        rx_start = 1'b0;
        Wait156(1);
        
        wait(!rx_busy);

    endtask

    task read_xgeth;
        
        input  [11:0] addr;
        output [15:0] data;
        input  string print_op;


        rx_data = 8'h52; // Send Write Command 'W'
        
        rx_start = 1'b1;
        Wait156(1);     
        rx_start = 1'b0;
        Wait156(1);

        wait(!rx_busy);
        Wait156(1);
        
        rx_data =  {4'b0,addr[11:8]}; // Send addr high
        
        rx_start = 1'b1;
        Wait156(1);     
        rx_start = 1'b0;
        Wait156(1);
            
        wait(!rx_busy);
        Wait156(1);
        
        rx_data =  addr[7:0]; // Send addr low 
        
        rx_start = 1'b1;
        Wait156(1);     
        rx_start = 1'b0;
        Wait156(1); 
                
        wait(tx_av);
        data[15:8] = tx_data;
        Wait156(1);
        
        wait(!tx_av);
        
        wait(tx_av);
        data[7:0] = tx_data;
        Wait156(1);
           
        wait(!tx_av);
       
        if(print_op == "ENABLE")
            $fdisplay(logRFCFile,"Reading at register bank! Data = 0x%x | Address: 0x%02x",data,addr);


    endtask




    assign ETH1_RX_P = ETH1_TX_P; 
    assign ETH1_RX_N = ETH1_TX_N;
    
    assign ETH2_RX_P = ETH2_TX_P; 
    assign ETH2_RX_N = ETH2_TX_N; 

    assign ETH3_RX_P = ETH3_TX_P;
    assign ETH3_RX_N = ETH3_TX_N;
   
    assign ETH4_RX_P = ETH4_TX_P;
    assign ETH4_RX_N = ETH4_TX_N;   

  
    assign ETH1_linkstatus = ETH1_LED[0];
    assign ETH2_linkstatus = ETH2_LED[0];
    assign ETH3_linkstatus = ETH3_LED[0];
    assign ETH4_linkstatus = ETH4_LED[0];

    assign ETH1_MOD_DETECT = 1'b1;
    assign ETH1_RX_LOS = 1'b0;
    
    assign ETH2_MOD_DETECT = 1'b1;
    assign ETH2_RX_LOS = 1'b0;

    assign ETH3_MOD_DETECT = 1'b1;
    assign ETH3_RX_LOS = 1'b0;
    
    assign ETH4_MOD_DETECT = 1'b1;
    assign ETH4_RX_LOS = 1'b0;
    
  
    /////////////////////////////////
    /////// INSTANCIATIONS //////////
    /////////////////////////////////

    GTH_tester SIM_GTH_tester
    (    
        .Q8_CLK0_GTREFCLK_PAD_N_IN             (Q8_CLK0_GTREFCLK_PAD_N_IN),
        .Q8_CLK0_GTREFCLK_PAD_P_IN             (Q8_CLK0_GTREFCLK_PAD_P_IN),
        .SYSCLK_IN_P                           (SYSCLK_IN_P),
        .SYSCLK_IN_N                           (SYSCLK_IN_N),
        .ETH1_LED                              (ETH1_LED),
        .ETH2_LED                              (ETH2_LED),
        .ETH3_LED                              (ETH3_LED),
        .ETH4_LED                              (ETH4_LED),
        .BTN                                   (BTN),
              
        .UART_RXD_OUT                          (UART_RXD_OUT),
        .UART_TXD_IN                           (UART_TXD_IN),
                          
        .I2C_MUX_RESET                         (I2C_MUX_RESET),            
        .SFP_CLK_RST                           (SFP_CLK_RST),
    
        .ETH1_RX_N                              (ETH1_RX_N),                                
        .ETH1_RX_P                              (ETH1_RX_P),                               
        .ETH1_TX_N                              (ETH1_TX_N),                                
        .ETH1_TX_P                              (ETH1_TX_P),
        
        .ETH2_RX_N                              (ETH2_RX_N),                                
        .ETH2_RX_P                              (ETH2_RX_P),                               
        .ETH2_TX_N                              (ETH2_TX_N),                                
        .ETH2_TX_P                              (ETH2_TX_P),
        
        .ETH3_RX_N                              (ETH3_RX_N),                                
        .ETH3_RX_P                              (ETH3_RX_P),                               
        .ETH3_TX_N                              (ETH3_TX_N),                                
        .ETH3_TX_P                              (ETH3_TX_P),
        
        .ETH4_RX_N                              (ETH4_RX_N),                                
        .ETH4_RX_P                              (ETH4_RX_P),                               
        .ETH4_TX_N                              (ETH4_TX_N),                                
        .ETH4_TX_P                              (ETH4_TX_P),
        
        .ETH1_RX_LOS                            (ETH1_RX_LOS),
        .ETH1_MOD_DETECT                        (ETH1_MOD_DETECT), 
        
        .ETH2_RX_LOS                            (ETH2_RX_LOS),
        .ETH2_MOD_DETECT                        (ETH2_MOD_DETECT),  
        
        .ETH3_RX_LOS                            (ETH3_RX_LOS),
        .ETH3_MOD_DETECT                        (ETH3_MOD_DETECT),  
        
        .ETH4_RX_LOS                            (ETH4_RX_LOS),
        .ETH4_MOD_DETECT                        (ETH4_MOD_DETECT)    
    );

     serial_interface #
    (
        .enable_simulation(1)               
    )
    SIM_serial_interface
    (
    
        .clock          (Q8_CLK0_GTREFCLK_PAD_N_IN),
        .reset          (!soft_reset),
        .rx_data        (rx_data),
        .rx_start       (rx_start),
        .rx_busy        (rx_busy),
        .rxd            (UART_TXD_IN),
        .txd            (UART_RXD_OUT),
        .tx_data        (tx_data),
        .tx_av          (tx_av)
    );
        

    ///////////////////////////////////
    //////// TASKS & FUNCTIONS ////////
    ///////////////////////////////////

    task WaitNS;
    input [31:0] delay;
        begin
            #(1000*delay);
        end
    endtask

    task WaitPS;
    input [31:0] delay;
        begin
            #(delay);
        end
    endtask
    
    task WaitUS;
    input [31:0] delay;
        begin
            #(1000000*delay);
        end
    endtask
        
        task Wait156;
    input [31:0] delay;
        begin
            #(6400*delay);
        end
    endtask

    ///////////////////////////////////
    //////// CLOCKS AND RESETS ////////
    ///////////////////////////////////

    // CLOCK 156.25 MHz
    initial begin
    clk_156    = 1'b0;
    //clk_xgmii_rx  = 1'b0;
    //clk_xgmii_tx  = 1'b0;
        forever begin
            WaitPS(3200);
            clk_156    = ~clk_156;
            //clk_xgmii_rx  = ~clk_xgmii_rx;
            //clk_xgmii_tx  = ~clk_xgmii_tx;
        end
    end
    
          // CLOCK 200MHZ
        initial begin
          clk_200  <= 1'b0;
          forever begin
                WaitPS(2500);
                clk_200  = ~clk_200;
            end
        end
    
    assign SYSCLK_IN_N = clk_200;
    assign SYSCLK_IN_P = ~clk_200;
    assign Q8_CLK0_GTREFCLK_PAD_N_IN =  clk_156;
    assign Q8_CLK0_GTREFCLK_PAD_P_IN = ~clk_156;
    
    assign BTN = {1'b0,soft_reset};

    ///////////////////////////////////
    // RFC Manager variables
    ///////////////////////////////////

    int    file_status;

    string TEST_name, TEST_type, TEST_PKT_type;
    string TEST_param, TEST_value;
    int    TEST_STATUS;
    int    TEST_RFC_type;
    int    TEST_PKT_number;
    int    TEST_IDLE_number;
    int    TEST_number;
    int    TEST_TIMEOUT_number;
    int    TEST_PKT_timestamp_pos;
    int    TEST_latency;
    int    TEST_time2recover;
    int    TEST_pkt_length;
    int    TEST_packet_length_code;
    int    TEST_client_latency;
    int    TEST_client_loss;
    int    TEST_client_tx_loss;

    real   TEST_throughtput = 0;
    real   TEST_init_rate;
    real   TEST_step_rate;
    real   TEST_frame_rate;
    real   TEST_last_rate;

    real   TEST_loss_perc;

    int    TEST_PKT_rx;
    int    TEST_timestamp;

    int    TEST_b2b_count;
    int    TEST_b2b_lock;
    int    TEST_b2b_max_burst;
    int    TEST_PKT_step;


    bit [47:0] TEST_mac_source = 0;
    bit [47:0] TEST_mac_destination = 0;
    int    TEST_ip_source;
    int    TEST_ip_destination;

    int    TEST_PKT_sequence;

    int    cont;


    ///////////////////////////////////

    initial begin
        //txXgmiiFifoFullFile <= $fopen ("tx_xgmii_fifofull.log");
        //txXgmiiFile    <= $fopen ("tx_xgmii_packets.log");
        //rxXgmiiFile    <= $fopen ("rx_xgmii_packets.log");
        //txMACFile      <= $fopen ("tx_mac_packets.log");
        //rxMACFile      <= $fopen ("rx_mac_packets.log");

        // TESTBENCH
        // Simulates external iteration with the test plaform.

        rxRFCFile = $fopen("RFC.conf","r");
        testRFCFile = $fopen("RFC.out");
        logRFCFile = $fopen("RFC.log");

        if(rxRFCFile == 0)
        begin
            $fdisplay(logRFCFile,"ERROR! Could not read input file in_RFC_settings.txt.");
            $finish;
        end
        

        //read first line of the conf. file
        file_status = $fscanf(rxRFCFile,"%s %d",TEST_param,TEST_number);

        //check first parameter
        if(TEST_param == "<N#TESTS>")
        begin
            $fdisplay(logRFCFile,"Reading %s...",TEST_param);
            $fdisplay(logRFCFile,"Number of tests: %d",TEST_number);
        end else
        begin
            $display("ERROR: Initially, you must define how many tests should be executed.");
            $fclose(rxRFCFile);
            $finish;
        end

        //main loop
        for(cont=0;cont<TEST_number;cont++)
        begin

            $fdisplay(logRFCFile,"\n============================================\n");

            $fdisplay(logRFCFile,"Gathering all parameters from RFC.conf");

            //read TEST name
            file_status = $fscanf(rxRFCFile,"%s",TEST_param);
            $fdisplay(logRFCFile,"Reading parameters for test %s...",TEST_param);

            file_status = $fscanf(rxRFCFile,"%s",TEST_param);
            $fdisplay(logRFCFile,"Parameter %s",TEST_param);


            // TEST loop
            while(TEST_param != "<END>")
            begin

                file_status = $fscanf(rxRFCFile,"%s",TEST_value);
                $fdisplay(logRFCFile,"Value: %s",TEST_value);

                // SIMULATION PARAMETERS
                case (TEST_param)

                    "<TYPE>":
                        TEST_type = TEST_value;
                    "<PKT_TYPE>":
                        TEST_PKT_type = TEST_value;
                    "<N#PACKETS>":
                        TEST_PKT_number = TEST_value.atoi();
                    "<S#PACKETS>":
                    begin
                        TEST_pkt_length = TEST_value.atoi();
                        TEST_packet_length_code = getSizePacketCODE(TEST_value);
                    end
                    "<INIT_TX>":
                        TEST_init_rate = TEST_value.atoi()/100;
                    "<STEP_TX>":
                        TEST_step_rate = TEST_value.atoi()/100;
                    "<TX_LOST>":
                        TEST_client_tx_loss = TEST_value.atoi()/100;
                    "<CLIENT_LOST>":
                        TEST_client_loss = TEST_PKT_number/(TEST_PKT_number*TEST_value.atoi()/100);
                    "<CLIENT_LATENCY>":
                    // retirado divisao por 6.4
                        TEST_client_latency = TEST_value.atoi();
                    "<TIMESTAMP>":
                        TEST_PKT_timestamp_pos = TEST_value.atoi();
                    "<TIMEOUT>":
                        TEST_TIMEOUT_number = TEST_value.atoi();
                    "<STEP_PACKETS>":
                        TEST_PKT_step = TEST_value.atoi();
                    "<CLIENT_B2B_MAX_BURST>":
                        TEST_b2b_max_burst = TEST_value.atoi();
                    "<SYS_RECOVERY_PKT_SEQUENCE>":
                        TEST_PKT_sequence = TEST_value.atoi();
                    "<THROUGHPUT_FRAME_RATE>":
                        TEST_throughtput = TEST_value.atoi()/100;
                    default:
                    begin
                        $fdisplay(logRFCFile,"Invalid argument %s",TEST_param);
                        $fclose(rxRFCFile);
                        $finish;
                    end

                endcase

                file_status = $fscanf(rxRFCFile,"%s",TEST_param);
                $fdisplay(logRFCFile,"Parameter %s",TEST_param);


            end

            $fdisplay(logRFCFile,"\n============================================\n");

            
            //reset
            //initialize = 1'b0;
            soft_reset = 1'b1;
        
            WaitUS(1);
            
            soft_reset = 1'b0;
            
            //WaitUS(39);            
           
            wait(ETH1_linkstatus && ETH2_linkstatus && ETH3_linkstatus && ETH4_linkstatus);

            $fdisplay(logRFCFile,"Link Status = OK!");

            case(TEST_PKT_type)

                "ARP":
                begin

                    TEST_RFC_type = 0;
                    TEST_frame_rate = 1;

                    $fdisplay(logRFCFile,"\n============================================");
                    $fdisplay(logRFCFile,"Sending ARP packet...");
                    $fdisplay(logRFCFile,"============================================\n");

                    lose_pkt_start = 0;
                    Wait156(2);
                    lose_pkt_skip = 0;
                    Wait156(2);

                    write_xgeth(TEST_IDLE_number,IDLE_NUMBER_ADDR);
                    write_xgeth(TEST_RFC_type,RFC_TYPE_ADDR);
                    write_xgeth(TEST_packet_length_code,PKT_LENGTH_ADDR);

                    TEST_STATUS = 3;

                    write_xgeth(TEST_STATUS,STATUS_ADDR);

                    do 
                    begin  
                        Wait156(10);
                        read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                    end 
                    while (TEST_STATUS != 0);
                    
                    $fdisplay(logRFCFile,"** ARP PACKET SENT! **",);
                    $fdisplay(testRFCFile,"[ARP] %d ARP packet sent.",TEST_PKT_number);

                end

                "ECHO":
                begin
                    case(TEST_type)

                        "throughput":
                        begin

                            //async_reset_n = 1'b0;
                            //WaitPS(3200);
                            //async_reset_n = 1'b1;
                            lose_pkt_start = 0;

                            TEST_STATUS = 10;
                            write_xgeth(TEST_STATUS,STATUS_ADDR);

                            do 
                            begin  
                                WaitNS(1);
                                read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                            end 
                            while (TEST_STATUS != 0);


                            write_xgeth(TEST_PKT_number[15:0],PKT_NUMBER_L_ADDR);
                            write_xgeth(TEST_PKT_number[31:16],PKT_NUMBER_H_ADDR);

                            write_xgeth(TEST_mac_source[15:0],MAC_SRC_L_ADDR);
                            write_xgeth(TEST_mac_source[31:16],MAC_SRC_M_ADDR);
                            write_xgeth(TEST_mac_source[47:32],MAC_SRC_H_ADDR);

                            write_xgeth(TEST_mac_destination[15:0],MAC_DST_L_ADDR);
                            write_xgeth(TEST_mac_destination[31:16],MAC_DST_M_ADDR);
                            write_xgeth(TEST_mac_destination[47:32],MAC_DST_H_ADDR);

                            write_xgeth(TEST_ip_source[15:0],IP_SRC_L_ADDR);
                            write_xgeth(TEST_ip_source[31:16],IP_SRC_H_ADDR);

                            write_xgeth(TEST_ip_destination[15:0],IP_DST_L_ADDR);
                            write_xgeth(TEST_ip_destination[31:16],IP_DST_H_ADDR);

                            write_xgeth(TEST_TIMEOUT_number,TIMEOUT_ADDR);


                            TEST_RFC_type = 0;
                            TEST_frame_rate = TEST_init_rate;

                            $fdisplay(logRFCFile,"\n============================================");
                            $fdisplay(logRFCFile,"Executing %s test - Initial frame rate: %2.f Mb/s",TEST_type,TEST_frame_rate*100);
                            $fdisplay(logRFCFile,"============================================\n");


                            lose_pkt_start = 0;
                            Wait156(2);
                            lose_pkt_skip = TEST_client_loss;
                            Wait156(2);

                            while(TEST_frame_rate < 100)
                            begin

                                if(TEST_frame_rate >= TEST_client_tx_loss)
                                begin
                                    $fdisplay(logRFCFile,"Preparing... Executing now at %2.f Mb/s (packet loss enabled)",TEST_frame_rate*100);
                                    lose_pkt_start = 0;
                                end
                                else
                                begin
                                    $fdisplay(logRFCFile,"Preparing... Executing now at %2.f Mb/s (packet loss disabled)",TEST_frame_rate*100);
                                    lose_pkt_start = 0;
                                end



                                TEST_IDLE_number = (TEST_pkt_length*100-TEST_pkt_length*TEST_frame_rate)/(12*TEST_frame_rate);
                                if(TEST_IDLE_number <= 0)
                                    break;

                                write_xgeth(TEST_IDLE_number,IDLE_NUMBER_ADDR);
                                write_xgeth(TEST_RFC_type,RFC_TYPE_ADDR);
                                write_xgeth(TEST_packet_length_code,PKT_LENGTH_ADDR);

                                TEST_STATUS = 1;

                                write_xgeth(TEST_STATUS,STATUS_ADDR);

                                do 
                                begin  
                                    WaitUS(1);
                                    read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                                end 
                                while (TEST_STATUS != 0);
                                
                                $fdisplay(logRFCFile,"** OPERATION IS OVER! **",);

                                read_xgeth(PKT_RX_L_ADDR,TEST_PKT_rx[15:0],"ENABLE");
                                read_xgeth(PKT_RX_H_ADDR,TEST_PKT_rx[31:16],"ENABLE");

                                $fdisplay(logRFCFile,"Packets received: %d",TEST_PKT_rx);
                                if(TEST_PKT_rx != TEST_PKT_number)
                                begin
                                    $fdisplay(logRFCFile,"The Receiver did not receive all packets!");

                                    TEST_frame_rate = TEST_last_rate;
                                    TEST_throughtput = TEST_frame_rate;
                                    $fdisplay(logRFCFile,"Max throughput rate: %2.f Mb/s",TEST_frame_rate*100);
                                    break;
                                end

                                $fdisplay(logRFCFile,"All packets were received at %2.f Mb/s",TEST_frame_rate*100);

                                TEST_last_rate = TEST_frame_rate;
                                TEST_frame_rate = TEST_frame_rate + TEST_step_rate;

                                Wait156(1);

                            end

                            if(TEST_frame_rate >= 100)
                                TEST_frame_rate = TEST_last_rate;

                            TEST_throughtput = TEST_frame_rate*100;
                            $fdisplay(testRFCFile,"[Throughput Test - RFC 2544]\nMax. Throughput rate: %2.f Mb/s",TEST_throughtput);

                        end

                        "loss_rate":
                        begin

                            TEST_STATUS = 10;
                            write_xgeth(TEST_STATUS,STATUS_ADDR);
                            do 
                            begin  
                                WaitNS(1);
                                read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                            end 
                            while (TEST_STATUS != 0);

                            write_xgeth(TEST_PKT_number[15:0],PKT_NUMBER_L_ADDR);
                            write_xgeth(TEST_PKT_number[31:16],PKT_NUMBER_H_ADDR);

                            write_xgeth(TEST_mac_source[15:0],MAC_SRC_L_ADDR);
                            write_xgeth(TEST_mac_source[31:16],MAC_SRC_M_ADDR);
                            write_xgeth(TEST_mac_source[47:32],MAC_SRC_H_ADDR);

                            write_xgeth(TEST_mac_destination[15:0],MAC_DST_L_ADDR);
                            write_xgeth(TEST_mac_destination[31:16],MAC_DST_M_ADDR);
                            write_xgeth(TEST_mac_destination[47:32],MAC_DST_H_ADDR);

                            write_xgeth(TEST_ip_source[15:0],IP_SRC_L_ADDR);
                            write_xgeth(TEST_ip_source[31:16],IP_SRC_H_ADDR);

                            write_xgeth(TEST_ip_destination[15:0],IP_DST_L_ADDR);
                            write_xgeth(TEST_ip_destination[31:16],IP_DST_H_ADDR);

                            write_xgeth(TEST_TIMEOUT_number,TIMEOUT_ADDR);
                            

                            TEST_RFC_type = 1;
                            TEST_frame_rate = TEST_init_rate;

                            $fdisplay(logRFCFile,"\n============================================");
                            $fdisplay(logRFCFile,"Executing %s test - Initial frame rate: %2.f Mb/s",TEST_type,TEST_frame_rate*100);
                            $fdisplay(logRFCFile,"============================================\n");

                            lose_pkt_start = 0;
                            Wait156(2);
                            lose_pkt_skip = TEST_client_loss;
                            Wait156(2);;

                            while(TEST_frame_rate > 0)
                            begin

                                if(TEST_frame_rate >= TEST_client_tx_loss)
                                begin

                                    $fdisplay(logRFCFile,"Preparing... Executing now at %2.f Mb/s (packet loss enabled)",TEST_frame_rate*100);
                                    lose_pkt_start = 1;

                                end
                                else
                                begin

                                    $fdisplay(logRFCFile,"Preparing... Executing now at %2.f Mb/s (packet loss disabled)",TEST_frame_rate*100);
                                    lose_pkt_start = 0;

                                end

                                TEST_IDLE_number = (TEST_pkt_length*100-TEST_pkt_length*TEST_frame_rate)/(12*TEST_frame_rate);
                                
                                write_xgeth(TEST_IDLE_number,IDLE_NUMBER_ADDR);
                                write_xgeth(TEST_RFC_type,RFC_TYPE_ADDR);
                                write_xgeth(TEST_packet_length_code,PKT_LENGTH_ADDR);

                                if(TEST_IDLE_number < 1)
                                begin

                                    $fdisplay(logRFCFile,"It is not possible to execute %2.f Mb/s with the current size of packet",TEST_frame_rate*100);
                                    $fdisplay(logRFCFile,"Idle period is too small (< 1) - The testbench will skip this frame rate...");

                                end else
                                begin

                                    TEST_STATUS = 1;
                                    write_xgeth(TEST_STATUS,STATUS_ADDR);

                                    do 
                                    begin  
                                        Wait156(10);
                                        read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                                    end 
                                    while (TEST_STATUS != 0);
                                    
                                     $fdisplay(logRFCFile,"** OPERATION IS OVER! **",);

                                    read_xgeth(PKT_RX_L_ADDR,TEST_PKT_rx[15:0],"ENABLE");
                                    read_xgeth(PKT_RX_H_ADDR,TEST_PKT_rx[31:16],"ENABLE");

                                    if(TEST_PKT_rx == TEST_PKT_number)
                                    begin
                                        $fdisplay(logRFCFile,"The Receiver received all packets at %2.f Mb/s!",TEST_frame_rate*100);
                                        break;
                                    end

                                    TEST_loss_perc = (TEST_PKT_number-TEST_PKT_rx)*100/(TEST_PKT_number);

                                    $fdisplay(testRFCFile,"[Loss Rate Test - RFC 2544]\nLoss rate at %2.f Mb/s: %2.f perc.",TEST_frame_rate*100, TEST_loss_perc);
                                end

                                TEST_last_rate = TEST_frame_rate;
                                TEST_frame_rate = TEST_frame_rate - TEST_step_rate;

                                Wait156(1);
                            end



                        end

                        "latency":
                        begin

                            TEST_STATUS = 10;
                            write_xgeth(TEST_STATUS,STATUS_ADDR);
                            do 
                            begin  
                                WaitNS(1);
                                read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                            end 
                            while (TEST_STATUS != 0);

                            write_xgeth(TEST_PKT_number[15:0],PKT_NUMBER_L_ADDR);
                            write_xgeth(TEST_PKT_number[31:16],PKT_NUMBER_H_ADDR);

                            write_xgeth(TEST_mac_source[15:0],MAC_SRC_L_ADDR);
                            write_xgeth(TEST_mac_source[31:16],MAC_SRC_M_ADDR);
                            write_xgeth(TEST_mac_source[47:32],MAC_SRC_H_ADDR);

                            write_xgeth(TEST_mac_destination[15:0],MAC_DST_L_ADDR);
                            write_xgeth(TEST_mac_destination[31:16],MAC_DST_M_ADDR);
                            write_xgeth(TEST_mac_destination[47:32],MAC_DST_H_ADDR);

                            write_xgeth(TEST_ip_source[15:0],IP_SRC_L_ADDR);
                            write_xgeth(TEST_ip_source[31:16],IP_SRC_H_ADDR);

                            write_xgeth(TEST_ip_destination[15:0],IP_DST_L_ADDR);
                            write_xgeth(TEST_ip_destination[31:16],IP_DST_H_ADDR);

                            write_xgeth(TEST_TIMEOUT_number,TIMEOUT_ADDR);

                            TEST_RFC_type = 2;
                            TEST_frame_rate = TEST_init_rate;

                            $fdisplay(logRFCFile,"\n============================================");
                            $fdisplay(logRFCFile,"Executing %s test - frame rate: %2.f Mb/s",TEST_type,TEST_frame_rate*100);
                            $fdisplay(logRFCFile,"============================================\n");


                            $fdisplay(logRFCFile,"Preparing... Executing now at %2.f Mb/s (packet loss disabled)",TEST_frame_rate*100);

                            TEST_IDLE_number = (TEST_pkt_length*100-TEST_pkt_length*TEST_frame_rate)/(12*TEST_frame_rate);
                            write_xgeth(TEST_IDLE_number,IDLE_NUMBER_ADDR);
                            write_xgeth(TEST_RFC_type,RFC_TYPE_ADDR);
                            write_xgeth(TEST_packet_length_code,PKT_LENGTH_ADDR);

                             write_xgeth(TEST_PKT_timestamp_pos[15:0],TIMESTAMP_POS_L_ADDR);
                             write_xgeth(TEST_PKT_timestamp_pos[31:16],TIMESTAMP_POS_H_ADDR);

                            lose_pkt_start = 0;

                            TEST_STATUS = 1;
                            write_xgeth(TEST_STATUS,STATUS_ADDR);

                            Wait156(100);

                            TEST_STATUS = 2;
                            write_xgeth(TEST_STATUS,STATUS_ADDR);

                            //wait(end_latency);
                            //
                            //$fdisplay(logRFCFile,"Timestamp calculated by the Receiver!");

                            do 
                            begin  
                                Wait156(10);
                                read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                            end 
                            while (TEST_STATUS != 0);

                            $fdisplay(logRFCFile,"** OPERATION IS OVER! **",);

                            read_xgeth(LATENCY_L_ADDR,TEST_latency[15:0],"ENABLE");
                            read_xgeth(LATENCY_M_ADDR,TEST_latency[31:16],"ENABLE");
                            read_xgeth(LATENCY_H_ADDR,TEST_latency[47:32],"ENABLE");
                            
                            //timestamp multiplied by the period of the module (6.4ns)
                            $fdisplay(testRFCFile,"[Latency Test - RFC 2544]\nPacket latency: %2.f ns",TEST_latency*6.4);
                        end


                        "back_to_back":
                        begin


                            TEST_STATUS = 10;
                            write_xgeth(TEST_STATUS,STATUS_ADDR);
                            do 
                            begin  
                                WaitNS(1);
                                read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                            end 
                            while (TEST_STATUS != 0);

                            write_xgeth(TEST_PKT_number[15:0],PKT_NUMBER_L_ADDR);
                            write_xgeth(TEST_PKT_number[31:16],PKT_NUMBER_H_ADDR);

                            write_xgeth(TEST_mac_source[15:0],MAC_SRC_L_ADDR);
                            write_xgeth(TEST_mac_source[31:16],MAC_SRC_M_ADDR);
                            write_xgeth(TEST_mac_source[47:32],MAC_SRC_H_ADDR);

                            write_xgeth(TEST_mac_destination[15:0],MAC_DST_L_ADDR);
                            write_xgeth(TEST_mac_destination[31:16],MAC_DST_M_ADDR);
                            write_xgeth(TEST_mac_destination[47:32],MAC_DST_H_ADDR);

                            write_xgeth(TEST_ip_source[15:0],IP_SRC_L_ADDR);
                            write_xgeth(TEST_ip_source[31:16],IP_SRC_H_ADDR);

                            write_xgeth(TEST_ip_destination[15:0],IP_DST_L_ADDR);
                            write_xgeth(TEST_ip_destination[31:16],IP_DST_H_ADDR);

                            write_xgeth(TEST_TIMEOUT_number,TIMEOUT_ADDR);

                            TEST_RFC_type = 3;
                            TEST_b2b_count = 0;
                            TEST_b2b_lock = 0;
                            TEST_IDLE_number = 1;
                            lose_pkt_skip = 2;

                            write_xgeth(TEST_IDLE_number,IDLE_NUMBER_ADDR);
                            write_xgeth(TEST_RFC_type,RFC_TYPE_ADDR);
                            write_xgeth(TEST_packet_length_code,PKT_LENGTH_ADDR);

                            $fdisplay(logRFCFile,"\n============================================");
                            $fdisplay(logRFCFile,"Executing %s test",TEST_type);
                            $fdisplay(logRFCFile,"============================================\n");

                            $fdisplay(logRFCFile,"Frame rate set to max (minimum inter-frame gap).");

                            while(TEST_b2b_count < 50)
                            begin

                                if(TEST_PKT_number >= TEST_b2b_max_burst)
                                begin
                                    $fdisplay(logRFCFile,"Burst size: %d packets (packet loss enabled)",TEST_PKT_number);
                                    lose_pkt_start = 1;
                                end
                                else begin
                                    $fdisplay(logRFCFile,"Burst size: %d packets (packet loss disabled)",TEST_PKT_number);
                                    lose_pkt_start = 0;
                                end

                                TEST_STATUS = 1;
                                write_xgeth(TEST_STATUS,STATUS_ADDR);

                                do 
                                begin  
                                    Wait156(10);
                                    read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                                end 
                                while (TEST_STATUS != 0);

                                $fdisplay(logRFCFile,"** OPERATION IS OVER! **",);

                                read_xgeth(PKT_RX_L_ADDR,TEST_PKT_rx[15:0],"ENABLE");
                                read_xgeth(PKT_RX_H_ADDR,TEST_PKT_rx[31:16],"ENABLE");

                                if(TEST_PKT_rx == TEST_PKT_number)
                                begin

                                    if(TEST_b2b_lock == 1)
                                    begin
                                        $fdisplay(logRFCFile,"All packets received - Repeating test ( %d tries left )",(50-TEST_b2b_count));
                                        TEST_b2b_count++;
                                    end
                                    else begin
                                        $fdisplay(logRFCFile,"All packets received - Increasing burst size...");
                                        TEST_PKT_number = TEST_PKT_number + TEST_PKT_step;
                                    end

                                end
                                else begin

                                    $fdisplay(logRFCFile,"Packets were lost during transmission - Decreasing burst size...");

                                    TEST_PKT_number = TEST_PKT_number - TEST_PKT_step;
                                    TEST_b2b_lock = 1;
                                    TEST_b2b_count = 0;
                                end

                                write_xgeth(TEST_PKT_number[15:0],PKT_NUMBER_L_ADDR);
                                write_xgeth(TEST_PKT_number[31:16],PKT_NUMBER_H_ADDR);

                            end

                            $fdisplay(logRFCFile,"Back to back test finalized!");

                            $fdisplay(testRFCFile,"[Back to Back Frames Test - RFC 2544]\nLargest Burst: %d packets of %d Bytes",TEST_PKT_number,TEST_pkt_length);

                        end

                        
                        "system_recovery":
                        begin

                            TEST_STATUS = 10;
                            write_xgeth(TEST_STATUS,STATUS_ADDR);
                            do 
                            begin  
                                WaitNS(1);
                                read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                            end 
                            while (TEST_STATUS != 0);


                            write_xgeth(TEST_PKT_number[15:0],PKT_NUMBER_L_ADDR);
                            write_xgeth(TEST_PKT_number[31:16],PKT_NUMBER_H_ADDR);

                            write_xgeth(TEST_mac_source[15:0],MAC_SRC_L_ADDR);
                            write_xgeth(TEST_mac_source[31:16],MAC_SRC_M_ADDR);
                            write_xgeth(TEST_mac_source[47:32],MAC_SRC_H_ADDR);

                            write_xgeth(TEST_mac_destination[15:0],MAC_DST_L_ADDR);
                            write_xgeth(TEST_mac_destination[31:16],MAC_DST_M_ADDR);
                            write_xgeth(TEST_mac_destination[47:32],MAC_DST_H_ADDR);

                            write_xgeth(TEST_ip_source[15:0],IP_SRC_L_ADDR);
                            write_xgeth(TEST_ip_source[31:16],IP_SRC_H_ADDR);

                            write_xgeth(TEST_ip_destination[15:0],IP_DST_L_ADDR);
                            write_xgeth(TEST_ip_destination[31:16],IP_DST_H_ADDR);

                            write_xgeth(TEST_TIMEOUT_number,TIMEOUT_ADDR);

                            TEST_RFC_type = 4;
                            lose_pkt_skip = TEST_client_loss;

                            $fdisplay(logRFCFile,"\n============================================",);
                            $fdisplay(logRFCFile,"Executing %s test",TEST_type);
                            $fdisplay(logRFCFile,"============================================\n",);

                            // testing at 110% of the throughput rate
                            if(TEST_throughtput == 0)
                            begin
                                $fdisplay(testRFCFile,"[System Recovery Test - RFC 2544] ERROR! This test requires the throughput frame rate. Please, execute the throughput test BEFORE this test.\nSkipping test...");
                            end
                            else begin

                                $fdisplay(logRFCFile,"Preparing... Executing now at %2.f Mb/s (packet loss enabled)",(TEST_throughtput+TEST_throughtput*0.1)*100);

                                TEST_IDLE_number = (TEST_pkt_length*100-TEST_pkt_length*(TEST_throughtput+TEST_throughtput*0.1))/(12*(TEST_throughtput+TEST_throughtput*0.1));

                                if(TEST_IDLE_number == 0) 
                                begin

                                    $fdisplay(logRFCFile,"It is not possible to execute %2.f Mb/s with the current size of packet",TEST_frame_rate*100);
                                    $fdisplay(logRFCFile,"Idle period is too small (< 1) - The testbench will skip this frame rate...");

                                    TEST_IDLE_number = 1;
                                end

                                write_xgeth(TEST_IDLE_number,IDLE_NUMBER_ADDR);
                                write_xgeth(TEST_RFC_type,RFC_TYPE_ADDR);
                                write_xgeth(TEST_packet_length_code,PKT_LENGTH_ADDR);
                                write_xgeth(TEST_PKT_sequence,PKT_SEQUENCE_ADDR);
                                lose_pkt_start = 1;

                                TEST_STATUS = 1;
                                write_xgeth(TEST_STATUS,STATUS_ADDR);

                                //wait(verify_system_rec);

                               Wait156(100);

                                TEST_STATUS = 3;
                                write_xgeth(TEST_STATUS,STATUS_ADDR);

                                $fdisplay(logRFCFile,"Executing now at %2.f Mb/s (packet loss disabled)",((TEST_throughtput+TEST_throughtput*0.1)*100)/2);


                                Wait156(10);
                                
                                lose_pkt_start = 0;

                                do 
                                begin  
                                    Wait156(10);
                                    read_xgeth(STATUS_ADDR,TEST_STATUS,"DISABLE");
                                end 
                                while (TEST_STATUS != 0);

                                $fdisplay(logRFCFile,"** OPERATION IS OVER! **",);

                                read_xgeth(LATENCY_L_ADDR,TEST_time2recover[15:0],"ENABLE");
                                read_xgeth(LATENCY_M_ADDR,TEST_time2recover[31:16],"ENABLE");
                                read_xgeth(LATENCY_H_ADDR,TEST_time2recover[47:32],"ENABLE");

                                $fdisplay(logRFCFile,"System recovery test finalized!");

                                //timestamp multiplied by the period of the module (6.4ns)
                                //System recovery uses the latency signal to retrieve thetime to recover value.
                                $fdisplay(testRFCFile,"[System Recovery Test - RFC 2544]\nTime to recover: %2.f ns",TEST_time2recover*6.4);

                            end



                        end

                        default:
                        begin
                            $display("Invalid test type %s",TEST_type);
                            $fclose(rxRFCFile);
                            $finish;
                        end

                    endcase;
                end
            endcase;

            $fdisplay(logRFCFile,"\n========================");
            $fdisplay(logRFCFile,"|---- END OF TEST -----|");
            $fdisplay(logRFCFile,"========================\n");

            $fdisplay(testRFCFile,"\n");

        end

        $fclose(rxRFCFile);

    end

endmodule // top
