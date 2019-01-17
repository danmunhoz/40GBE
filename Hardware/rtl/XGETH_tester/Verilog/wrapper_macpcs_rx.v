////////////////////////////////////////////////////////////////////////
////                                                                ////
//// File name "10g_eth_tester_top.v"                               ////
////                                                                ////
//// This file is part of the "Testset X10G" project                ////
//// testeset10g/design/10g_eth_tester_top                          ////
////                                                                ////
//// Author(s):                                                     ////
//// - Bruno Goulart de Oliveira (bruno.goulart@acad.pucrs.br)      ////
////                                                                ////
//// Description: read document x10giga_eth_tester_functional.pdf   ////
////                                                                ////
////////////////////////////////////////////////////////////////////////
module wrapper_macpcs_rx(
                        //---- -------- Inputs ----------------//

                        // Clocks
                        clk_156, tx_clk_161_13, rx_clk_161_13, clk_xgmii_rx, clk_xgmii_tx, clk_312,
                        // Resets
                        async_reset_n, reset_tx_n, reset_rx_n, reset_tx_done, reset_rx_done,
                        // PHY -> Output of PCS
                        tx_sequence_out, rxgearboxslip_out,
                        tx_valid_out_0,   tx_valid_out_1,   tx_valid_out_2,   tx_valid_out_3,
                        tx_header_out_0,  tx_header_out_1,  tx_header_out_2,  tx_header_out_3,
                        tx_data_out_0,    tx_data_out_1,    tx_data_out_2,    tx_data_out_3,
                        // PCS
                        rx_jtm_en, bypass_descram, bypass_scram, bypass_66decoder, bypass_66encoder, clear_errblk, clear_ber_cnt, tx_jtm_en, jtm_dps_0, jtm_dps_1, seed_A, seed_B,
                        // XMAC
                        pkt_rx_ren, pkt_tx_data, pkt_tx_eop, pkt_tx_mod, pkt_tx_sop, pkt_tx_val,
                        // Wishbone (XMAC)
                        wb_adr_i, wb_clk_i, wb_cyc_i, wb_dat_i, wb_stb_i, wb_we_i,

                        // ------------- Outputs -------------//

                        // PHY -> Input of PCS
                        rx_lane_0_header_valid_in, rx_lane_0_header_in, rx_lane_0_data_in, rx_lane_0_data_valid_in,
                        rx_lane_1_header_valid_in, rx_lane_1_header_in, rx_lane_1_data_in, rx_lane_1_data_valid_in,
                        rx_lane_2_header_valid_in, rx_lane_2_header_in, rx_lane_2_data_in, rx_lane_2_data_valid_in,
                        rx_lane_3_header_valid_in, rx_lane_3_header_in, rx_lane_3_data_in, rx_lane_3_data_valid_in,
                        // PCS
                        jtest_errc, ber_cnt, hi_ber, blk_lock, linkstatus, rx_fifo_spill, tx_fifo_spill, rxlf, txlf, errd_blks,
                        // XMAC
                        pkt_rx_avail, pkt_rx_data, pkt_rx_eop, pkt_rx_err, pkt_rx_mod, pkt_rx_sop, pkt_rx_val, pkt_tx_full,
                        // Wishbone (XMAC)
                        wb_ack_o, wb_dat_o, wb_int_o,
                        // Para uso do Testbench
            						start_fifo,
                        start_fifo_rd,
                        RDEN_FIFO_PCS40,

                        dump_xgmii_rxc_0,
                        dump_xgmii_rxd_0,
                        dump_xgmii_rxc_1,
                        dump_xgmii_rxd_1,
                        dump_xgmii_rxc_2,
                        dump_xgmii_rxd_2,
                        dump_xgmii_rxc_3,
                        dump_xgmii_rxd_3,

                        mac_eop,
                        mac_sop,
                        mac_data,
                        mac_val,
                        read_fifo,
                        empty_fifo,
                        full_fifo,
                        fifo_almost_f,
                        fifo_almost_e
                        );
    // Clocks
    input           clk_156;
    input           clk_312;
    input           tx_clk_161_13;
    input           rx_clk_161_13;
    input           clk_xgmii_rx;
    input           clk_xgmii_tx;

    // Resets
    input           async_reset_n;
    input           reset_tx_n;
    input           reset_rx_n;
    input           reset_tx_done;
    input           reset_rx_done;


    // PCS Inputs
    input         rx_jtm_en;
    input         bypass_descram;
    input         bypass_scram;
    input         bypass_66decoder;
    input         bypass_66encoder;
    input         clear_errblk;
    input         clear_ber_cnt;
    input         tx_jtm_en;
    input         jtm_dps_0;
    input         jtm_dps_1;
    input [57:0]  seed_A;
    input [57:0]  seed_B;

    (* KEEP = "true" *) input        rx_lane_0_header_valid_in;
    (* KEEP = "true" *) input [1:0]  rx_lane_0_header_in;
    (* KEEP = "true" *) input        rx_lane_0_data_valid_in;
    (* KEEP = "true" *) input [63:0] rx_lane_0_data_in;

    (* KEEP = "true" *) input        rx_lane_1_header_valid_in;
    (* KEEP = "true" *) input [1:0]  rx_lane_1_header_in;
    (* KEEP = "true" *) input        rx_lane_1_data_valid_in;
    (* KEEP = "true" *) input [63:0] rx_lane_1_data_in;

    (* KEEP = "true" *) input        rx_lane_2_header_valid_in;
    (* KEEP = "true" *) input [1:0]  rx_lane_2_header_in;
    (* KEEP = "true" *) input        rx_lane_2_data_valid_in;
    (* KEEP = "true" *) input [63:0] rx_lane_2_data_in;

    (* KEEP = "true" *) input        rx_lane_3_header_valid_in;
    (* KEEP = "true" *) input [1:0]  rx_lane_3_header_in;
    (* KEEP = "true" *) input        rx_lane_3_data_valid_in;
    (* KEEP = "true" *) input [63:0] rx_lane_3_data_in;

    //For Testbench use
		input					start_fifo;
		input					start_fifo_rd;
		input					RDEN_FIFO_PCS40;
    input         read_fifo;

    // PCS Outputs
    output        hi_ber;
    output        blk_lock;
    output        linkstatus;
    output        rx_fifo_spill;
    output        tx_fifo_spill;
    output        rxlf;
    output        txlf;
    output [5:0]  ber_cnt;
    output [7:0]  errd_blks;
    output [15:0] jtest_errc;
    output        rxgearboxslip_out;
    output [6:0]  tx_sequence_out;
    output [63:0] tx_data_out_0;
    output [1:0]  tx_header_out_0;
    output [63:0] tx_data_out_1;
    output [1:0]  tx_header_out_1;
    output [63:0] tx_data_out_2;
    output [1:0]  tx_header_out_2;
    output [63:0] tx_data_out_3;
    output [1:0]  tx_header_out_3;

    output        tx_valid_out_0;
    output        tx_valid_out_1;
    output        tx_valid_out_2;
    output        tx_valid_out_3;

    // tanauan pcs alignment
    wire [63:0] tx_data_int_0;
    wire [1:0]  tx_header_int_0;
    wire [63:0] tx_data_int_1;
    wire [1:0]  tx_header_int_1;
    wire [63:0] tx_data_int_2;
    wire [1:0]  tx_header_int_2;
    wire [63:0] tx_data_int_3;
    wire [1:0]  tx_header_int_3;

    wire        hi_ber_0;
    wire        blk_lock_0;
    wire        linkstatus_0;
    wire        rx_fifo_spill_0;
    wire        tx_fifo_spill_0;
    wire        rxlf_0;
    wire        txlf_0;
    wire [5:0]  ber_cnt_0;
    wire [7:0]  errd_blks_0;
    wire [15:0] jtest_errc_0;
    wire [63:0] tx_data_out_0;
    wire [1:0]  tx_header_out_0;
    wire        rxgearboxslip_out_0;
    wire [6:0]  tx_sequence_out_0;

    wire        hi_ber_1;
    wire        blk_lock_1;
    wire        linkstatus_1;
    wire        rx_fifo_spill_1;
    wire        tx_fifo_spill_1;
    wire        rxlf_1;
    wire        txlf_1;
    wire [5:0]  ber_cnt_1;
    wire [7:0]  errd_blks_1;
    wire [15:0] jtest_errc_1;
    wire [63:0] tx_data_out_1;
    wire [1:0]  tx_header_out_1;
    wire        rxgearboxslip_out_1;
    wire [6:0]  tx_sequence_out_1;

    wire        hi_ber_2;
    wire        blk_lock_2;
    wire        linkstatus_2;
    wire        rx_fifo_spill_2;
    wire        tx_fifo_spill_2;
    wire        rxlf_2;
    wire        txlf_2;
    wire [5:0]  ber_cnt_2;
    wire [7:0]  errd_blks_2;
    wire [15:0] jtest_errc_2;
    wire [63:0] tx_data_out_2;
    wire [1:0]  tx_header_out_2;
    wire        rxgearboxslip_out_2;
    wire [6:0]  tx_sequence_out_2;

    wire        hi_ber_3;
    wire        blk_lock_3;
    wire        linkstatus_3;
    wire        rx_fifo_spill_3;
    wire        tx_fifo_spill_3;
    wire        rxlf_3;
    wire        txlf_3;
    wire [5:0]  ber_cnt_3;
    wire [7:0]  errd_blks_3;
    wire [15:0] jtest_errc_3;
    wire [63:0] tx_data_out_3;
    wire [1:0]  tx_header_out_3;
    wire        rxgearboxslip_out_3;
    wire [6:0]  tx_sequence_out_3;

    // MAC Inputs
    // (* KEEP = "true" *)
    // input           pkt_rx_ren;
    // (* KEEP = "true" *)
    // input [63:0]    pkt_tx_data;
    // (* KEEP = "true" *)
    // input           pkt_tx_eop;
    // (* KEEP = "true" *)
    // input [2:0]     pkt_tx_mod;
    // (* KEEP = "true" *)
    // input           pkt_tx_sop;
    // (* KEEP = "true" *)
    // input           pkt_tx_val;
    (* KEEP = "true" *) input pkt_rx_ren;
    (* KEEP = "true" *) input [255:0] pkt_tx_data;
    (* KEEP = "true" *) input pkt_tx_eop;
    (* KEEP = "true" *) input [4:0] pkt_tx_mod;
    (* KEEP = "true" *) input [1:0] pkt_tx_sop;
    (* KEEP = "true" *) input pkt_tx_val;

    // Wishbone Inputs (MAC)
    input [7:0]     wb_adr_i;
    input           wb_clk_i;
    input           wb_cyc_i;
    input [31:0]    wb_dat_i;
    input           wb_stb_i;
    input           wb_we_i;

    (* KEEP = "true" *)
    output          pkt_rx_avail;
    (* KEEP = "true" *)
    output [63:0]   pkt_rx_data;
    (* KEEP = "true" *)
    output          pkt_rx_eop;
    (* KEEP = "true" *)
    output          pkt_rx_err;
    (* KEEP = "true" *)
    output [2:0]    pkt_rx_mod;
    (* KEEP = "true" *)
    output          pkt_rx_sop;
    (* KEEP = "true" *)
    output          pkt_rx_val;
    (* KEEP = "true" *)
    output          pkt_tx_full;

    output          wb_ack_o;
    output [31:0]   wb_dat_o;
    output          wb_int_o;

    // Para uso do Testbench
    output [7:0]    dump_xgmii_rxc_0;
    output [63:0]   dump_xgmii_rxd_0;
    output [7:0]    dump_xgmii_rxc_1;
    output [63:0]   dump_xgmii_rxd_1;
    output [7:0]    dump_xgmii_rxc_2;
    output [63:0]   dump_xgmii_rxd_2;
    output [7:0]    dump_xgmii_rxc_3;
    output [63:0]   dump_xgmii_rxd_3;

    (* syn_keep = "true"*) output [4:0] mac_eop;
    (* syn_keep = "true"*) output mac_sop;
    (* syn_keep = "true"*) output mac_val;
    (* syn_keep = "true"*) output [127:0] mac_data;
    (* syn_keep = "true"*) output empty_fifo;
    (* syn_keep = "true"*) output full_fifo;
    (* syn_keep = "true"*) output fifo_almost_f;
    (* syn_keep = "true"*) output fifo_almost_e;

    (* syn_keep = "true"*) wire [4:0] app_eop;
    (* syn_keep = "true"*) wire app_sop;
    (* syn_keep = "true"*) wire app_val;
    (* syn_keep = "true"*) wire [127:0] app_data;
    (* syn_keep = "true"*) wire crc_ok;
    (* syn_keep = "true"*) wire ren_coreif;
    (* syn_keep = "true"*) wire almost_e_coreif;

    wire            tx_clk_161_13;
    wire            rx_clk_161_13;
    wire            clk_156;
    wire            async_reset_n;

    reg [63:0]      old_data_0;
    reg [1:0]       old_header_0;

    wire            terminate_out_0_rx;
    wire            terminate_out_1_rx;
    wire            terminate_out_2_rx;
    wire            terminate_out_3_rx;
    wire            terminate_out_0_tx;
    wire            terminate_out_1_tx;
    wire            terminate_out_2_tx;
    wire            terminate_out_3_tx;

    wire            pcs_sync;
    wire            start_out_0_rx;
    wire            start_out_1_rx;
    wire            start_out_2_rx;
    wire            start_out_3_rx;
    wire            start_out_0_tx;
    wire            start_out_1_tx;
    wire            start_out_2_tx;
    wire            start_out_3_tx;

    reg             start_out_0_rx_r;
    reg             start_out_1_rx_r;
    reg             start_out_2_rx_r;
    reg             start_out_3_rx_r;
    reg             start_out_0_tx_r;
    reg             start_out_1_tx_r;
    reg             start_out_2_tx_r;
    reg             start_out_3_tx_r;

    wire            terminate_in_0_rx = 1'b0;
    wire            terminate_in_1_rx = terminate_out_0_rx;
    wire            terminate_in_2_rx = (terminate_out_0_rx || terminate_out_1_rx);
    wire            terminate_in_3_rx = (terminate_out_0_rx || terminate_out_1_rx || terminate_out_2_rx);

    wire            terminate_in_0_tx = 1'b0;
    wire            terminate_in_1_tx = terminate_out_0_tx;
    wire            terminate_in_2_tx = (terminate_out_0_tx || terminate_out_1_tx);
    wire            terminate_in_3_tx = (terminate_out_0_tx || terminate_out_1_tx || terminate_out_2_tx);

    wire            start_in_0_rx = (start_out_3_rx_r || start_out_1_rx_r || start_out_2_rx_r);
    wire            start_in_1_rx = (start_out_0_rx_r || start_out_2_rx_r || start_out_3_rx_r || start_out_0_rx);
    wire            start_in_2_rx = (start_out_0_rx_r || start_out_1_rx_r || start_out_3_rx_r || start_out_0_rx || start_out_1_rx);
    wire            start_in_3_rx = (start_out_0_rx_r || start_out_1_rx_r || start_out_2_rx_r || start_out_0_rx || start_out_1_rx || start_out_2_rx);

    wire            start_in_0_tx = (start_out_3_tx_r || start_out_1_tx_r || start_out_2_tx_r);
    wire            start_in_1_tx = (start_out_0_tx_r || start_out_2_tx_r || start_out_3_tx_r || start_out_0_tx);
    wire            start_in_2_tx = (start_out_0_tx_r || start_out_1_tx_r || start_out_3_tx_r || start_out_0_tx || start_out_1_tx);
    wire            start_in_3_tx = (start_out_0_tx_r || start_out_1_tx_r || start_out_2_tx_r || start_out_0_tx || start_out_1_tx || start_out_2_tx);

    wire            fifo_interface_full;
    wire            fifo_interface_empty;

    wire            fifo_reorder_empty_0;
    wire            fifo_reorder_empty_1;
    wire            fifo_reorder_empty_2;
    wire            fifo_reorder_empty_3;

    wire            pcs_0_valid_out;
    wire            pcs_1_valid_out;
    wire            pcs_2_valid_out;
    wire            pcs_3_valid_out;

    wire            pcs_0_scram_en;
    wire            pcs_1_scram_en;
    wire            pcs_2_scram_en;
    wire            pcs_3_scram_en;

    wire [65:0]     pcs_0_dscr;
    wire [65:0]     pcs_1_dscr;
    wire [65:0]     pcs_2_dscr;
    wire [65:0]     pcs_3_dscr;

    assign empty_fifo = fifo_interface_empty;
    assign full_fifo = fifo_interface_full;

    (* syn_keep = "true"*) wire [1:0]  pcs_0_header_out;
    (* syn_keep = "true"*) wire [63:0] pcs_0_data_out;
    (* syn_keep = "true"*) wire [1:0]  pcs_1_header_out;
    (* syn_keep = "true"*) wire [63:0] pcs_1_data_out;
    (* syn_keep = "true"*) wire [1:0]  pcs_2_header_out;
    (* syn_keep = "true"*) wire [63:0] pcs_2_data_out;
    (* syn_keep = "true"*) wire [1:0]  pcs_3_header_out;
    (* syn_keep = "true"*) wire [63:0] pcs_3_data_out;
    (* syn_keep = "true"*) wire pcs_0_alignment;
    (* syn_keep = "true"*) wire pcs_1_alignment;
    (* syn_keep = "true"*) wire pcs_2_alignment;
    (* syn_keep = "true"*) wire pcs_3_alignment;
    (* syn_keep = "true"*) wire valid_0_out_wire;
    (* syn_keep = "true"*) wire valid_1_out_wire;
    (* syn_keep = "true"*) wire valid_2_out_wire;
    (* syn_keep = "true"*) wire valid_3_out_wire;

    (* syn_keep = "true"*) wire dscr_en_ipg;

    (* syn_keep = "true"*) wire v0;
    (* syn_keep = "true"*) wire v1;
    (* syn_keep = "true"*) wire v2;
    (* syn_keep = "true"*) wire v3;
    (* syn_keep = "true"*) wire [1:0] hh0;
    (* syn_keep = "true"*) wire [1:0] hh1;
    (* syn_keep = "true"*) wire [1:0] hh2;
    (* syn_keep = "true"*) wire [1:0] hh3;
    (* syn_keep = "true"*) wire [63:0] d0;
    (* syn_keep = "true"*) wire [63:0] d1;
    (* syn_keep = "true"*) wire [63:0] d2;
    (* syn_keep = "true"*) wire [63:0] d3;

    (* syn_keep = "true"*) wire tx_wr_pcs;
    (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs0;
    (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs1;
    (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs2;
    (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs3;

    (* syn_keep = "true"*) wire [65:0] dscr_0_out_wire;
    (* syn_keep = "true"*) wire [65:0] dscr_1_out_wire;
    (* syn_keep = "true"*) wire [65:0] dscr_2_out_wire;
    (* syn_keep = "true"*) wire [65:0] dscr_3_out_wire;

    (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_0;
    (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_1;
    (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_2;
    (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_3;

    (* syn_keep = "true"*) reg  [63:0] tx_old_encod_data_out_3_reg;

    (* syn_keep = "true"*) wire [1:0]  pcs_0_header_sel;
    (* syn_keep = "true"*) wire [63:0] pcs_0_data_sel;
    (* syn_keep = "true"*) wire [1:0]  pcs_1_header_sel;
    (* syn_keep = "true"*) wire [63:0] pcs_1_data_sel;
    (* syn_keep = "true"*) wire [1:0]  pcs_2_header_sel;
    (* syn_keep = "true"*) wire [63:0] pcs_2_data_sel;
    (* syn_keep = "true"*) wire [1:0]  pcs_3_header_sel;
    (* syn_keep = "true"*) wire [63:0] pcs_3_data_sel;


    // MAC/PCS XGMII Interconnection
    (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_0;
    (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_0;
    (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_0;
    (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_0;

    (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_1;
    (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_1;
    (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_1;
    (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_1;

    (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_2;
    (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_2;
    (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_2;
    (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_2;

    (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_3;
    (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_3;
    (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_3;
    (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_3;


    (* syn_keep = "true"*) wire [1:0]  tana_pcs_0_header_out;
    (* syn_keep = "true"*) wire [63:0] tana_pcs_0_data_out;

    wire [7:0]  xgmii_txc;
    wire [63:0] xgmii_txd;

    // For Testbench
    assign dump_xgmii_rxc_0 = xgmii_rxc_lane_0;
    assign dump_xgmii_rxd_0 = xgmii_rxd_lane_0;
    assign dump_xgmii_rxc_1 = xgmii_rxc_lane_1;
    assign dump_xgmii_rxd_1 = xgmii_rxd_lane_1;
    assign dump_xgmii_rxc_2 = xgmii_rxc_lane_2;
    assign dump_xgmii_rxd_2 = xgmii_rxd_lane_2;
    assign dump_xgmii_rxc_3 = xgmii_rxc_lane_3;
    assign dump_xgmii_rxd_3 = xgmii_rxd_lane_3;

    assign jtest_errc = jtest_errc_0;
    assign ber_cnt = ber_cnt_0;
    assign hi_ber = hi_ber_0;
    assign blk_lock = blk_lock_0;
    assign linkstatus = linkstatus_0;
    assign rx_fifo_spill = rx_fifo_spill_0;
    assign tx_fifo_spill = tx_fifo_spill_0;
    assign rxlf = rxlf_0;
    assign txlf = txlf_0;
    assign errd_blks = errd_blks_0;

    // Register for lane 0 old block
    always @ (posedge rx_clk_161_13 or negedge async_reset_n) begin
      if (!async_reset_n) begin
        old_header_0 <= 2'b01;
        old_data_0   <= 64'h0;
      end
      // else if (pcs_3_valid_out) begin
      // else if (v3) begin
      else if (v3 & dscr_en_ipg) begin
        // Nao atualiza registrador com valores invalidos
        // tanauan
        // old_header_0 <= pcs_3_header_out[1:0];
        // old_data_0   <= pcs_3_data_out[63:0];
        old_header_0 <= hh3[1:0];
        old_data_0   <= d3[63:0];
      end
    end

    always @ (posedge tx_clk_161_13 or negedge async_reset_n) begin
    // always @ (tx_old_encod_data_out_3 or negedge async_reset_n) begin
      if (!async_reset_n) begin
        tx_old_encod_data_out_3_reg   <= 64'h3;
      end
      else begin
        if (pcs_0_scram_en == 1'b1)
        // if (pcs_0_scram_en & dscr_en_ipg == 1'b1) // tanauan
          tx_old_encod_data_out_3_reg <= tx_old_encod_data_out_3;
      end
    end

    // Start bit regs
    always @ (posedge clk_156 or negedge async_reset_n) begin
      if (!async_reset_n) begin
        start_out_0_rx_r <= 1'b0;
        start_out_1_rx_r <= 1'b0;
        start_out_2_rx_r <= 1'b0;
        start_out_3_rx_r <= 1'b0;

        start_out_0_tx_r <= 1'b0;
        start_out_1_tx_r <= 1'b0;
        start_out_2_tx_r <= 1'b0;
        start_out_3_tx_r <= 1'b0;
      end
      else begin
        start_out_0_rx_r <= start_out_0_rx;
        start_out_1_rx_r <= start_out_1_rx;
        start_out_2_rx_r <= start_out_2_rx;
        start_out_3_rx_r <= start_out_3_rx;

        start_out_0_tx_r <= start_out_0_tx;
        start_out_1_tx_r <= start_out_1_tx;
        start_out_2_tx_r <= start_out_2_tx;
        start_out_3_tx_r <= start_out_3_tx;
      end
    end

    (* dont_touch = "true" *) lane_reorder INST_lane_reorder
    (
      .clock (rx_clk_161_13),
      .reset (reset_rx_n),

      // LIGAÇÃO POR ARQUIVOS
      //
      // .lane_0_data_in    (rx_lane_0_data_in[63:0]),
      // .lane_0_header_in  (rx_lane_0_header_in[1:0]),
      // .lane_0_valid_in   (rx_lane_0_data_valid_in),
      //
      // .lane_1_data_in    (rx_lane_1_data_in[63:0]),
      // .lane_1_header_in  (rx_lane_1_header_in[1:0]),
      // .lane_1_valid_in   (rx_lane_1_data_valid_in),
      //
      // .lane_2_data_in    (rx_lane_2_data_in[63:0]),
      // .lane_2_header_in  (rx_lane_2_header_in[1:0]),
      // .lane_2_valid_in   (rx_lane_2_data_valid_in),
      //
      // .lane_3_data_in    (rx_lane_3_data_in[63:0]),
      // .lane_3_header_in  (rx_lane_3_header_in[1:0]),
      // .lane_3_valid_in   (rx_lane_3_data_valid_in),

      // LIGAÇÃO POR FIOS
      //
      .lane_0_data_in    (tx_data_out_0[63:0]),
      .lane_0_header_in  (tx_header_out_0[1:0]),
      .lane_0_valid_in   (tx_valid_out_0),

      .lane_1_data_in    (tx_data_out_1[63:0]),
      .lane_1_header_in  (tx_header_out_1[1:0]),
      .lane_1_valid_in   (tx_valid_out_1),

      .lane_2_data_in    (tx_data_out_2[63:0]),
      .lane_2_header_in  (tx_header_out_2[1:0]),
      .lane_2_valid_in   (tx_valid_out_2),

      .lane_3_data_in    (tx_data_out_3[63:0]),
      .lane_3_header_in  (tx_header_out_3[1:0]),
      .lane_3_valid_in   (tx_valid_out_3),

      .pcs_0_valid_out  (pcs_0_valid_out),
      .pcs_0_header_out (pcs_0_header_out[1:0]),
      .pcs_0_data_out   (pcs_0_data_out[63:0]),
      .pcs_0_alignment_out (pcs_0_alignment),

      .pcs_1_valid_out  (pcs_1_valid_out),
      .pcs_1_header_out (pcs_1_header_out[1:0]),
      .pcs_1_data_out   (pcs_1_data_out[63:0]),
      .pcs_1_alignment_out (pcs_1_alignment),

      .pcs_2_valid_out  (pcs_2_valid_out),
      .pcs_2_header_out (pcs_2_header_out[1:0]),
      .pcs_2_data_out   (pcs_2_data_out[63:0]),
      .pcs_2_alignment_out (pcs_2_alignment),

      .pcs_3_valid_out  (pcs_3_valid_out),
      .pcs_3_header_out (pcs_3_header_out[1:0]),
      .pcs_3_data_out   (pcs_3_data_out[63:0]),
      .pcs_3_alignment_out (pcs_3_alignment),


      .fifo_empty_0 (fifo_reorder_empty_0),
      .fifo_empty_1 (fifo_reorder_empty_1),
      .fifo_empty_2 (fifo_reorder_empty_2),
      .fifo_empty_3 (fifo_reorder_empty_3)

    );

    // MAC POR ENQUANTO "QUEBRADO" DENTRO DO WRAPPER: CORE_INTERFACE, CRC CHECKER, FAULTS, ETC...
    // TODO: CRIAR UM MODULO PARA ORGANIZAR TUDO

    // (* dont_touch = "true" *) crc_rx INST_crc_rx
    // (
    //   .clk_312  (clk_312),
    //   .rst_n    (reset_rx_n),
    //   .mac_data (mac_data),
    //   .mac_sop  (mac_sop),
    //   .mac_eop  (mac_eop),
    //   //.almost_full (),
    //   .app_data (app_data),
    //   .app_sop  (app_sop),
    //   .app_val  (app_val),
    //   .app_eop  (app_eop),
    //   .crc_ok   (crc_ok)
    // );

    (* dont_touch = "true" *) core_interface INST_core_interface
    (
      	.clk_156			      (clk_156),
        .clk_312			      (clk_312),
      	.rst_n 	            (reset_rx_n),
      	.xgmii_rxc_0	      (xgmii_rxc_lane_0),
      	.xgmii_rxd_0	      (xgmii_rxd_lane_0),
      	.xgmii_rxc_1	      (xgmii_rxc_lane_1),
      	.xgmii_rxd_1	      (xgmii_rxd_lane_1),
      	.xgmii_rxc_2	      (xgmii_rxc_lane_2),
      	.xgmii_rxd_2	      (xgmii_rxd_lane_2),
      	.xgmii_rxc_3	      (xgmii_rxc_lane_3),
      	.xgmii_rxd_3	      (xgmii_rxd_lane_3),
        .ren                (ren_coreif),

        .mac_data           (mac_data),
        .mac_sop            (mac_sop),
        .mac_eop            (mac_eop),
        .mac_val            (mac_val),
        .fifo_full          (full_fifo),
        .fifo_empty         (empty_fifo),
        .fifo_almost_f      (fifo_almost_f),
        .fifo_almost_e      (fifo_almost_e)
   );

   assign almost_e_coreif = fifo_almost_e;

   (* dont_touch = "true" *) crc_rx_sfifo INST_crc_rx_sfifo
   (
     .clk_312  (clk_312),
     .rst_n    (reset_rx_n),
     .mac_data (mac_data),
     .mac_sop  (mac_sop),
     .mac_eop  (mac_eop),
     .ren      (ren_coreif),
     .almost_e (almost_e_coreif),
     //.almost_full (),
     .app_data (),
     .app_sop  (),
     .app_val  (),
     .app_eop  (),
     .crc_ok   (crc_ok)
   );

   (* dont_touch = "true" *) mac_tx_path INST_mac_tx_path
   (
     .clk_156    (clk_156),
     .rst_n      (async_reset_n),
     .data_in    (pkt_tx_data),
     .sop_in     (pkt_tx_sop),
     .eop_in     (pkt_tx_eop),
     .mod_in     (pkt_tx_mod),
     .val_in     (pkt_tx_val),

     .mii_data_0 (xgmii_txd_lane_0),
     .mii_ctrl_0 (xgmii_txc_lane_0),
     .mii_data_1 (xgmii_txd_lane_1),
     .mii_ctrl_1 (xgmii_txc_lane_1),
     .mii_data_2 (xgmii_txd_lane_2),
     .mii_ctrl_2 (xgmii_txc_lane_2),
     .mii_data_3 (xgmii_txd_lane_3),
     .mii_ctrl_3 (xgmii_txc_lane_3)
   );



    PCS_core_rx #(
        .PCS_ID(0)
      ) INST_0_PCS_core (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .pcs_sync           (pcs_sync),
        .start_fifo         (start_fifo),
        .start_fifo_rd      (start_fifo_rd),
        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),

        // PCS Signals
        .rx_jtm_en          (rx_jtm_en),
        .bypass_descram     (bypass_descram),
        .bypass_scram       (bypass_scram),
        .bypass_66decoder   (bypass_66decoder),
        .bypass_66encoder   (bypass_66encoder),
        .clear_errblk       (clear_errblk),
        .clear_ber_cnt      (clear_ber_cnt),
        .tx_jtm_en          (tx_jtm_en),
        .jtm_dps_0          (jtm_dps_0),
        .jtm_dps_1          (jtm_dps_1),
        .seed_A             (seed_A),
        .seed_B             (seed_B),

        // .rx_header_valid_in (pcs_0_valid_out),
        // .rx_data_valid_in   (pcs_0_valid_out),
        // .rx_header_in       (pcs_0_header_out[1:0]),
        // .rx_data_in         (pcs_0_data_out[63:0]),
        .rx_header_valid_in (v0),
        .rx_data_valid_in   (v0),
        .rx_header_in       (hh0[1:0]),
        .rx_data_in         (d0[63:0]),

        .is_alig            (pcs_0_alignment),
        // .val_in             (valid_0_out_wire),
        .val_in             (dscr_en_ipg),
        .fifo_in            (dscr_0_out_wire),
        .pause_ipg          (tx_wr_pcs),
        .encoded_out        (tx_encoded_pcs0),

        // .gap                (gap),
        // .setIPG             (setIPG),

        .hi_ber             (hi_ber_0),
        .blk_lock           (blk_lock_0),
        .linkstatus         (linkstatus_0),
        .rx_fifo_spill      (rx_fifo_spill_0),
        .tx_fifo_spill      (tx_fifo_spill_0),
        .rxlf               (rxlf_0),
        .txlf               (txlf_0),
        .ber_cnt            (ber_cnt_0[5:0]),
        .errd_blks          (errd_blks_0[7:0]),
        .jtest_errc         (jtest_errc_0[15:0]),
        // .tx_data_out        (tx_data_out_0[63:0]),
        // .tx_header_out      (tx_header_out_0[1:0]),
        .tx_data_out        (tx_data_int_0[63:0]),
        .tx_header_out      (tx_header_int_0[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_0),
        .tx_sequence_out    (tx_sequence_out_0),
        .xgmii_txc          (xgmii_txc_lane_0),
        .xgmii_txd          (xgmii_txd_lane_0),
        .xgmii_rxd          (xgmii_rxd_lane_0),
        .xgmii_rxc          (xgmii_rxc_lane_0),
        .dscr_out           (pcs_0_dscr),

        .rx_old_header_in   (old_header_0),
        .rx_old_data_in     (old_data_0),

        .tx_old_scr_data_out (tx_old_encod_data_out_0),
        .tx_old_scr_data_in	 (tx_old_encod_data_out_3_reg),
        .scram_en            (pcs_0_scram_en),

        .terminate_in_tx       (terminate_in_0_tx),
        .terminate_out_tx      (terminate_out_0_tx),
        .start_in_tx           (start_in_0_tx),
        .start_out_tx          (start_out_0_tx),

        .terminate_in_rx       (terminate_in_0_rx),
        .terminate_out_rx      (terminate_out_0_rx),
        .start_in_rx           (start_in_0_rx),
        .start_out_rx          (start_out_0_rx)
    );

    PCS_core_rx #(
        .PCS_ID(1)
      ) INST_1_PCS_core (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .pcs_sync           (pcs_sync),
        .start_fifo         (start_fifo),
        .start_fifo_rd      (start_fifo_rd),
        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),

        // PCS Signals
        .rx_jtm_en          (rx_jtm_en),
        .bypass_descram     (bypass_descram),
        .bypass_scram       (bypass_scram),
        .bypass_66decoder   (bypass_66decoder),
        .bypass_66encoder   (bypass_66encoder),
        .clear_errblk       (clear_errblk),
        .clear_ber_cnt      (clear_ber_cnt),
        .tx_jtm_en          (tx_jtm_en),
        .jtm_dps_0          (jtm_dps_0),
        .jtm_dps_1          (jtm_dps_1),
        .seed_A             (seed_A),
        .seed_B             (seed_B),

        // .rx_header_valid_in (pcs_1_valid_out),
        // .rx_data_valid_in   (pcs_1_valid_out),
        // .rx_header_in       (pcs_1_header_out[1:0]),
        // .rx_data_in         (pcs_1_data_out[63:0]),
        .rx_header_valid_in (v1),
        .rx_data_valid_in   (v1),
        .rx_header_in       (hh1[1:0]),
        .rx_data_in         (d1[63:0]),

        .is_alig            (pcs_1_alignment),
        // .val_in             (valid_1_out_wire),
        .val_in             (dscr_en_ipg),
        .fifo_in            (dscr_1_out_wire),
        .pause_ipg          (tx_wr_pcs),
        .encoded_out        (tx_encoded_pcs1),

        // .gap                (gap),
        // .setIPG             (setIPG),

        .hi_ber             (hi_ber_1),
        .blk_lock           (blk_lock_1),
        .linkstatus         (linkstatus_1),
        .rx_fifo_spill      (rx_fifo_spill_1),
        .tx_fifo_spill      (tx_fifo_spill_1),
        .rxlf               (rxlf_1),
        .txlf               (txlf_1),
        .ber_cnt            (ber_cnt_1[5:0]),
        .errd_blks          (errd_blks_1[7:0]),
        .jtest_errc         (jtest_errc_1[15:0]),
        // .tx_data_out        (tx_data_out_1[63:0]),
        // .tx_header_out      (tx_header_out_1[1:0]),
        .tx_data_out        (tx_data_int_1[63:0]),
        .tx_header_out      (tx_header_int_1[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_1),
        .tx_sequence_out    (tx_sequence_out_1),
        .xgmii_txc          (xgmii_txc_lane_1), // MII do zero POR ENQUANTO
        .xgmii_txd          (xgmii_txd_lane_1), // MII do zero POR ENQUANTO
        .xgmii_rxd          (xgmii_rxd_lane_1),
        .xgmii_rxc          (xgmii_rxc_lane_1),
        .dscr_out           (pcs_1_dscr),

        // .rx_old_header_in   (pcs_0_header_out[1:0]),
        // .rx_old_data_in     (pcs_0_data_out[63:0]),
        .rx_old_header_in   (hh0[1:0]),
        .rx_old_data_in     (d0[63:0]),
        .scram_en           (pcs_1_scram_en),

        .tx_old_scr_data_out (tx_old_encod_data_out_1),
        .tx_old_scr_data_in	 (tx_old_encod_data_out_0),

        .terminate_in_tx       (terminate_in_1_tx),
        .terminate_out_tx      (terminate_out_1_tx),
        .start_in_tx           (start_in_1_tx),
        .start_out_tx          (start_out_1_tx),

        .terminate_in_rx       (terminate_in_1_rx),
        .terminate_out_rx      (terminate_out_1_rx),
        .start_in_rx           (start_in_1_rx),
        .start_out_rx          (start_out_1_rx)
    );

    PCS_core_rx #(
        .PCS_ID(2)
      ) INST_2_PCS_core (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .pcs_sync           (pcs_sync),
        .start_fifo         (start_fifo),
        .start_fifo_rd      (start_fifo_rd),
        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),

        // PCS Signals
        .rx_jtm_en          (rx_jtm_en),
        .bypass_descram     (bypass_descram),
        .bypass_scram       (bypass_scram),
        .bypass_66decoder   (bypass_66decoder),
        .bypass_66encoder   (bypass_66encoder),
        .clear_errblk       (clear_errblk),
        .clear_ber_cnt      (clear_ber_cnt),
        .tx_jtm_en          (tx_jtm_en),
        .jtm_dps_0          (jtm_dps_0),
        .jtm_dps_1          (jtm_dps_1),
        .seed_A             (seed_A),
        .seed_B             (seed_B),

        // .rx_header_valid_in (pcs_2_valid_out),
        // .rx_data_valid_in   (pcs_2_valid_out),
        // .rx_header_in       (pcs_2_header_out[1:0]),
        // .rx_data_in         (pcs_2_data_out[63:0]),
        .rx_header_valid_in (v2),
        .rx_data_valid_in   (v2),
        .rx_header_in       (hh2[1:0]),
        .rx_data_in         (d2[63:0]),

        .is_alig            (pcs_2_alignment),
        // .val_in             (valid_2_out_wire),
        .val_in             (dscr_en_ipg),
        .fifo_in            (dscr_2_out_wire),
        .pause_ipg          (tx_wr_pcs),
        .encoded_out        (tx_encoded_pcs2),

        // .gap                (gap),
        // .setIPG             (setIPG),

        .hi_ber             (hi_ber_2),
        .blk_lock           (blk_lock_2),
        .linkstatus         (linkstatus_2),
        .rx_fifo_spill      (rx_fifo_spill_2),
        .tx_fifo_spill      (tx_fifo_spill_2),
        .rxlf               (rxlf_2),
        .txlf               (txlf_2),
        .ber_cnt            (ber_cnt_2[5:0]),
        .errd_blks          (errd_blks_2[7:0]),
        .jtest_errc         (jtest_errc_2[15:0]),
        // .tx_data_out        (tx_data_out_2[63:0]),
        // .tx_header_out      (tx_header_out_2[1:0]),
        .tx_data_out        (tx_data_int_2[63:0]),
        .tx_header_out      (tx_header_int_2[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_2),
        .tx_sequence_out    (tx_sequence_out_2),
        .xgmii_txc          (xgmii_txc_lane_2), // MII do zero POR ENQUANTO
        .xgmii_txd          (xgmii_txd_lane_2), // MII do zero POR ENQUANTO
        .xgmii_rxd          (xgmii_rxd_lane_2),
        .xgmii_rxc          (xgmii_rxc_lane_2),
        .dscr_out           (pcs_2_dscr),

        // .rx_old_header_in   (pcs_1_header_out[1:0]),
        // .rx_old_data_in     (pcs_1_data_out[63:0]),
        .rx_old_header_in   (hh1[1:0]),
        .rx_old_data_in     (d1[63:0]),

        .tx_old_scr_data_out (tx_old_encod_data_out_2),
        .tx_old_scr_data_in	 (tx_old_encod_data_out_1),
        .scram_en            (pcs_2_scram_en),

        .terminate_in_tx       (terminate_in_2_tx),
        .terminate_out_tx      (terminate_out_2_tx),
        .start_in_tx           (start_in_2_tx),
        .start_out_tx          (start_out_2_tx),

        .terminate_in_rx       (terminate_in_2_rx),
        .terminate_out_rx      (terminate_out_2_rx),
        .start_in_rx           (start_in_2_rx),
        .start_out_rx          (start_out_2_rx)
    );

    PCS_core_rx #(
        .PCS_ID(3)
      ) INST_3_PCS_core (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .pcs_sync           (pcs_sync),
        .start_fifo         (start_fifo),
        .start_fifo_rd      (start_fifo_rd),
        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),

        // PCS Signals
        .rx_jtm_en          (rx_jtm_en),
        .bypass_descram     (bypass_descram),
        .bypass_scram       (bypass_scram),
        .bypass_66decoder   (bypass_66decoder),
        .bypass_66encoder   (bypass_66encoder),
        .clear_errblk       (clear_errblk),
        .clear_ber_cnt      (clear_ber_cnt),
        .tx_jtm_en          (tx_jtm_en),
        .jtm_dps_0          (jtm_dps_0),
        .jtm_dps_1          (jtm_dps_1),
        .seed_A             (seed_A),
        .seed_B             (seed_B),

        // .rx_header_valid_in (pcs_3_valid_out),
        // .rx_data_valid_in   (pcs_3_valid_out),
        // .rx_header_in       (pcs_3_header_out[1:0]),
        // .rx_data_in         (pcs_3_data_out[63:0]),
        .rx_header_valid_in (v3),
        .rx_data_valid_in   (v3),
        .rx_header_in       (hh3[1:0]),
        .rx_data_in         (d3[63:0]),

        .is_alig            (pcs_3_alignment),
        // .val_in             (valid_3_out_wire),
        .val_in             (dscr_en_ipg),
        .fifo_in            (dscr_3_out_wire),
        .pause_ipg          (tx_wr_pcs),
        .encoded_out        (tx_encoded_pcs3),

        // .gap                (gap),
        // .setIPG             (setIPG),

        .hi_ber             (hi_ber_3),
        .blk_lock           (blk_lock_3),
        .linkstatus         (linkstatus_3),
        .rx_fifo_spill      (rx_fifo_spill_3),
        .tx_fifo_spill      (tx_fifo_spill_3),
        .rxlf               (rxlf_3),
        .txlf               (txlf_3),
        .ber_cnt            (ber_cnt_3[5:0]),
        .errd_blks          (errd_blks_3[7:0]),
        .jtest_errc         (jtest_errc_3[15:0]),
        // .tx_data_out        (tx_data_out_3[63:0]),
        // .tx_header_out      (tx_header_out_3[1:0]),
        .tx_data_out        (tx_data_int_3[63:0]),
        .tx_header_out      (tx_header_int_3[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_3),
        .tx_sequence_out    (tx_sequence_out_3),
        .xgmii_txc          (xgmii_txc_lane_3), // MII do zero POR ENQUANTO
        .xgmii_txd          (xgmii_txd_lane_3), // MII do zero POR ENQUANTO
        .xgmii_rxd          (xgmii_rxd_lane_3),
        .xgmii_rxc          (xgmii_rxc_lane_3),
        .dscr_out           (pcs_3_dscr),

        // .rx_old_header_in   (pcs_2_header_out[1:0]),
        // .rx_old_data_in     (pcs_2_data_out[63:0]),
        .rx_old_header_in   (hh2[1:0]),
        .rx_old_data_in     (d2[63:0]),

        .tx_old_scr_data_out (tx_old_encod_data_out_3),
        .tx_old_scr_data_in	 (tx_old_encod_data_out_2),
        .scram_en            (pcs_3_scram_en),

        .terminate_in_tx       (terminate_in_3_tx),
        .terminate_out_tx      (terminate_out_3_tx),
        .start_in_tx           (start_in_3_tx),
        .start_out_tx          (start_out_3_tx),

        .terminate_in_rx       (terminate_in_3_rx),
        .terminate_out_rx     (terminate_out_3_rx),
        .start_in_rx           (start_in_3_rx),
        .start_out_rx          (start_out_3_rx)
    );


    // xge_mac_rx INST_xge_mac
    // (   // Simple Tx-Rx interface signals
    //     .clk_156m25         (clk_156),
    //     .clk_xgmii_rx       (clk_xgmii_rx),
    //     .clk_xgmii_tx       (clk_xgmii_tx),
    //
    //     .reset_156m25_n     (async_reset_n),
    //     .reset_xgmii_tx_n   (reset_tx_done),
    //     .reset_xgmii_rx_n   (reset_rx_done),
    //
    //     .pkt_rx_ren         (pkt_rx_ren),
    //     .pkt_rx_avail       (pkt_rx_avail),
    //     .pkt_rx_data        (pkt_rx_data),
    //     .pkt_rx_eop         (pkt_rx_eop),
    //     .pkt_rx_err         (pkt_rx_err),
    //     .pkt_rx_mod         (pkt_rx_mod),
    //     .pkt_rx_sop         (pkt_rx_sop),
    //     .pkt_rx_val         (pkt_rx_val),
    //
    //     .pkt_tx_data        (pkt_tx_data[63:0]),
    //     .pkt_tx_eop         (pkt_tx_eop),
    //     .pkt_tx_mod         (pkt_tx_mod[2:0]),
    //     .pkt_tx_sop         (pkt_tx_sop[1]),
    //     .pkt_tx_full        (pkt_tx_full),
    //     .pkt_tx_val         (pkt_tx_val),
    //
    //     .wb_clk_i           (clk_156),
    //     .wb_rst_i           (async_reset_n),
    //     .wb_adr_i           (wb_adr_i),
    //     .wb_cyc_i           (wb_cyc_i),
    //     .wb_dat_i           (wb_dat_i),
    //     .wb_stb_i           (wb_stb_i),
    //     .wb_we_i            (wb_we_i),
    //     .wb_ack_o           (wb_ack_o),
    //     .wb_dat_o           (wb_dat_o),
    //     .wb_int_o           (wb_int_o),
    //
    //     .data_in_from_if    (mac_data),
    //     .eop_in_from_if     (mac_eop),
    //     .sop_in_from_if     (mac_sop),
    //
    //     .xgmii_txc          (xgmii_txc),
    //     .xgmii_txd          (xgmii_txd),
    //
    //     .xgmii_rxc_0        (xgmii_rxc_lane_0),
    //     .xgmii_rxd_0        (xgmii_rxd_lane_0),
    //     .xgmii_rxc_1        (xgmii_rxc_lane_1),
    //     .xgmii_rxd_1        (xgmii_rxd_lane_1),
    //     .xgmii_rxc_2        (xgmii_rxc_lane_2),
    //     .xgmii_rxd_2        (xgmii_rxd_lane_2),
    //     .xgmii_rxc_3        (xgmii_rxc_lane_3),
    //     .xgmii_rxd_3        (xgmii_rxd_lane_3)
    // );

    pcs_alignment INST_pcs_alignment
    (
        .clk_161            (tx_clk_161_13),
        .clk_156            (clk_156),
        .rst                (reset_rx_n),
        .lane_0_data_in     (tx_data_int_0[63:0]),
        .lane_0_header_in   (tx_header_int_0[1:0]),
        .lane_1_data_in     (tx_data_int_1[63:0]),
        .lane_1_header_in   (tx_header_int_1[1:0]),
        .lane_2_data_in     (tx_data_int_2[63:0]),
        .lane_2_header_in   (tx_header_int_2[1:0]),
        .lane_3_data_in     (tx_data_int_3[63:0]),
        .lane_3_header_in   (tx_header_int_3[1:0]),
        .tx_sequence_cnt_in (tx_sequence_out_0[6:0]),
        .scr_en_in          (pcs_1_scram_en),

        .tx_encoded_pcs0    (tx_encoded_pcs0),
        .tx_encoded_pcs1    (tx_encoded_pcs1),
        .tx_encoded_pcs2    (tx_encoded_pcs2),
        .tx_encoded_pcs3    (tx_encoded_pcs3),
        .tx_wr_pcs          (tx_wr_pcs),

        .pause_scr_alignm   (pcs_sync),
        .lane_0_valid_out   (tx_valid_out_0),
        .lane_0_data_out    (tx_data_out_0[63:0]),
        .lane_0_header_out  (tx_header_out_0[1:0]),
        .lane_1_valid_out   (tx_valid_out_1),
        .lane_1_data_out    (tx_data_out_1[63:0]),
        .lane_1_header_out  (tx_header_out_1[1:0]),
        .lane_2_valid_out   (tx_valid_out_2),
        .lane_2_data_out    (tx_data_out_2[63:0]),
        .lane_2_header_out  (tx_header_out_2[1:0]),
        .lane_3_valid_out   (tx_valid_out_3),
        .lane_3_data_out    (tx_data_out_3[63:0]),
        .lane_3_header_out  (tx_header_out_3[1:0])
    );

    alignment_removal INST_alignment_removal
    (
      .clk        (rx_clk_161_13),
      .rst        (reset_rx_n),

      .is_alig_0  (pcs_0_alignment),
      .is_alig_1  (pcs_1_alignment),
      .is_alig_2  (pcs_2_alignment),
      .is_alig_3  (pcs_3_alignment),

      .valid_0    (pcs_0_valid_out),
      .valid_1    (pcs_1_valid_out),
      .valid_2    (pcs_2_valid_out),
      .valid_3    (pcs_3_valid_out),
      .header_0   (pcs_0_header_out[1:0]),
      .header_1   (pcs_1_header_out[1:0]),
      .header_2   (pcs_2_header_out[1:0]),
      .header_3   (pcs_3_header_out[1:0]),
      .data_0     (pcs_0_data_out[63:0]),
      .data_1     (pcs_1_data_out[63:0]),
      .data_2     (pcs_2_data_out[63:0]),
      .data_3     (pcs_3_data_out[63:0]),

      .dscr_0     (pcs_0_dscr),
      .dscr_1     (pcs_1_dscr),
      .dscr_2     (pcs_2_dscr),
      .dscr_3     (pcs_3_dscr),



      .dscr_en_ipg    (dscr_en_ipg),

      .vvalid_0_out   (v0),
      .vvalid_1_out   (v1),
      .vvalid_2_out   (v2),
      .vvalid_3_out   (v3),
      .header_0_out   (hh0[1:0]),
      .header_1_out   (hh1[1:0]),
      .header_2_out   (hh2[1:0]),
      .header_3_out   (hh3[1:0]),
      .data_0_out     (d0[63:0]),
      .data_1_out     (d1[63:0]),
      .data_2_out     (d2[63:0]),
      .data_3_out     (d3[63:0]),

      .valid_0_out (valid_0_out_wire),
      .valid_1_out (valid_1_out_wire),
      .valid_2_out (valid_2_out_wire),
      .valid_3_out (valid_3_out_wire),

      // .dscr_0_out (dscr_0_out_wire),
      // .dscr_1_out (dscr_1_out_wire),
      // .dscr_2_out (dscr_2_out_wire),
      // .dscr_3_out (dscr_3_out_wire),

      .ddscr_0_out (dscr_0_out_wire),
      .ddscr_1_out (dscr_1_out_wire),
      .ddscr_2_out (dscr_2_out_wire),
      .ddscr_3_out (dscr_3_out_wire)

      // .gap        (gap),
      // .setIPG     (setIPG)
    );

endmodule
