////////////////////////////////////////////////////////////////////////
////                                                                ////
//// File name "rx_PATH.v"                                          ////
////                                                                ////
//// This file is part of "Testset X40G" project                    ////
////                                                                ////
//// Author(s):                                                     ////
//// - Matheus Lemes Ferronato                                      ////
//// - Gabriel Susin                                                ////
////                                                                ////
////////////////////////////////////////////////////////////////////////

module rx_pathway(
      //Clocks
      rx_clk161, clk_312, clk_156,
      // Resets
      reset_rx_n, async_reset_n,

      //Labe Reorder
      //INPUTS
      rx_data_in_0, rx_data_in_1, rx_data_in_2,
      rx_data_in_3, rx_header_in_0, rx_header_in_1, rx_header_in_2,
      rx_header_in_3, rx_valid_in_0, rx_valid_in_1, rx_valid_in_2,
      rx_valid_in_3,

      //PCS_RX
      //INPUTS
      rx_jtm_en, bypass_descram, bypass_66decoder, clear_errblk, clear_ber_cnt,
      RDEN_FIFO_PCS40, 	start_fifo,  linkstatus,

      //CRc
      //output
      pkt_rx_eop,  pkt_rx_sop,  pkt_rx_val,  pkt_rx_data,  crc_ok
    );


    //INPUT AND OUTPUTS {
    // Clocks
    input   rx_clk161;
    input   clk_312;
    input   clk_156;

    //reset
    input reset_rx_n;
    input async_reset_n;

    //Labe Reorder
    //INPUTS
    input [63:0] rx_data_in_0;
    input [63:0] rx_data_in_1;
    input [63:0] rx_data_in_2;
    input [63:0] rx_data_in_3;
    input [1:0]  rx_header_in_0;
    input [1:0]  rx_header_in_1;
    input [1:0]  rx_header_in_2;
    input [1:0]  rx_header_in_3;
    input        rx_valid_in_0;
    input        rx_valid_in_1;
    input        rx_valid_in_2;
    input        rx_valid_in_3;

    //PCS_RX
    //inputs
    input         rx_jtm_en;
    input         bypass_descram;
    input         bypass_66decoder;
    input         clear_errblk;
    input         clear_ber_cnt;
    input					RDEN_FIFO_PCS40;
	  input					start_fifo;

    output        linkstatus;


    ///CRC
    //output

    (* syn_keep = "true"*) output  [4:0] pkt_rx_eop;
    (* syn_keep = "true"*) output  pkt_rx_sop;
    (* syn_keep = "true"*) output  pkt_rx_val;
    (* syn_keep = "true"*) output  [127:0] pkt_rx_data;
    (* syn_keep = "true"*) output  crc_ok;


  //WIRES AND REGS {

  // Lane Reorder Wires
  wire            pcs_0_valid_out;
  wire            pcs_1_valid_out;
  wire            pcs_2_valid_out;
  wire            pcs_3_valid_out;
  wire            fifo_reorder_empty_0;
  wire            fifo_reorder_empty_1;
  wire            fifo_reorder_empty_2;
  wire            fifo_reorder_empty_3;
  (* syn_keep = "true"*) wire pcs_0_alignment;
  (* syn_keep = "true"*) wire pcs_1_alignment;
  (* syn_keep = "true"*) wire pcs_2_alignment;
  (* syn_keep = "true"*) wire pcs_3_alignment;
  (* syn_keep = "true"*) wire [1:0]  pcs_0_header_out;
  (* syn_keep = "true"*) wire [63:0] pcs_0_data_out;
  (* syn_keep = "true"*) wire [1:0]  pcs_1_header_out;
  (* syn_keep = "true"*) wire [63:0] pcs_1_data_out;
  (* syn_keep = "true"*) wire [1:0]  pcs_2_header_out;
  (* syn_keep = "true"*) wire [63:0] pcs_2_data_out;
  (* syn_keep = "true"*) wire [1:0]  pcs_3_header_out;
  (* syn_keep = "true"*) wire [63:0] pcs_3_data_out;

  //PCS alignment_removal
  wire [65:0]     pcs_0_dscr;
  wire [65:0]     pcs_1_dscr;
  wire [65:0]     pcs_2_dscr;
  wire [65:0]     pcs_3_dscr;
  wire [8:0]      fill_rx_pcs0;
  wire [8:0]      fill_rx_pcs1;
  wire [8:0]      fill_rx_pcs2;
  wire [8:0]      fill_rx_pcs3;
  (* syn_keep = "true"*) wire dscr_en_ipg;
  (* syn_keep = "true"*) wire valid_0_out_wire;
  (* syn_keep = "true"*) wire valid_1_out_wire;
  (* syn_keep = "true"*) wire valid_2_out_wire;
  (* syn_keep = "true"*) wire valid_3_out_wire;
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
  (* syn_keep = "true"*) wire [65:0] dscr_0_out_wire;
  (* syn_keep = "true"*) wire [65:0] dscr_1_out_wire;
  (* syn_keep = "true"*) wire [65:0] dscr_2_out_wire;
  (* syn_keep = "true"*) wire [65:0] dscr_3_out_wire;

  //rx_path_rx

  reg [63:0]      old_data_0;
  reg [1:0]       old_header_0;

  wire            terminate_out_0_rx;
  wire            terminate_out_1_rx;
  wire            terminate_out_2_rx;
  wire            terminate_out_3_rx;

  wire            start_out_0_rx;
  wire            start_out_1_rx;
  wire            start_out_2_rx;
  wire            start_out_3_rx;
  wire            terminate_in_0_rx = 1'b0;
  wire            terminate_in_1_rx = terminate_out_0_rx;
  wire            terminate_in_2_rx = (terminate_out_0_rx || terminate_out_1_rx);
  wire            terminate_in_3_rx = (terminate_out_0_rx || terminate_out_1_rx || terminate_out_2_rx);

  wire [15:0]     jtest_errc_0;
  wire [15:0]     jtest_errc_1;
  wire [15:0]     jtest_errc_2;
  wire [15:0]     jtest_errc_3;

  reg             start_out_0_rx_r;
  reg             start_out_1_rx_r;
  reg             start_out_2_rx_r;
  reg             start_out_3_rx_r;

  wire            start_in_0_rx = (start_out_3_rx_r || start_out_1_rx_r || start_out_2_rx_r);
  wire            start_in_1_rx = (start_out_0_rx_r || start_out_2_rx_r || start_out_3_rx_r || start_out_0_rx);
  wire            start_in_2_rx = (start_out_0_rx_r || start_out_1_rx_r || start_out_3_rx_r || start_out_0_rx || start_out_1_rx);
  wire            start_in_3_rx = (start_out_0_rx_r || start_out_1_rx_r || start_out_2_rx_r || start_out_0_rx || start_out_1_rx || start_out_2_rx);

  wire        hi_ber_0;
  wire [5:0]  ber_cnt_0;
  wire [7:0]  errd_blks_0;


  wire        blk_lock_0;
  wire        linkstatus_0;
  wire        rx_fifo_spill_0;
  wire        rxlf_0;
  wire        rxgearboxslip_out_0;

  wire        hi_ber_1;
  wire [5:0]  ber_cnt_1;
  wire [7:0]  errd_blks_1;


  wire        blk_lock_1;
  wire        linkstatus_1;
  wire        rx_fifo_spill_1;
  wire        rxlf_1;
  wire        rxgearboxslip_out_1;

  wire        hi_ber_2;
  wire [5:0]  ber_cnt_2;
  wire [7:0]  errd_blks_2;


  wire        blk_lock_2;
  wire        linkstatus_2;
  wire        rx_fifo_spill_2;
  wire        rxlf_2;
  wire        rxgearboxslip_out_2;

  wire        hi_ber_3;
  wire [5:0]  ber_cnt_3;
  wire [7:0]  errd_blks_3;


  wire        blk_lock_3;
  wire        linkstatus_3;
  wire        rx_fifo_spill_3;
  wire        rxlf_3;
  wire        rxgearboxslip_out_3;


  (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_0;
  (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_1;
  (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_2;
  (* syn_keep = "true"*) wire [7:0]  xgmii_rxc_lane_3;
  (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_0;
  (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_1;
  (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_2;
  (* syn_keep = "true"*) wire [63:0] xgmii_rxd_lane_3;

  (* syn_keep = "true"*) wire [4:0] mac_eop;
  (* syn_keep = "true"*) wire mac_sop;
  (* syn_keep = "true"*) wire mac_val;
  (* syn_keep = "true"*) wire [127:0] mac_data;
  (* syn_keep = "true"*) wire empty_fifo;
  (* syn_keep = "true"*) wire full_fifo;
  (* syn_keep = "true"*) wire fifo_almost_f;
  (* syn_keep = "true"*) wire fifo_almost_e;
  (* syn_keep = "true"*) wire  ren_coreif;
  (* syn_keep = "true"*) wire  almost_e_coreif;


  // }
  //BEGIN

  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //AUX STUFF ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  // Register for lane 0 old block
  always @ (posedge rx_clk161 or negedge async_reset_n) begin
    if (!async_reset_n) begin
      old_header_0 <= 2'b01;
      old_data_0   <= 64'h0;
    end
    else if (v3 & dscr_en_ipg) begin
      old_header_0 <= hh3[1:0];
      old_data_0   <= d3[63:0];
    end
  end
      // Start bit regs
    always @ (posedge clk_156 or negedge async_reset_n) begin
      if (!async_reset_n) begin
        start_out_0_rx_r <= 1'b0;
        start_out_1_rx_r <= 1'b0;
        start_out_2_rx_r <= 1'b0;
        start_out_3_rx_r <= 1'b0;
      end
      else begin
        start_out_0_rx_r <= start_out_0_rx;
        start_out_1_rx_r <= start_out_1_rx;
        start_out_2_rx_r <= start_out_2_rx;
        start_out_3_rx_r <= start_out_3_rx;
      end
    end

    assign linkstatus = linkstatus_0;

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //CORE INTERFACE///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////



(* dont_touch = "true" *) lane_reorder INST_lane_reorder
(
                        .clock (rx_clk161),
                        .reset (reset_rx_n),

                        .lane_0_data_in    (rx_data_in_0[63:0]),
                        .lane_0_header_in  (rx_header_in_0[1:0]),
                        .lane_0_valid_in   (rx_valid_in_0),

                        .lane_1_data_in    (rx_data_in_1[63:0]),
                        .lane_1_header_in  (rx_header_in_1[1:0]),
                        .lane_1_valid_in   (rx_valid_in_1),

                        .lane_2_data_in    (rx_data_in_2[63:0]),
                        .lane_2_header_in  (rx_header_in_2[1:0]),
                        .lane_2_valid_in   (rx_valid_in_2),

                        .lane_3_data_in    (rx_data_in_3[63:0]),
                        .lane_3_header_in  (rx_header_in_3[1:0]),
                        .lane_3_valid_in   (rx_valid_in_3),

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


///////////////////////////////////////////////////////////////////////////////////////////////////
//ALIGNMENT REMOVAL////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

alignment_removal INST_alignment_removal
(
                        .clk        (rx_clk161),
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

                        .rx_fill_pcs0       (fill_rx_pcs0),
                        .rx_fill_pcs1       (fill_rx_pcs1),
                        .rx_fill_pcs2       (fill_rx_pcs2),
                        .rx_fill_pcs3       (fill_rx_pcs3),

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

                        .dscr_0_out (),
                        .dscr_1_out (),
                        .dscr_2_out (),
                        .dscr_3_out (),

                        .ddscr_0_out (dscr_0_out_wire),
                        .ddscr_1_out (dscr_1_out_wire),
                        .ddscr_2_out (dscr_2_out_wire),
                        .ddscr_3_out (dscr_3_out_wire)

);

///////////////////////////////////////////////////////////////////////////////////////////////////
//PCS RX CORE /////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

rx_path_rx INST_0_rx_path(   // Input Ports
                        .clk156             (clk_156),
                        .rx_clk161         (rx_clk161),
                        .arstb              (reset_rx_n),
                        .rx_jtm_en          (rx_jtm_en),
                        .bypass_descram     (bypass_descram),
                        .bypass_66decoder   (bypass_66decoder),
                        .clear_errblk       (clear_errblk),
                        .clear_ber_cnt      (clear_ber_cnt),
                        .lpbk               (1'b1),
                        // New inputs.
                        .rx_header_valid_in (v0),
                        .rx_data_valid_in   (v0),
                        .rx_header_in       (hh0[1:0]),
                        .rx_data_in         (d0[63:0]),

                        .rx_old_header_in   (old_header_0),
                        .rx_old_data_in     (old_data_0),

                        .terminate_in       (terminate_in_0_rx),
                        .start_in           (start_in_0_rx),
                        .is_alig            (pcs_0_alignment),
                        .fifo_in            (dscr_0_out_wire),
                        .val_in             (dscr_en_ipg),

                        // Output Ports
                        .fill_out           (fill_rx_pcs0),
                        .xgmii_rxc          (xgmii_rxc_lane_0),
                        .xgmii_rxd          (xgmii_rxd_lane_0),
                        .jtest_errc_out     (jtest_errc_0[15:0]),
                        .ber_cnt            (ber_cnt_0[5:0]),
                        .hi_ber             (hi_ber_0),
                        .blk_lock           (blk_lock_0),
                        .linkstatus         (linkstatus_0),
                        .spill              (rx_fifo_spill_0),
                        .rxlf               (rxlf_0),
                        .errd_blks          (errd_blks_0),
                        .rxgearboxslip_out  (rxgearboxslip_out_0),
                        .terminate_out      (terminate_out_0_rx),
                        .start_out          (start_out_0_rx),
                        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),
                        .dscr_out           (pcs_0_dscr),
                        .start_fifo         (start_fifo)
                        );

rx_path_rx INST_1_rx_path(   // Input Ports
                        .clk156             (clk_156),
                        .rx_clk161         (rx_clk161),
                        .arstb              (reset_rx_n),
                        .rx_jtm_en          (rx_jtm_en),
                        .bypass_descram     (bypass_descram),
                        .bypass_66decoder   (bypass_66decoder),
                        .clear_errblk       (clear_errblk),
                        .clear_ber_cnt      (clear_ber_cnt),
                        .lpbk               (1'b1),
                        // New inputs.
                        .rx_header_valid_in (v1),
                        .rx_data_valid_in   (v1),
                        .rx_header_in       (hh1[1:0]),
                        .rx_data_in         (d1[63:0]),

                        .rx_old_header_in   (hh0[1:0]),
                        .rx_old_data_in     (d0[63:0]),

                        .terminate_in       (terminate_in_1_rx),
                        .start_in           (start_in_1_rx),
                        .is_alig            (pcs_1_alignment),
                        .fifo_in            (dscr_1_out_wire),
                        .val_in             (dscr_en_ipg),

                        // Output Ports
                        .fill_out           (fill_rx_pcs1),
                        .xgmii_rxc          (xgmii_rxc_lane_1),
                        .xgmii_rxd          (xgmii_rxd_lane_1),
                        .jtest_errc_out     (jtest_errc_1[15:0]),
                        .ber_cnt            (ber_cnt_1[5:0]),
                        .hi_ber             (hi_ber_1),
                        .blk_lock           (blk_lock_1),
                        .linkstatus         (linkstatus_1),
                        .spill              (rx_fifo_spill_1),
                        .rxlf               (rxlf_1),
                        .errd_blks          (errd_blks_1),
                        .rxgearboxslip_out  (rxgearboxslip_out_1),
                        .terminate_out      (terminate_out_1_rx),
                        .start_out          (start_out_1_rx),
                        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),
                        .dscr_out           (pcs_1_dscr),
                        .start_fifo         (start_fifo)
                        );

rx_path_rx INST_2_rx_path(   // Input Ports
                        .clk156             (clk_156),
                        .rx_clk161          (rx_clk161),
                        .arstb              (reset_rx_n),
                        .rx_jtm_en          (rx_jtm_en),
                        .bypass_descram     (bypass_descram),
                        .bypass_66decoder   (bypass_66decoder),
                        .clear_errblk       (clear_errblk),
                        .clear_ber_cnt      (clear_ber_cnt),
                        .lpbk               (1'b1),
                        // New inputs.
                        .rx_header_valid_in (v2),
                        .rx_data_valid_in   (v2),
                        .rx_header_in       (hh2[1:0]),
                        .rx_data_in         (d2[63:0]),

                        .rx_old_header_in   (hh1[1:0]),
                        .rx_old_data_in     (d1[63:0]),

                        .terminate_in       (terminate_in_2_rx),
                        .start_in           (start_in_2_rx),
                        .is_alig            (pcs_2_alignment),
                        .fifo_in            (dscr_2_out_wire),
                        .val_in             (dscr_en_ipg),

                        // Output Ports
                        .fill_out           (fill_rx_pcs2),
                        .xgmii_rxc          (xgmii_rxc_lane_2),
                        .xgmii_rxd          (xgmii_rxd_lane_2),
                        .jtest_errc_out     (jtest_errc_2[15:0]),
                        .ber_cnt            (ber_cnt_2[5:0]),
                        .hi_ber             (hi_ber_2),
                        .blk_lock           (blk_lock_2),
                        .linkstatus         (linkstatus_2),
                        .spill              (rx_fifo_spill_2),
                        .rxlf               (rxlf_2),
                        .errd_blks          (errd_blks_2),
                        .rxgearboxslip_out  (rxgearboxslip_out_2),
                        .terminate_out      (terminate_out_2_rx),
                        .start_out          (start_out_2_rx),
                        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),
                        .dscr_out           (pcs_2_dscr),
                        .start_fifo         (start_fifo)
                        );


rx_path_rx INST_3_rx_path(   // Input Ports
                        .clk156             (clk_156),
                        .rx_clk161         (rx_clk161),
                        .arstb              (reset_rx_n),
                        .rx_jtm_en          (rx_jtm_en),
                        .bypass_descram     (bypass_descram),
                        .bypass_66decoder   (bypass_66decoder),
                        .clear_errblk       (clear_errblk),
                        .clear_ber_cnt      (clear_ber_cnt),
                        .lpbk               (1'b1),
                        // New inputs.
                        .rx_header_valid_in (v3),
                        .rx_data_valid_in   (v3),
                        .rx_header_in       (hh3[1:0]),
                        .rx_data_in         (d3[63:0]),

                        .rx_old_header_in   (hh2[1:0]),
                        .rx_old_data_in     (d2[63:0]),

                        .terminate_in       (terminate_in_3_rx),
                        .start_in           (start_in_3_rx),
                        .jtest_errc_out     (jtest_errc_3[15:0]),
                        .is_alig            (pcs_3_alignment),
                        .fifo_in            (dscr_3_out_wire),
                        .val_in             (dscr_en_ipg),

                        // Output Ports
                        .fill_out           (fill_rx_pcs3),
                        .xgmii_rxc          (xgmii_rxc_lane_3),
                        .xgmii_rxd          (xgmii_rxd_lane_3),
                        .ber_cnt            (ber_cnt_3[5:0]),
                        .hi_ber             (hi_ber_3),
                        .blk_lock           (blk_lock_3),
                        .linkstatus         (linkstatus_3),
                        .spill              (rx_fifo_spill_3),
                        .rxlf               (rxlf_3),
                        .errd_blks          (errd_blks_3),
                        .rxgearboxslip_out  (rxgearboxslip_out_3),
                        .terminate_out      (terminate_out_3_rx),
                        .start_out          (start_out_3_rx),
                        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),
                        .dscr_out           (pcs_3_dscr),
                        .start_fifo         (start_fifo)
                        );

///////////////////////////////////////////////////////////////////////////////////////////////////
//CORE INTERFACE///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

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

 ///////////////////////////////////////////////////////////////////////////////////////////////////
 //CRC /////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////


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
                         .app_data (pkt_rx_data),
                         .app_sop  (pkt_rx_sop),
                         .app_val  (pkt_rx_val),
                         .app_eop  (pkt_rx_eop),
                         .crc_ok   (crc_ok)
                       );
endmodule
