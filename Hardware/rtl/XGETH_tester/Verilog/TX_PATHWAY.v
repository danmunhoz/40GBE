////////////////////////////////////////////////////////////////////////
////                                                                ////
//// File name "TX_PATH.v"                                          ////
////                                                                ////
//// This file is part of "Testset X40G" project                    ////
////                                                                ////
//// Author(s):                                                     ////
//// - Matheus Lemes Ferronato                                      ////
//// - Gabriel Susin                                                ////
////                                                                ////
////////////////////////////////////////////////////////////////////////

module tx_pathway(
    // Clocks
      clk_156, tx_clk161,
      // Resets
        async_reset_n, reset_tx_n, reset_rx_n,
      // PCS CORE
        //INPUTS
         bypass_66encoder, bypass_scram, tx_jtm_en,
         jtm_dps_0, jtm_dps_1, start_fifo, start_fifo_rd,
         seed_A, seed_B,

        //OUTPUTS
          fill_pcs_tx, tx_fifo_spill,

      // PCS ALIGNMENT
        //OUTPUTS
          tx_data_out_0, tx_data_out_1, tx_data_out_2,
          tx_data_out_3, tx_header_out_0, tx_header_out_1, tx_header_out_2,
          tx_header_out_3, tx_valid_out_0, tx_valid_out_1, tx_valid_out_2,
          tx_valid_out_3,

      // MAC
        //INPUTS
          pkt_tx_data, pkt_tx_sop, pkt_tx_mod, pkt_tx_eop, pkt_tx_val

    );

  //INPUT AND OUTPUTS {
    // Clocks
      input           clk_156;
      input           tx_clk161;

    // Resets
      input           async_reset_n;
      input           reset_tx_n;
      input           reset_rx_n;

    // MAC
      //INPUTS
        (* KEEP = "true" *) input [255:0] pkt_tx_data;
        (* KEEP = "true" *) input [1:0] pkt_tx_sop;
        (* KEEP = "true" *) input [4:0] pkt_tx_mod;
        (* KEEP = "true" *) input pkt_tx_eop;
        (* KEEP = "true" *) input pkt_tx_val;

    // PCS CORE
      //INPUTS
        input         bypass_66encoder;
        input         bypass_scram;
        input         tx_jtm_en;
        input         jtm_dps_0;
        input         jtm_dps_1;
        input					start_fifo;
      	input					start_fifo_rd;
        input [57:0]  seed_A;
        input [57:0]  seed_B;

      //OUTPUTS

        output [8:0]  fill_pcs_tx;
        output        tx_fifo_spill;

    // PCS ALIGNMENT
      //OUTPUTS
        output [63:0] tx_data_out_0;
        output [63:0] tx_data_out_1;
        output [63:0] tx_data_out_2;
        output [63:0] tx_data_out_3;
        output [1:0]  tx_header_out_0;
        output [1:0]  tx_header_out_1;
        output [1:0]  tx_header_out_2;
        output [1:0]  tx_header_out_3;
        output        tx_valid_out_0;
        output        tx_valid_out_1;
        output        tx_valid_out_2;
        output        tx_valid_out_3;

  // }

  //WIRES AND REGS {

    // MAC

      (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_0;
      (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_1;
      (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_2;
      (* syn_keep = "true"*) wire [63:0] xgmii_txd_lane_3;
      (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_0;
      (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_1;
      (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_2;
      (* syn_keep = "true"*) wire [7:0]  xgmii_txc_lane_3;

    // PCS CORE
      reg             start_out_0_tx_r;
      reg             start_out_1_tx_r;
      reg             start_out_2_tx_r;
      reg             start_out_3_tx_r;

      wire [63:0]     tx_data_int_0;
      wire [63:0]     tx_data_int_1;
      wire [63:0]     tx_data_int_2;
      wire [63:0]     tx_data_int_3;
      wire [8:0]      fill_tx_pcs0;
      wire [8:0]      fill_tx_pcs1;
      wire [8:0]      fill_tx_pcs2;
      wire [8:0]      fill_tx_pcs3;
      wire [6:0]      tx_sequence_out_0;
      wire [6:0]      tx_sequence_out_1;
      wire [6:0]      tx_sequence_out_2;
      wire [6:0]      tx_sequence_out_3;
      wire [1:0]      tx_header_int_0;
      wire [1:0]      tx_header_int_1;
      wire [1:0]      tx_header_int_2;
      wire [1:0]      tx_header_int_3;
      wire            pcs_sync;
      wire            pcs_0_scram_en;
      wire            pcs_1_scram_en;
      wire            pcs_2_scram_en;
      wire            pcs_3_scram_en;
      wire            start_out_0_tx;
      wire            start_out_1_tx;
      wire            start_out_2_tx;
      wire            start_out_3_tx;
      wire            start_in_0_tx = (start_out_3_tx_r || start_out_1_tx_r || start_out_2_tx_r);
      wire            start_in_1_tx = (start_out_0_tx_r || start_out_2_tx_r || start_out_3_tx_r || start_out_0_tx);
      wire            start_in_2_tx = (start_out_0_tx_r || start_out_1_tx_r || start_out_3_tx_r || start_out_0_tx || start_out_1_tx);
      wire            start_in_3_tx = (start_out_0_tx_r || start_out_1_tx_r || start_out_2_tx_r || start_out_0_tx || start_out_1_tx || start_out_2_tx);
      wire            terminate_out_0_tx;
      wire            terminate_out_1_tx;
      wire            terminate_out_2_tx;
      wire            terminate_out_3_tx;
      wire            terminate_in_0_tx = 1'b0;
      wire            terminate_in_1_tx = terminate_out_0_tx;
      wire            terminate_in_2_tx = (terminate_out_0_tx || terminate_out_1_tx);
      wire            terminate_in_3_tx = (terminate_out_0_tx || terminate_out_1_tx || terminate_out_2_tx);
      wire            tx_fifo_spill_0;
      wire            tx_fifo_spill_1;
      wire            tx_fifo_spill_2;
      wire            tx_fifo_spill_3;
      wire            txlf_0;
      wire            txlf_1;
      wire            txlf_2;
      wire            txlf_3;


      (* syn_keep = "true"*) reg  [63:0] tx_old_encod_data_out_3_reg;

      (* syn_keep = "true"*) wire tx_wr_pcs;
      (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs0;
      (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs1;
      (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs2;
      (* syn_keep = "true"*) wire [65:0] tx_encoded_pcs3;
      (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_0;
      (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_1;
      (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_2;
      (* syn_keep = "true"*) wire [63:0] tx_old_encod_data_out_3;


      wire [6:0]     tx_sequence_cnt_out;
  // }

  //BEGIN

  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //AUX STUFF ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  always @ (posedge tx_clk161 or negedge async_reset_n) begin
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

  start_out_0_tx_r <= 1'b0;
  start_out_1_tx_r <= 1'b0;
  start_out_2_tx_r <= 1'b0;
  start_out_3_tx_r <= 1'b0;
  end
  else begin

  start_out_0_tx_r <= start_out_0_tx;
  start_out_1_tx_r <= start_out_1_tx;
  start_out_2_tx_r <= start_out_2_tx;
  start_out_3_tx_r <= start_out_3_tx;
  end
  end
    // For Testbench
    assign txlf = txlf_0;
    assign tx_fifo_spill = tx_fifo_spill_0;
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //MAC INSTANTIATION////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////
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


  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //PCS TX CORE//////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////
tx_path_tx #(
    .PCS_ID(0)
  ) INST_0_tx_path(        // Inputs
    .clk156                (clk_156),
    .tx_clk161             (tx_clk161),
    .arstb                 (reset_tx_n),
    .bypass_66encoder      (bypass_66encoder),
    .bypass_scram          (bypass_scram),
    .tx_jtm_en             (tx_jtm_en),
    .jtm_dps_0             (jtm_dps_0),
    .jtm_dps_1             (jtm_dps_1),
    .seed_A                (seed_A),
    .seed_B                (seed_B),
    .xgmii_txc             (xgmii_txc_lane_0),
    .xgmii_txd             (xgmii_txd_lane_0),
    .terminate_in          (terminate_in_0_tx),
    .start_in              (start_in_0_tx),
    .tx_old_scr_data_in	   (tx_old_encod_data_out_3_reg),
    .tx_old_scr_data_out   (tx_old_encod_data_out_0),
    .start_fifo            (start_fifo),
    .start_fifo_rd         (start_fifo_rd),
    .pcs_sync              (pcs_sync),
    .pause_ipg             (tx_wr_pcs),

    // Outputs
    .fill_out              (fill_tx_pcs0),
    .txlf                  (txlf_0),
    .spill                 (tx_fifo_spill_0),
    .tx_data_out           (tx_data_int_0[63:0]),
    .tx_header_out         (tx_header_int_0[1:0]),
    .tx_sequence_out       (tx_sequence_out_0),
    .terminate_out         (terminate_out_0_tx),
    .start_out             (start_out_0_tx),
    .scram_en              (pcs_0_scram_en),
    .encoded_out           (tx_encoded_pcs0)
    );

tx_path_tx #(
    .PCS_ID(1)
  ) INST_1_tx_path(   // Inputs
    .clk156                (clk_156),
    .tx_clk161             (tx_clk161),
    .arstb                 (reset_tx_n),
    .bypass_66encoder      (bypass_66encoder),
    .bypass_scram          (bypass_scram),
    .tx_jtm_en             (tx_jtm_en),
    .jtm_dps_0             (jtm_dps_0),
    .jtm_dps_1             (jtm_dps_1),
    .seed_A                (seed_A),
    .seed_B                (seed_B),
    .xgmii_txc             (xgmii_txc_lane_1),
    .xgmii_txd             (xgmii_txd_lane_1),
    .terminate_in          (terminate_in_1_tx),
    .start_in              (start_in_1_tx),
    .tx_old_scr_data_in	   (tx_old_encod_data_out_0),
    .tx_old_scr_data_out   (tx_old_encod_data_out_1),
    .start_fifo            (start_fifo),
    .start_fifo_rd         (start_fifo_rd),
    .pcs_sync              (pcs_sync),
    .pause_ipg             (tx_wr_pcs),

    // Outputs
    .fill_out              (fill_tx_pcs1),
    .txlf                  (txlf_1),
    .spill                 (tx_fifo_spill_1),
    .tx_data_out           (tx_data_int_1[63:0]),
    .tx_header_out         (tx_header_int_1[1:0]),
    .tx_sequence_out       (tx_sequence_out_1),
    .terminate_out         (terminate_out_1_tx),
    .start_out             (start_out_1_tx),
    .scram_en              (pcs_1_scram_en),
    .encoded_out           (tx_encoded_pcs1)
                        );

tx_path_tx #(
    .PCS_ID(2)
  ) INST_2_tx_path(   // Inputs
    .clk156                (clk_156),
    .tx_clk161             (tx_clk161),
    .arstb                 (reset_tx_n),
    .bypass_66encoder      (bypass_66encoder),
    .bypass_scram          (bypass_scram),
    .tx_jtm_en             (tx_jtm_en),
    .jtm_dps_0             (jtm_dps_0),
    .jtm_dps_1             (jtm_dps_1),
    .seed_A                (seed_A),
    .seed_B                (seed_B),
    .xgmii_txc             (xgmii_txc_lane_2),
    .xgmii_txd             (xgmii_txd_lane_2),
    .terminate_in          (terminate_in_2_tx),
    .start_in              (start_in_2_tx),
    .tx_old_scr_data_in	   (tx_old_encod_data_out_1),
    .tx_old_scr_data_out   (tx_old_encod_data_out_2),
    .start_fifo            (start_fifo),
    .start_fifo_rd         (start_fifo_rd),
    .pcs_sync              (pcs_sync),
    .pause_ipg             (tx_wr_pcs),

    // Outputs
    .fill_out              (fill_tx_pcs2),
    .txlf                  (txlf_2),
    .spill                 (tx_fifo_spill_2),
    .tx_data_out           (tx_data_int_2[63:0]),
    .tx_header_out         (tx_header_int_2[1:0]),
    .tx_sequence_out       (tx_sequence_out_2),
    .terminate_out         (terminate_out_2_tx),
    .start_out             (start_out_2_tx),
    .scram_en              (pcs_2_scram_en),
    .encoded_out           (tx_encoded_pcs2)
                        );

tx_path_tx #(
    .PCS_ID(3)
  ) INST_3_tx_path(   // Inputs
    .clk156                (clk_156),
    .tx_clk161             (tx_clk161),
    .arstb                 (reset_tx_n),
    .bypass_66encoder      (bypass_66encoder),
    .bypass_scram          (bypass_scram),
    .tx_jtm_en             (tx_jtm_en),
    .jtm_dps_0             (jtm_dps_0),
    .jtm_dps_1             (jtm_dps_1),
    .seed_A                (seed_A),
    .seed_B                (seed_B),
    .xgmii_txc             (xgmii_txc_lane_3),
    .xgmii_txd             (xgmii_txd_lane_3),
    .terminate_in          (terminate_in_3_tx),
    .start_in              (start_in_3_tx),
    .tx_old_scr_data_in	   (tx_old_encod_data_out_2),
    .tx_old_scr_data_out   (tx_old_encod_data_out_3),
    .start_fifo            (start_fifo),
    .start_fifo_rd         (start_fifo_rd),
    .pcs_sync              (pcs_sync),
    .pause_ipg             (tx_wr_pcs),

    // Outputs
    .fill_out              (fill_tx_pcs3),
    .txlf                  (txlf_3),
    .spill                 (tx_fifo_spill_3),
    .tx_data_out           (tx_data_int_3[63:0]),
    .tx_header_out         (tx_header_int_3[1:0]),
    .tx_sequence_out       (tx_sequence_out_3),
    .terminate_out         (terminate_out_3_tx),
    .start_out             (start_out_3_tx),
    .scram_en              (pcs_3_scram_en),
    .encoded_out           (tx_encoded_pcs3)
                        );

  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //PCS ALIGNMENT////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////
pcs_alignment INST_pcs_alignment
(
    .clk_161             (tx_clk161),
    .clk_156             (clk_156),
    .rst                 (reset_rx_n),
    .lane_0_data_in      (tx_data_int_0[63:0]),
    .lane_0_header_in    (tx_header_int_0[1:0]),
    .lane_1_data_in      (tx_data_int_1[63:0]),
    .lane_1_header_in    (tx_header_int_1[1:0]),
    .lane_2_data_in      (tx_data_int_2[63:0]),
    .lane_2_header_in    (tx_header_int_2[1:0]),
    .lane_3_data_in      (tx_data_int_3[63:0]),
    .lane_3_header_in    (tx_header_int_3[1:0]),
    .tx_sequence_cnt_in  (tx_sequence_out_0[6:0]),
    .scr_en_in           (pcs_1_scram_en),

    .tx_encoded_pcs0     (tx_encoded_pcs0),
    .tx_encoded_pcs1     (tx_encoded_pcs1),
    .tx_encoded_pcs2     (tx_encoded_pcs2),
    .tx_encoded_pcs3     (tx_encoded_pcs3),

    .tx_fill_pcs0        (fill_tx_pcs0),
    .tx_fill_pcs1        (fill_tx_pcs1),
    .tx_fill_pcs2        (fill_tx_pcs2),
    .tx_fill_pcs3        (fill_tx_pcs3),

    .tx_wr_pcs           (tx_wr_pcs),

    .pause_scr_alignm    (pcs_sync),
    .lane_0_valid_out    (tx_valid_out_0),
    .lane_0_data_out     (tx_data_out_0[63:0]),
    .lane_0_header_out   (tx_header_out_0[1:0]),
    .lane_1_valid_out    (tx_valid_out_1),
    .lane_1_data_out     (tx_data_out_1[63:0]),
    .lane_1_header_out   (tx_header_out_1[1:0]),
    .lane_2_valid_out    (tx_valid_out_2),
    .lane_2_data_out     (tx_data_out_2[63:0]),
    .lane_2_header_out   (tx_header_out_2[1:0]),
    .lane_3_valid_out    (tx_valid_out_3),
    .lane_3_data_out     (tx_data_out_3[63:0]),
    .lane_3_header_out   (tx_header_out_3[1:0]),
    .tx_sequence_cnt_out (tx_sequence_cnt_out[6:0])
);


endmodule
