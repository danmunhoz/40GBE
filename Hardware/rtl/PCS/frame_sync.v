//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: frame_sync.v
//
//
// Begin Date: Tue Jun 22 10:59:32 2004
//
// Description: 
//
//
//  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are
//              provided to you "as is". Xilinx and its licensors make, and you
//              receive no warranties or conditions, express, implied,
//              statutory or otherwise, and Xilinx specifically disclaims any
//              implied warranties of merchantability, non-infringement, or
//              fitness for a particular purpose. Xilinx does not warrant that
//              the functions contained in these designs will meet your
//              requirements, or that the operation of these designs will be
//              uninterrupted or error free, or that defects in the Designs
//              will be corrected. Furthermore, Xilinx does not warrant or
//              make any representations regarding use or the results of the
//              use of the designs in terms of correctness, accuracy,
//              reliability, or otherwise.
//
//              LIMITATION OF LIABILITY. In no event will Xilinx or its
//              licensors be liable for any loss of data, lost profits, cost
//              or procurement of substitute goods or services, or for any
//              special, incidental, consequential, or indirect damages
//              arising from the use or operation of the designs or
//              accompanying documentation, however caused and on any theory
//              of liability. This limitation will apply even if Xilinx
//              has been advised of the possibility of such damage. This
//              limitation shall apply not-withstanding the failure of the
//              essential purpose of any limited remedies herein.
//
//  Copyright  2002 Xilinx, Inc.
//  All rights reserved
//
//                       Revision History
//-----------------------------------------------------------------
// Date Modified             User Name            Full Name
//        Descrition of Changes
//-----------------------------------------------------------------
// $Log: frame_sync.v,v $
// Revision 1.1  2014-07-15 19:51:18  thomas.volpato
// Modificado diretorio de arquivos conforme especificado no documento da datacom
//
// Revision 1.2  2014-07-14 17:36:05  thomas.volpato
// arquivos alterados para solucionar problemas de timing
//
// Revision 1.1  2014-07-07 23:58:22  ricardo.guazzelli
// adicionado arquivos atualizados
//
//
//
//-----------------------------------------------------------------
// NOTES:
//-----------------------------------------------------------------
//
//
//-----------------------------------------------------------------

