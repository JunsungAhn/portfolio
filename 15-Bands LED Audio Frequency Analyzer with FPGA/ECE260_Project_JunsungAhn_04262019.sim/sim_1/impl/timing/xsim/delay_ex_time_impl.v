// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Mon Jan 28 12:48:38 2019
// Host        : dit2500us running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/junsung.ahn/Desktop/junsung.ahn/2019/Spring/ECE260/Exercise/Week04/Week04.sim/sim_1/impl/timing/xsim/delay_ex_time_impl.v
// Design      : delay_ex
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "4f282010" *) 
(* NotValidForBitStream *)
module delay_ex
   (SW0,
    SW1,
    SW2,
    LED0);
  input SW0;
  input SW1;
  input SW2;
  output LED0;

  wire LED0;
  wire LED0_OBUF;
  wire SW0;
  wire SW0_IBUF;
  wire SW1;
  wire SW1_IBUF;
  wire SW2;
  wire SW2_IBUF;

initial begin
 $sdf_annotate("delay_ex_time_impl.sdf",,,,"tool_control");
end
  OBUF LED0_OBUF_inst
       (.I(LED0_OBUF),
        .O(LED0));
  LUT3 #(
    .INIT(8'h45)) 
    LED0_OBUF_inst_i_1
       (.I0(SW1_IBUF),
        .I1(SW0_IBUF),
        .I2(SW2_IBUF),
        .O(LED0_OBUF));
  IBUF SW0_IBUF_inst
       (.I(SW0),
        .O(SW0_IBUF));
  IBUF SW1_IBUF_inst
       (.I(SW1),
        .O(SW1_IBUF));
  IBUF SW2_IBUF_inst
       (.I(SW2),
        .O(SW2_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
