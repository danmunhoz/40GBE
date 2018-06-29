//------ Xilinx, Communications Technology Division  --------------
//
// Information is Copyright Xilinx, Inc.
//
// FileName: opt_fifo.v
//
//
// Begin Date: Tue May  4 09:56:33 2004
//
// Description: Fifo block for optimized PCS architecture
//
//
//                       Revision History
//-----------------------------------------------------------------
// Date Modified             User Name            Full Name
//        Descrition of Changes
//-----------------------------------------------------------------
// Mon Jun 14 10:19:32 2004
//        Reduced FIFO size to 70bits wide.  Changed so only
//        consecutive Seq ordered sets are removed.
// Tue Jun 29 13:53:09 2004
//        changed so idle after term is written into fifo
//
//-----------------------------------------------------------------
// NOTES:
//-----------------------------------------------------------------
//
//
//-----------------------------------------------------------------

module opt_fifo_new_tx (   /*AUTOARG*/
                        // Outputs
                        readdata, spill,
                        // Inputs
                        rclk, readen, wclk, writen, writedata, rst
                        );

    input         rclk;
    input         wclk;
    input         rst;
    input         readen;
    input         writen;
    input [65:0]  writedata;

    output        spill;
    output [65:0] readdata;

    wire          wr_ctrl;
    wire          wr_seq;
    wire          wr_start;
    wire          spill;
    wire          seq_repeat;
    wire          read_term,read_idle;
    wire          control_block;
    wire          almostempty;
    wire          almostfull;
    wire [8:0]    wr_count,rd_count;
    wire [23:0]   seq_data;
    wire [69:0]   rfifo_data;

//   reg            seq_repeat;
    reg           wr_ctrl_idle;
    reg           wr_idle_seq;
    reg           wr_seq_idle;
    reg           wr_seq1;
    reg           wr_seq2;
    reg           wr_data;
    reg           wr_idle_start;
    reg           wr_seq_start;
    reg           wr_term;
    reg           wr_term_d;
    reg           wr_term_dd;
    reg           wfifo_en;
    reg           rd_en;
    reg           write_enable;
    reg           seq1, seq2;
    reg           registered_write_enable;
    reg           registered_read_enable;
    reg [1:0]     spill_rr;
    reg [1:0]     spill_ww;
    reg [23:0]    seq_data_r;
    reg [65:0]    writedata_d;
    reg [65:0]    readdata;
    reg [69:0]    wfifo_data;
    reg [69:0]    registered_write_data;


    reg           almostempty_ff1;
    reg           almostempty_ff2;
    reg [1:0]     rst_ext;

    reg           readen_d;
    reg           registered_write_enable_d;


parameter FIFO_FULL         = 0; // setting this to 1 results in FIFO staying mostly full otherwise it is mostly empty.

