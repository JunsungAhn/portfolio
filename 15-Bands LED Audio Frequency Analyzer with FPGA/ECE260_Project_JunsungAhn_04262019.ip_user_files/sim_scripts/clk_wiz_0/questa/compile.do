vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xilinx_vip -64 -sv -L xil_defaultlib "+incdir+../../../ipstatic" "+incdir+C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/include" "+incdir+C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/include" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib -64 -sv -L xil_defaultlib "+incdir+../../../ipstatic" "+incdir+C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/include" \
"C:/xilinx/Vivado/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/xilinx/Vivado/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" "+incdir+C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+C:/xilinx/Vivado/Vivado/2018.1/data/xilinx_vip/include" \
"../../../../Frq_Analyzer.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
"../../../../Frq_Analyzer.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