module frame_sync (
                   //  input ports
                   //rx_data_fsync, 
                   rx_header_in, rx_header_valid_in,
                   rstb, 
                   rx_jtm_en, rx_clk161, clear_ber_count,
                   //  output ports
                   slip_out,
                   
                   //rx_sync_ce,
                   hi_ber, blk_lock, linkstatus, ber_count
                   //rxd_sync_out
                    
                   );
    
    parameter [31:0] TIMER_MAX = 31'h4c4b;

    input           rstb;   
    input           rx_clk161;  
    input           rx_jtm_en; 
    input           clear_ber_count;
    input  [1:0]    rx_header_in;
    input           rx_header_valid_in;

    output          hi_ber;
    output          blk_lock;
    output          linkstatus;
    output [5:0]    ber_count;
    output          slip_out;

    wire            rstb;
    wire            rx_jtm_en;
    wire            rx_clk161;
    wire            linkstatus;
    wire            sh_valid;
    wire            timer_done;
    //wire [65:0]     rxd;
    //wire            spill;
    //wire [65:0]     rxd_sync_out;
    wire            rx_sync_ce;
    
    
    reg [5:0]       ber_count;
    reg             start_timer;
    reg [5:0]       sh_cnt;
    reg [3:0]       sh_invalid_cnt;
    reg             slip;   
    reg [30:0]      timer;
    reg [3:0]       ber_cnt;
    reg             hi_ber;
    reg             blk_lock;





    parameter [2:0]	 // synopsys enum visual_LOCK_states 
        LOCK_INIT  = 3'b000,
        INVALID_SH = 3'b001,
        SLIP       = 3'b010,
        SLIP_W     = 3'b011,
        TEST_SH    = 3'b100,
        VALID_SH   = 3'b101;
    
    
    reg [2:0]       /* synopsys enum visual_LOCK_states */ LOCK_current;
    // synopsys state_vector LOCK_current
    
    
    parameter [2:0]
        RESET_BER   = 3'b000,
        GOOD_BER    = 3'b001,
        S_HI_BER      = 3'b010,
        START_TIMER = 3'b011,
        TEST        = 3'b100;
    
    
    reg [2:0]       visual_RESET_BER_current;
    

    // Synchronous process
    always  @(posedge rx_clk161 or negedge rstb)
        begin : frame_sync_LOCK_INIT
            
            if (rstb == 1'b0)
                begin
                    blk_lock <= 1'b0;
                    slip <= 1'b0;
                    sh_cnt <= 6'h00;
                    sh_invalid_cnt <= 4'h0;
                    LOCK_current <= LOCK_INIT;
                end
            else if (rx_sync_ce)
                begin
                    if (!(rstb))
                        begin
                            blk_lock <= 1'b0;
                            slip <= 1'b0;
                            sh_cnt <= 6'h00;
                            sh_invalid_cnt <= 4'h0;
                            LOCK_current <= LOCK_INIT;
                        end
                    else
                        begin
                            
                            case (LOCK_current)  // synopsys parallel_case full_case
                                LOCK_INIT:
                                    begin
                                        sh_cnt <= 6'h00;
                                        sh_invalid_cnt <= 4'h0;
                                        LOCK_current <= TEST_SH;
                                    end
                                
                                INVALID_SH:
                                    begin
                                        if (sh_invalid_cnt == 4'hf | !(blk_lock))
                                            begin
                                                slip <= 1'b1;
                                                blk_lock <= 1'b0;
                                                LOCK_current <= SLIP;
                                            end
                                        else if (sh_cnt == 6'h3f)
                                            begin
                                                sh_cnt <= 6'h00;
                                                sh_invalid_cnt <= 4'h0;
                                                LOCK_current <= TEST_SH;
                                            end
                                        else if (sh_valid)
                                            begin
                                                sh_cnt <= sh_cnt + 1'b1;
                                                LOCK_current <= VALID_SH;
                                            end
                                        else
                                            begin
                                                sh_cnt <= sh_cnt + 1'b1;
                                                sh_invalid_cnt <= sh_invalid_cnt + 1'b1;
                                                LOCK_current <= INVALID_SH;
                                            end
                                    end
                                
                                SLIP:
                                    begin
                                        // if (slip_done)
                                        //     begin
                                        //         slip <= 1'b0;
                                        //         LOCK_current <= SLIP_W;
                                        //     end
                                        // else
                                        slip <= 1'b0;
                                        LOCK_current <= SLIP_W;
                                    end
                                
                                SLIP_W:
                                    begin
                                        sh_cnt <= 6'h00;
                                        sh_invalid_cnt <= 4'h0;
                                        LOCK_current <= TEST_SH;
                                    end
                                
                                TEST_SH:
                                    begin
                                        if (sh_valid)
                                            begin
                                                sh_cnt <= sh_cnt + 1'b1;
                                                LOCK_current <= VALID_SH;
                                            end
                                        else
                                            begin
                                                sh_cnt <= sh_cnt + 1'b1;
                                                sh_invalid_cnt <= sh_invalid_cnt + 1'b1;
                                                LOCK_current <= INVALID_SH;
                                            end
                                    end
                                
                                VALID_SH:
                                    begin
                                        if (sh_cnt == 6'h3f & sh_invalid_cnt == 4'h0)
                                            begin
                                                blk_lock <= 1'b1;
                                                sh_cnt <= 6'h00;
                                                sh_invalid_cnt <= 4'h0;
                                                LOCK_current <= TEST_SH;
                                            end
                                        else if (sh_cnt == 6'h3f)
                                            begin
                                                sh_cnt <= 6'h00;
                                                sh_invalid_cnt <= 4'h0;
                                                LOCK_current <= TEST_SH;
                                            end
                                        else if (sh_valid)
                                            begin
                                                sh_cnt <= sh_cnt + 1'b1;
                                                LOCK_current <= VALID_SH;
                                            end
                                        else
                                            begin
                                                sh_cnt <= sh_cnt + 1'b1;
                                                sh_invalid_cnt <= sh_invalid_cnt + 1'b1;
                                                LOCK_current <= INVALID_SH;
                                            end
                                    end
                                
                                default:
                                    begin
                                        blk_lock <= 1'b0;
                                        slip <= 1'b0;
                                        sh_cnt <= 6'h00;
                                        sh_invalid_cnt <= 4'h0;
                                        LOCK_current <= LOCK_INIT;
                                    end
                            endcase
                        end
                end
        end
    
    
    
    // Synchronous process
    always  @(posedge rx_clk161 or negedge rstb)
        begin : frame_sync_RESET_BER
            
            if (rstb == 1'b0)
                begin
                    hi_ber <= 1'b0;
                    ber_count <= 6'h00;
                    start_timer <= 1'b1;
                    ber_cnt <= 4'h0;
                    visual_RESET_BER_current <= RESET_BER;
                end
            else if (rx_sync_ce)
                begin
                    if (rx_jtm_en | !(blk_lock))
                        begin
                            hi_ber <= 1'b0;
                            ber_count <= 6'h00;
                            start_timer <= 1'b1;
                            ber_cnt <= 4'h0;
                            visual_RESET_BER_current <= START_TIMER;
                        end
                    else
                        begin
                            
                            case (visual_RESET_BER_current)  // synopsys parallel_case full_case
                                RESET_BER:
                                    begin
                                        start_timer <= 1'b1;
                                        ber_cnt <= 4'h0;
                                        visual_RESET_BER_current <= START_TIMER;
                                    end
                                
                                GOOD_BER:
                                    begin
                                        start_timer <= 1'b1;
                                        ber_cnt <= 4'h0;
                                        visual_RESET_BER_current <= START_TIMER;
                                    end
                                
                                S_HI_BER:
                                    begin
                                        if (timer_done)
                                            begin
                                                start_timer <= 1'b1;
                                                ber_cnt <= 4'h0;
                                                visual_RESET_BER_current <= START_TIMER;
                                            end
                                        else
                                            visual_RESET_BER_current <= S_HI_BER;
                                    end
                                
                                START_TIMER:
                                    begin
                                        start_timer <= 1'b0;
                                        visual_RESET_BER_current <= TEST;
                                    end
                                
                                TEST:
                                    begin
                                        if (sh_valid & timer_done)
                                            begin
                                                hi_ber <= 1'b0;
                                                visual_RESET_BER_current <= GOOD_BER;
                                            end
                                        else if (!(sh_valid))
                                            begin
                                                ber_cnt <= ber_cnt + 1;
                                                ber_count <= (clear_ber_count) ? 6'h00 :
                                                             (ber_count != 6'h3f) ?  ber_count + 1'b1 : 6'h3f;
                                                if (ber_cnt == 4'he)
                                                    begin
                                                        hi_ber <= 1'b1;
                                                        visual_RESET_BER_current <= S_HI_BER;
                                                    end
                                                else if (timer_done)
                                                    begin
                                                        hi_ber <= 1'b0;
                                                        visual_RESET_BER_current <= GOOD_BER;
                                                    end
                                                else
                                                    begin
                                                        visual_RESET_BER_current <= TEST;
                                                    end
                                            end
                                        else
                                            visual_RESET_BER_current <= TEST;
                                    end
                                
                                default:
                                    begin
                                        hi_ber <= 1'b0;
                                        ber_count <= 6'h00;
                                        start_timer <= 1'b1;
                                        ber_cnt <= 4'h0;
                                        visual_RESET_BER_current <= RESET_BER;
                                    end
                            endcase
                        end
                end
        end
    
    
    
    //-----------------------------------------------------------------
    // Created : Mon Feb 25 14:27:01 2002
    // Function: 125us timer
    //
    //-----------------------------------------------------------------
    always@(posedge rx_clk161 or negedge rstb)
        if(~rstb) begin
  	        timer <= 31'h0000;
        end 
        else if (rx_sync_ce)
            begin
  	            if(start_timer)
  	                timer <= 31'h0000;
  	            else if (timer != TIMER_MAX)
  	                timer <= timer + 1'b1;
            end
    
    assign timer_done = (timer == TIMER_MAX) ? 1'b1 : 1'b0;

    assign sh_valid = rx_header_in[0] ^ rx_header_in[1];

    
    //assign slip_done_out = slip_done;
    assign slip_out = slip;    
    assign rx_sync_ce = rx_header_valid_in;


    // =================================================
    //
    // MDIO signal processing
    //
    // =================================================
    

    assign  linkstatus = blk_lock && ~hi_ber;
    

    
    
    
    
endmodule