assign   control_block  = (writedata[1:0] == 2'b01);
assign   wr_ctrl        = (control_block & (writedata[9:2] == 8'h1e));
assign   wr_seq         = wr_seq1 & wr_seq2;
assign   seq_data       = (seq2) ? writedata_d[65:42] : (seq1) ? writedata_d[33:10] : 24'h000000;
assign   wr_start       = (wr_idle_start | (writedata_d[9:0] == 10'h1e1) | wr_seq_start);


// register sequence data check for repeats
always@(posedge wclk) begin
    writedata_d   <= writedata;
    seq2          <= control_block & !(|writedata[41:38]) & (((writedata[9:2] == 8'h2d) & !(|writedata[37:10])) | (writedata[9:2] == 8'h55));
    seq1          <= control_block & (((writedata[9:2] == 8'h4b) & !(|writedata[65:38]) & !(|writedata[37:34])) | ((writedata[9:2] == 8'h55) & !(|writedata[41:38])));

    wr_ctrl_idle  <= (wr_ctrl) & !(|writedata[65:10]);
    wr_idle_seq   <= control_block & (writedata[9:2] == 8'h2d) & !(|writedata[37:10]) & !(|writedata[41:38]);
    wr_seq_idle   <= control_block & (writedata[9:2] == 8'h4b) & !(|writedata[65:38]) & !(|writedata[37:34]);
    wr_seq1       <= control_block & (writedata[9:2] == 8'h55) & !(|writedata[37:34]);
    wr_seq2       <= control_block & (writedata[9:2] == 8'h55) & !(|writedata[41:38]);

    wr_idle_start <= control_block & (writedata[9:2] == 8'h33) & !(|writedata[37:10]);
    wr_seq_start  <= control_block & (writedata[9:2] == 8'h66) & !(|writedata[37:34]);

    wr_term       <= control_block & (writedata[9] == 1'b1);
    wr_term_dd    <= control_block & (writedata[9:8] == 2'b11);


    // We are only allowed to remove consecutive ordered sets.
    if (wr_idle_seq | wr_seq | wr_seq_idle)
        seq_data_r <=  seq_data;
    else
        seq_data_r <=  24'hFFFFFF;

    //    seq_repeat <= (seq_data == seq_data_r);
    write_enable <= writen;
end

assign seq_repeat = (seq_data == seq_data_r);

// write all data except idles, and/or repeated seq ordered sets
always@(posedge wclk or posedge rst)
    if(rst) begin
        wfifo_en    <=  1'b1;
        wfifo_data  <=  70'h0;
        wr_term_d   <=  1'b0;
    end
    else if (write_enable) begin
        wr_term_d <=  wr_term_dd;
        // need to make sure idle following terminate is written into fifo
        // if (((wr_ctrl_idle & !wr_term_d) | seq_repeat) & (!almostempty_ff2)) begin
        if (((!wr_term_d) | seq_repeat) & (!almostempty_ff2)) begin
        // Não otimizar a escrita de idle na fifo para não dessincronizar as FIFOs.
            // dont write idles unless FIFO is almost empty
            wfifo_en    <=  1'b0;
            // wfifo_data  <=  70'h0;
            wfifo_data  <=  {(wr_seq_start | wr_idle_start | wr_ctrl_idle),wr_start,wr_term,(wr_ctrl_idle | wr_idle_seq | wr_seq_idle | wr_seq),writedata_d};
        end
        else begin
            wfifo_en    <=  1'b1;
            wfifo_data  <=  {(wr_seq_start | wr_idle_start | wr_ctrl_idle),wr_start,wr_term,(wr_ctrl_idle | wr_idle_seq | wr_seq_idle | wr_seq),writedata_d};
        end
        wfifo_data  <=  {(wr_seq_start | wr_idle_start | wr_ctrl_idle),wr_start,wr_term,(wr_ctrl_idle | wr_idle_seq | wr_seq_idle | wr_seq),writedata_d};
    end

always@(posedge wclk)
begin
    if (rst) begin
        almostempty_ff1 <= 1'b0;
        almostempty_ff2 <= 1'b0;
    end else begin
        almostempty_ff1 <= almostempty;
        almostempty_ff2 <= almostempty_ff1;
    end
end

   // End of FIFO_DUALCLOCK_MACRO_inst instantiation
FIFO_DUALCLOCK_MACRO # (
                        //.SIM_MODE                   ("SAFE"), // Simulation: "SAFE" vs. "FAST", see "Synthesis and Simulation Design Guide" for details
                        .ALMOST_FULL_OFFSET         (9'h00A), // Sets almost full threshold
                        .ALMOST_EMPTY_OFFSET        (9'h00A), // Sets the almost empty threshold
                        .DATA_WIDTH                 (70), // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
                        .DEVICE                     ("7SERIES"), // Target device: "VIRTEX5", "VIRTEX6"
                        .FIFO_SIZE                  ("36Kb"), // Target BRAM: "18Kb" or "36Kb"
                        .FIRST_WORD_FALL_THROUGH    ("TRUE") // Sets the FIFO FWFT to "TRUE" or "FALSE"
                        ) FIFO_DUALCLOCK_MACRO_inst
                        (
                        .RDERR          (), // 1-bit read error output
                        .WRERR          (), // 1-bit write error

                        .ALMOSTEMPTY    (almostempty), // 1-bit almost empty output flag
                        .ALMOSTFULL     (almostfull), // 1-bit almost full output flag
                        .DO             (rfifo_data), // 70-bit data output
                        .EMPTY          (empty), // 1-bit empty output flag
                        .FULL           (full), // 1-bit full output flag
                        .RDCOUNT        (rd_count), // 9-bit read count output
                        .WRCOUNT        (wr_count), // 9-bit write count output

                        .DI             (registered_write_data), // 70-bit data input
                        .RDCLK          (rclk), // 1-bit read clock input
                        .RDEN           (readen), // 1-bit read enable input
                        .RST            (rst), // 1-bit reset input
                        .WRCLK          (wclk), // 1-bit write clock input
                        .WREN           (registered_write_enable_d) // 1-bit write enable input
                        );

assign read_term = rfifo_data[67];
assign read_idle = rfifo_data[66]; // can insert idle after

always @(posedge wclk or posedge rst)
begin
    if (rst) begin
        registered_write_enable = 1'b0;
        registered_write_data   = 70'h0;
    end
    else begin
        // registered_write_enable <= wfifo_en & write_enable;
        registered_write_enable <= write_enable;
        registered_write_data   <= wfifo_data;
    end
end

// read FIFO and insert idles
// We are only allowed to insert idles.

always@(posedge rclk or posedge rst)
    if (rst) begin
        rd_en       <=  1'b0;
        readdata    <=  {64'h000000000000001e,2'b01};
    end
    else if (readen) begin
        rd_en       <=  1'b1;
        readdata    <=  rfifo_data[65:0];
    end

always@(posedge rclk or posedge rst)
    if (rst) begin
        readen_d  <=  1'b0;
    end
    else begin
      readen_d <= readen;
    end

always@(posedge wclk or posedge rst)
    if (rst) begin
        registered_write_enable_d  <=  1'b0;
    end
    else begin
      registered_write_enable_d <= registered_write_enable;
    end

// stretch spills so that they are properly detected across boundaries
always@(posedge wclk or posedge full)
    if (full)
        spill_ww <=  2'b11;
    else
        spill_ww <=  {spill_ww[0],1'b0};

always@(posedge rclk or posedge empty)
    if (empty)
        spill_rr <=  2'b11;
    else
        spill_rr <=  {spill_rr[0],1'b0};
assign spill = spill_ww[1] | spill_rr[1];

endmodule // opt_fifo
