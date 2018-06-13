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
                        tx_data_out, tx_header_out,tx_sequence_out, rxgearboxslip_out,
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
    output [63:0] tx_data_out;
    output [1:0]  tx_header_out;
    output        rxgearboxslip_out;
    output [6:0]  tx_sequence_out;

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

    wire            tx_clk_161_13;
    wire            rx_clk_161_13;
    wire            clk_156;
    wire            async_reset_n;

    reg [63:0]      old_data_0;
    reg [1:0]       old_header_0;

    wire            terminate_out_0;
    wire            terminate_out_1;
    wire            terminate_out_2;
    wire            terminate_out_3;

    wire            start_out_0;
    wire            start_out_1;
    wire            start_out_2;
    wire            start_out_3;

    reg             start_out_0_r;
    reg             start_out_1_r;
    reg             start_out_2_r;
    reg             start_out_3_r;

    wire            terminate_in_0 = 1'b0;
    wire            terminate_in_1 = terminate_out_0;
    wire            terminate_in_2 = (terminate_out_0 || terminate_out_1);
    wire            terminate_in_3 = (terminate_out_0 || terminate_out_1 || terminate_out_2);

    wire            start_in_0 = (start_out_3_r || start_out_1_r || start_out_2_r);
    wire            start_in_1 = (start_out_0_r || start_out_2_r || start_out_3_r || start_out_0);
    wire            start_in_2 = (start_out_0_r || start_out_1_r || start_out_3_r || start_out_0 || start_out_1);
    wire            start_in_3 = (start_out_0_r || start_out_1_r || start_out_2_r || start_out_0 || start_out_1 || start_out_2);

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

    assign empty_fifo = fifo_interface_empty;
    assign full_fifo = fifo_interface_full;

    (* syn_keep = "true"*) wire [1:0]   pcs_0_header_out;
    (* syn_keep = "true"*) wire [63:0]  pcs_0_data_out;
    (* syn_keep = "true"*) wire [1:0]   pcs_1_header_out;
    (* syn_keep = "true"*) wire [63:0]  pcs_1_data_out;
    (* syn_keep = "true"*) wire [1:0]   pcs_2_header_out;
    (* syn_keep = "true"*) wire [63:0]  pcs_2_data_out;
    (* syn_keep = "true"*) wire [1:0]   pcs_3_header_out;
    (* syn_keep = "true"*) wire [63:0]  pcs_3_data_out;

    (* syn_keep = "true"*) wire [1:0]   pcs_0_header_sel;
    (* syn_keep = "true"*) wire [63:0]  pcs_0_data_sel;
    (* syn_keep = "true"*) wire [1:0]   pcs_1_header_sel;
    (* syn_keep = "true"*) wire [63:0]  pcs_1_data_sel;
    (* syn_keep = "true"*) wire [1:0]   pcs_2_header_sel;
    (* syn_keep = "true"*) wire [63:0]  pcs_2_data_sel;
    (* syn_keep = "true"*) wire [1:0]   pcs_3_header_sel;
    (* syn_keep = "true"*) wire [63:0]  pcs_3_data_sel;


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
      else if (pcs_3_valid_out) begin
        // Nao atualiza registrador com valores invalidos
        old_header_0 <= pcs_3_header_out[1:0];
        old_data_0   <= pcs_3_data_out[63:0];
      end
    end

    // Start bit regs
    always @ (posedge clk_156 or negedge async_reset_n) begin
      if (!async_reset_n) begin
        start_out_0_r <= 1'b0;
        start_out_1_r <= 1'b0;
        start_out_2_r <= 1'b0;
        start_out_3_r <= 1'b0;
      end
      else begin
        start_out_0_r <= start_out_0;
        start_out_1_r <= start_out_1;
        start_out_2_r <= start_out_2;
        start_out_3_r <= start_out_3;
      end
    end

    (* dont_touch = "true" *) lane_reorder INST_lane_reorder
    (
      .clock (rx_clk_161_13),
      .reset (reset_rx_n),

      .lane_0_data_in    (rx_lane_0_data_in[63:0]),
      .lane_0_header_in  (rx_lane_0_header_in[1:0]),
      .lane_0_valid_in   (rx_lane_0_data_valid_in),

      .lane_1_data_in    (rx_lane_1_data_in[63:0]),
      .lane_1_header_in  (rx_lane_1_header_in[1:0]),
      .lane_1_valid_in   (rx_lane_1_data_valid_in),

      .lane_2_data_in    (rx_lane_2_data_in[63:0]),
      .lane_2_header_in  (rx_lane_2_header_in[1:0]),
      .lane_2_valid_in   (rx_lane_2_data_valid_in),

      .lane_3_data_in    (rx_lane_3_data_in[63:0]),
      .lane_3_header_in  (rx_lane_3_header_in[1:0]),
      .lane_3_valid_in   (rx_lane_3_data_valid_in),

      .pcs_0_valid_out  (pcs_0_valid_out),
      .pcs_0_header_out (pcs_0_header_out[1:0]),
      .pcs_0_data_out   (pcs_0_data_out[63:0]),

      .pcs_1_valid_out  (pcs_1_valid_out),
      .pcs_1_header_out (pcs_1_header_out[1:0]),
      .pcs_1_data_out   (pcs_1_data_out[63:0]),

      .pcs_2_valid_out  (pcs_2_valid_out),
      .pcs_2_header_out (pcs_2_header_out[1:0]),
      .pcs_2_data_out   (pcs_2_data_out[63:0]),

      .pcs_3_valid_out  (pcs_3_valid_out),
      .pcs_3_header_out (pcs_3_header_out[1:0]),
      .pcs_3_data_out   (pcs_3_data_out[63:0]),

      .fifo_empty_0 (fifo_reorder_empty_0),
      .fifo_empty_1 (fifo_reorder_empty_1),
      .fifo_empty_2 (fifo_reorder_empty_2),
      .fifo_empty_3 (fifo_reorder_empty_3)

    );

    // MAC POR ENQUANTO "QUEBRADO" DENTRO DO WRAPPER: CORE_INTERFACE, CRC CHECKER, FAULTS, ETC...
    // TODO: CRIAR UM MODULO PARA ORGANIZAR TUDO

    (* dont_touch = "true" *) crc_rx INST_crc_rx
    (
      .clk_312  (clk_312),
      .rst_n    (reset_rx_n),
      .mac_data (mac_data),
      .mac_sop  (mac_sop),
      .mac_eop  (mac_eop),
      .app_data (app_data),
      .app_sop  (app_sop),
      .app_val  (app_val),
      .app_eop  (app_eop),
      .crc_ok   (crc_ok)
    );

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
        .ren                (read_fifo),

        .mac_data           (mac_data),
        .mac_sop            (mac_sop),
        .mac_eop            (mac_eop),
        .mac_val            (mac_val),
        .fifo_full          (full_fifo),
        .fifo_empty         (empty_fifo),
        .fifo_almost_f      (fifo_almost_f),
        .fifo_almost_e      (fifo_almost_e)
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



    PCS_core_rx INST_0_PCS_core
    (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .start_fifo         (start_fifo),

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
        .rx_header_valid_in (pcs_0_valid_out),
        .rx_data_valid_in   (pcs_0_valid_out),
        .rx_header_in       (pcs_0_header_out[1:0]),
        .rx_data_in         (pcs_0_data_out[63:0]),
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
        .tx_data_out        (tx_data_out_0[63:0]),
        .tx_header_out      (tx_header_out_0[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_0),
        .tx_sequence_out    (tx_sequence_out_0),
        .xgmii_txc          (xgmii_txc_lane_0),
        .xgmii_txd          (xgmii_txd_lane_0),
        .xgmii_rxd          (xgmii_rxd_lane_0),
        .xgmii_rxc          (xgmii_rxc_lane_0),

        .rx_old_header_in   (old_header_0),
        .rx_old_data_in     (old_data_0),

        .terminate_in       (terminate_in_0),
        .terminate_out      (terminate_out_0),
        .start_in           (start_in_0),
        .start_out          (start_out_0)
    );

    PCS_core_rx INST_1_PCS_core
    (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .start_fifo         (start_fifo),

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
        .rx_header_valid_in (pcs_1_valid_out),
        .rx_data_valid_in   (pcs_1_valid_out),
        .rx_header_in       (pcs_1_header_out[1:0]),
        .rx_data_in         (pcs_1_data_out[63:0]),
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
        .tx_data_out        (tx_data_out_1[63:0]),
        .tx_header_out      (tx_header_out_1[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_1),
        .tx_sequence_out    (tx_sequence_out_1),
        .xgmii_txc          (xgmii_txc_lane_1), // MII do zero POR ENQUANTO
        .xgmii_txd          (xgmii_txd_lane_1), // MII do zero POR ENQUANTO
        .xgmii_rxd          (xgmii_rxd_lane_1),
        .xgmii_rxc          (xgmii_rxc_lane_1),

        .rx_old_header_in   (pcs_0_header_out[1:0]),
        .rx_old_data_in     (pcs_0_data_out[63:0]),

        .terminate_in       (terminate_in_1),
        .terminate_out      (terminate_out_1),
        .start_in           (start_in_1),
        .start_out          (start_out_1)
    );

    PCS_core_rx INST_2_PCS_core
    (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .start_fifo         (start_fifo),

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
        .rx_header_valid_in (pcs_2_valid_out),
        .rx_data_valid_in   (pcs_2_valid_out),
        .rx_header_in       (pcs_2_header_out[1:0]),
        .rx_data_in         (pcs_2_data_out[63:0]),
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
        .tx_data_out        (tx_data_out_2[63:0]),
        .tx_header_out      (tx_header_out_2[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_2),
        .tx_sequence_out    (tx_sequence_out_2),
        .xgmii_txc          (xgmii_txc_lane_2), // MII do zero POR ENQUANTO
        .xgmii_txd          (xgmii_txd_lane_2), // MII do zero POR ENQUANTO
        .xgmii_rxd          (xgmii_rxd_lane_2),
        .xgmii_rxc          (xgmii_rxc_lane_2),

        .rx_old_header_in   (pcs_1_header_out[1:0]),
        .rx_old_data_in     (pcs_1_data_out[63:0]),

        .terminate_in       (terminate_in_2),
        .terminate_out      (terminate_out_2),
        .start_in           (start_in_2),
        .start_out          (start_out_2)
    );

    PCS_core_rx INST_3_PCS_core
    (
        // CLOCKS
        .clk156             (clk_156),
        .tx_clk161          (tx_clk_161_13),
        .rx_clk161          (rx_clk_161_13),
        // RESETS
        .arstb              (async_reset_n),
        .reset_tx_n         (reset_tx_n),
        .reset_rx_n         (reset_rx_n),

        .start_fifo         (start_fifo),

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
        .rx_header_valid_in (pcs_3_valid_out),
        .rx_data_valid_in   (pcs_3_valid_out),
        .rx_header_in       (pcs_3_header_out[1:0]),
        .rx_data_in         (pcs_3_data_out[63:0]),
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
        .tx_data_out        (tx_data_out_3[63:0]),
        .tx_header_out      (tx_header_out_3[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out_3),
        .tx_sequence_out    (tx_sequence_out_3),
        .xgmii_txc          (xgmii_txc_lane_3), // MII do zero POR ENQUANTO
        .xgmii_txd          (xgmii_txd_lane_3), // MII do zero POR ENQUANTO
        .xgmii_rxd          (xgmii_rxd_lane_3),
        .xgmii_rxc          (xgmii_rxc_lane_3),

        .rx_old_header_in   (pcs_2_header_out[1:0]),
        .rx_old_data_in     (pcs_2_data_out[63:0]),

        .terminate_in       (terminate_in_3),
        .terminate_out      (terminate_out_3),
        .start_in           (start_in_3),
        .start_out          (start_out_3)
    );


    xge_mac_rx INST_xge_mac
    (   // Simple Tx-Rx interface signals
        .clk_156m25         (clk_156),
        .clk_xgmii_rx       (clk_xgmii_rx),
        .clk_xgmii_tx       (clk_xgmii_tx),

        .reset_156m25_n     (async_reset_n),
        .reset_xgmii_tx_n   (reset_tx_done),
        .reset_xgmii_rx_n   (reset_rx_done),

        .pkt_rx_ren         (pkt_rx_ren),
        .pkt_rx_avail       (pkt_rx_avail),
        .pkt_rx_data        (pkt_rx_data),
        .pkt_rx_eop         (pkt_rx_eop),
        .pkt_rx_err         (pkt_rx_err),
        .pkt_rx_mod         (pkt_rx_mod),
        .pkt_rx_sop         (pkt_rx_sop),
        .pkt_rx_val         (pkt_rx_val),

        .pkt_tx_data        (pkt_tx_data[63:0]),
        .pkt_tx_eop         (pkt_tx_eop),
        .pkt_tx_mod         (pkt_tx_mod[2:0]),
        .pkt_tx_sop         (pkt_tx_sop[1]),
        .pkt_tx_full        (pkt_tx_full),
        .pkt_tx_val         (pkt_tx_val),

        .wb_clk_i           (clk_156),
        .wb_rst_i           (async_reset_n),
        .wb_adr_i           (wb_adr_i),
        .wb_cyc_i           (wb_cyc_i),
        .wb_dat_i           (wb_dat_i),
        .wb_stb_i           (wb_stb_i),
        .wb_we_i            (wb_we_i),
        .wb_ack_o           (wb_ack_o),
        .wb_dat_o           (wb_dat_o),
        .wb_int_o           (wb_int_o),

        .data_in_from_if    (mac_data),
        .eop_in_from_if     (mac_eop),
        .sop_in_from_if     (mac_sop),

        .xgmii_txc          (xgmii_txc),
        .xgmii_txd          (xgmii_txd),

        .xgmii_rxc_0        (xgmii_rxc_lane_0),
        .xgmii_rxd_0        (xgmii_rxd_lane_0),
        .xgmii_rxc_1        (xgmii_rxc_lane_1),
        .xgmii_rxd_1        (xgmii_rxd_lane_1),
        .xgmii_rxc_2        (xgmii_rxc_lane_2),
        .xgmii_rxd_2        (xgmii_rxd_lane_2),
        .xgmii_rxc_3        (xgmii_rxc_lane_3),
        .xgmii_rxd_3        (xgmii_rxd_lane_3)
    );

endmodule
