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

module wrapper_macpcs(
                        //---- -------- Inputs ----------------//

                        // Clocks
                        clk_156, tx_clk_161_13, rx_clk_161_13, clk_xgmii_rx, clk_xgmii_tx,
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
                       rx_header_valid_in, rx_header_in, rx_data_in, rx_data_valid_in,
                        // PCS
                        jtest_errc, ber_cnt, hi_ber, blk_lock, linkstatus, rx_fifo_spill, tx_fifo_spill, rxlf, txlf, errd_blks,
                        // XMAC
                        pkt_rx_avail, pkt_rx_data, pkt_rx_eop, pkt_rx_err, pkt_rx_mod, pkt_rx_sop, pkt_rx_val, pkt_tx_full,
                        // Wishbone (XMAC)
                        wb_ack_o, wb_dat_o, wb_int_o,
                        // Para uso do Testbench
            						start_fifo,
                        dump_xgmii_txc,
                        dump_xgmii_txd
                        );

    // Clocks
    input           clk_156;
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
    (* KEEP = "true" *)
    input        rx_header_valid_in;
    (* KEEP = "true" *)
    input [1:0]  rx_header_in;
    (* KEEP = "true" *)
    input        rx_data_valid_in;
    (* KEEP = "true" *)
    input [63:0] rx_data_in;

    //For Testbench use
		input					start_fifo;

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


    // MAC Inputs
    (* KEEP = "true" *)
    input           pkt_rx_ren;
    (* KEEP = "true" *)
    input [63:0]    pkt_tx_data;
    (* KEEP = "true" *)
    input           pkt_tx_eop;
    (* KEEP = "true" *)
    input [2:0]     pkt_tx_mod;
    (* KEEP = "true" *)
    input           pkt_tx_sop;
    (* KEEP = "true" *)
    input           pkt_tx_val;

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
    output [7:0]    dump_xgmii_txc;
    output [63:0]   dump_xgmii_txd;


    wire            tx_clk_161_13;
    wire            rx_clk_161_13;
    wire            clk_156;
    wire            async_reset_n;


// MAC/PCS XGMII Interconnection
    (* syn_keep = "true"*)
    wire [7:0]      xgmii_txc;
        (* syn_keep = "true"*)
    wire [63:0]     xgmii_txd;
            (* syn_keep = "true"*)
    wire [7:0]      xgmii_rxc;
                (* syn_keep = "true"*)
    wire [63:0]     xgmii_rxd;

    assign dump_xgmii_txc = xgmii_txc;
    assign dump_xgmii_txd = xgmii_txd;


    PCS_core INST_PCS_core
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
        .rx_header_valid_in (rx_header_valid_in),
        .rx_header_in       (rx_header_in[1:0]),
        .rx_data_valid_in   (rx_data_valid_in),
        .rx_data_in         (rx_data_in[63:0]),
        .hi_ber             (hi_ber),
        .blk_lock           (blk_lock),
        .linkstatus         (linkstatus),
        .rx_fifo_spill      (rx_fifo_spill),
        .tx_fifo_spill      (tx_fifo_spill),
        .rxlf               (rxlf),
        .txlf               (txlf),
        .ber_cnt            (ber_cnt[5:0]),
        .errd_blks          (errd_blks[7:0]),
        .jtest_errc         (jtest_errc[15:0]),
        .tx_data_out        (tx_data_out[63:0]),
        .tx_header_out      (tx_header_out[1:0]),
        .rxgearboxslip_out  (rxgearboxslip_out),
        .tx_sequence_out    (tx_sequence_out),
        .xgmii_txc          (xgmii_txc),
        .xgmii_txd          (xgmii_txd),
        .xgmii_rxd          (xgmii_rxd),
        .xgmii_rxc          (xgmii_rxc)
    );


    xge_mac INST_xge_mac
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

        .pkt_tx_data        (pkt_tx_data),
        .pkt_tx_eop         (pkt_tx_eop),
        .pkt_tx_mod         (pkt_tx_mod),
        .pkt_tx_sop         (pkt_tx_sop),
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

        .xgmii_txc          (xgmii_txc),
        .xgmii_txd          (xgmii_txd),
        .xgmii_rxc_0          (xgmii_txc),
        .xgmii_rxd_0          (xgmii_txd),
        .xgmii_rxc_1          (xgmii_txc),
        .xgmii_rxd_1          (xgmii_txd),
        .xgmii_rxc_2          (xgmii_txc),
        .xgmii_rxd_2          (xgmii_txd),
        .xgmii_rxc_3          (xgmii_txc),
        .xgmii_rxd_3          (xgmii_txd)

        //.xgmii_rxc          (xgmii_rxc),
        //.xgmii_rxd          (xgmii_rxd)
    );

endmodule
