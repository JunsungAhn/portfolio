# File saved with Nlview 6.8.11  2018-08-07 bk=1.4403 VDI=40 GEI=35 GUI=JA:9.0 non-TLS-threadsafe
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #ff6666
property objecthighlight4 #0000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new Frq_Analyzer work:Frq_Analyzer:NOFILE -nosplit
load symbol OBUFT hdi_primitives BOX pin O output.right pin I input.left pin T input.left fillcolor 1
load symbol OBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol IBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol BUFG hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol FDRE hdi_primitives GEN pin Q output.right pin C input.clk.left pin CE input.left pin D input.left pin R input.left fillcolor 1
load symbol LUT1 hdi_primitives BOX pin O output.right pin I0 input.left fillcolor 1
load symbol LUT2 hdi_primitives BOX pin O output.right pin I0 input.left pin I1 input.left fillcolor 1
load symbol CLK_Generator work:CLK_Generator:NOFILE HIERBOX pin CLK100MHZ_IBUF_BUFG input.left pin SinWaveCLK output.right pinBus Q output.right [0:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Microphone work:Microphone:NOFILE HIERBOX pin FSM_sequential_FSMState_reg[1]_rep input.left pin FSM_sequential_FSMState_reg[1]_rep__1 input.left pin M_CLK_OBUF_BUFG input.left pin M_DATA_IBUF input.left pin RECORD_DONE output.right pin RecordTimeCounter_reg[0]_0 input.left pin _MicDataSampled output.right pin _MicDataSampled_reg[0]_rep_0 output.right pin _MicDataSampled_reg[0]_rep__0_0 output.right pin _MicDataSampled_reg[0]_rep__1_1 input.left pin _RECORD_DONE_reg_0 output.right pin _RECORD_DONE_reg_1 output.right pin _RECORD_DONE_reg_2 output.right pin _RECORD_DONE_reg_3 output.right pinBus FSMState input.left [1:0] pinBus _MicDataSampled_reg[0]_rep__1_0 output.right [0:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RAM work:RAM:NOFILE HIERBOX pin BTNC_IBUF input.left pin EvenSampleAnalogVoltage_reg[0]_0 output.right pin EvenSampleAnalogVoltage_reg[0]_1 output.right pin EvenSampleAnalogVoltage_reg[1]_0 output.right pin EvenSampleAnalogVoltage_reg[1]_1 input.left pin EvenSampleAnalogVoltage_reg[2]_0 output.right pin EvenSampleAnalogVoltage_reg[2]_1 output.right pin EvenSampleAnalogVoltage_reg[2]_2 output.right pin EvenSampleAnalogVoltage_reg[2]_3 output.right pin EvenSampleAnalogVoltage_reg[3]_0 output.right pin EvenSampleAnalogVoltage_reg[3]_1 output.right pin EvenSampleAnalogVoltage_reg[4]_0 output.right pin EvenSampleAnalogVoltage_reg[4]_1 output.right pin EvenSampleAnalogVoltage_reg[5]_0 output.right pin EvenSampleAnalogVoltage_reg[5]_1 output.right pin FSM_sequential_FSMState_reg[1]_rep__1 output.right pin M_CLK_OBUF_BUFG input.left pin OddSampleAnalogVoltage[4]_i_275_0 input.left pin OddSampleAnalogVoltage[7]_i_457_0 input.left pin OddSampleAnalogVoltage_reg[0]_0 output.right pin OddSampleAnalogVoltage_reg[0]_1 output.right pin OddSampleAnalogVoltage_reg[1]_0 output.right pin OddSampleAnalogVoltage_reg[2]_0 output.right pin OddSampleAnalogVoltage_reg[2]_1 output.right pin OddSampleAnalogVoltage_reg[2]_2 output.right pin OddSampleAnalogVoltage_reg[2]_3 output.right pin OddSampleAnalogVoltage_reg[3]_0 output.right pin OddSampleAnalogVoltage_reg[3]_1 output.right pin OddSampleAnalogVoltage_reg[4]_0 output.right pin OddSampleAnalogVoltage_reg[4]_1 output.right pin OddSampleAnalogVoltage_reg[5]_0 output.right pin OddSampleAnalogVoltage_reg[5]_1 output.right pin RECORD_DONE input.left pin ReadAddress_reg_rep[7]_rep__9_0 input.left pin ReadAddress_reg_rep[7]_rep__9_1 input.left pin SinWaveCLK_BUFG input.left pin Sum2_inferred__1/i___15_carry_0 input.left pin Sum2_inferred__2/i___15_carry_0 input.left pin WriteAddress_reg[18]_0 input.left pin _MicDataSampled input.left pin _PROCESS_DONE_reg_0 output.right pin _PROCESS_DONE_reg_1 output.right pin _PROCESS_DONE_reg_2 output.right pin _Phase_reg[4]_0 input.left pin _SineWaveSampleData_reg[7] output.right pin _SineWaveSampleData_reg[7]_0 output.right pinBus CO output.right [0:0] pinBus DI input.left [1:0] pinBus EvenSampleAnalogVoltage_reg[7]_0 output.right [4:0] pinBus FSMState input.left [1:0] pinBus O output.right [0:0] pinBus OddSampleAnalogVoltage[7]_i_201_0 input.left [0:0] pinBus Q output.right [4:0] pinBus S input.left [0:0] pinBus Sum2__55_carry_0 input.left [3:0] pinBus Sum2__55_carry_1 input.left [3:0] pinBus Sum2__55_carry__0_i_11_0 input.left [1:0] pinBus Sum2__55_carry__0_i_11_1 input.left [0:0] pinBus Sum2__55_carry__0_i_8_0 input.left [3:0] pinBus Sum2__55_carry__0_i_8_1 input.left [3:0] pinBus Sum2__55_carry__1_i_7_0 input.left [1:0] pinBus Sum2__55_carry__1_i_7_1 input.left [0:0] pinBus Sum2__55_carry_i_5_0 input.left [1:0] pinBus Sum2__55_carry_i_5_1 input.left [1:0] pinBus Sum2_inferred__0/i___55_carry_0 input.left [1:0] pinBus Sum2_inferred__0/i___55_carry_1 input.left [0:0] pinBus Sum2_inferred__0/i___55_carry_2 input.left [3:0] pinBus Sum2_inferred__0/i___55_carry_3 input.left [3:0] pinBus Sum2_inferred__0/i___55_carry__2_0 input.left [7:0] pinBus Sum[0]_i_12_0 input.left [0:0] pinBus Sum[0]_i_12_1 input.left [0:0] pinBus Sum[0]_i_12_2 input.left [0:0] pinBus Sum[0]_i_12_3 input.left [0:0] pinBus Sum[0]_i_15_0 input.left [1:0] pinBus Sum[0]_i_15_1 input.left [2:0] pinBus Sum[0]_i_15_2 input.left [1:0] pinBus Sum[0]_i_15_3 input.left [2:0] pinBus _FourierResult_reg[7]_0 output.right [7:0] pinBus _SineWaveSampleData_reg[2] output.right [0:0] pinBus _SineWaveSampleData_reg[2]_0 output.right [0:0] pinBus _SineWaveSampleData_reg[3] output.right [0:0] pinBus _SineWaveSampleData_reg[3]_0 output.right [0:0] pinBus _SineWaveSampleData_reg[5] output.right [0:0] pinBus _SineWaveSampleData_reg[5]_0 output.right [1:0] pinBus _SineWaveSampleData_reg[5]_1 output.right [0:0] pinBus _SineWaveSampleData_reg[5]_2 output.right [1:0] pinBus i___15_carry_i_4_0 input.left [1:0] pinBus i___15_carry_i_4_1 input.left [1:0] pinBus i___15_carry_i_4__0_0 input.left [1:0] pinBus i___15_carry_i_4__0_1 input.left [1:0] pinBus i___15_carry_i_7 input.left [2:0] pinBus i___15_carry_i_7_0 input.left [1:0] pinBus i___15_carry_i_7__0 input.left [2:0] pinBus i___15_carry_i_7__0_0 input.left [1:0] pinBus i___55_carry__0_i_11_0 input.left [1:0] pinBus i___55_carry__0_i_11_1 input.left [0:0] pinBus i___55_carry__0_i_8_0 input.left [3:0] pinBus i___55_carry__0_i_8_1 input.left [3:0] pinBus i___55_carry__1_i_7_0 input.left [1:0] pinBus i___55_carry__1_i_7_1 input.left [0:0] pinBus i___55_carry_i_5_0 input.left [1:0] pinBus i___55_carry_i_5_1 input.left [1:0] pinBus out output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol SampleSineWave work:SampleSineWave:NOFILE HIERBOX pin CLK100MHZ_IBUF_BUFG input.left pin Sum2__25_carry__0 input.left pin Sum2__25_carry__0_0 input.left pin Sum2__25_carry__0_1 input.left pin Sum2__25_carry__0_2 input.left pin Sum2_carry__0 input.left pin Sum2_carry__0_0 input.left pin Sum2_carry__0_1 input.left pin Sum2_carry__0_2 input.left pin Sum2_inferred__0/i___25_carry__0 input.left pin Sum2_inferred__0/i___25_carry__0_0 input.left pin Sum2_inferred__0/i___25_carry__0_1 input.left pin Sum2_inferred__0/i___25_carry__0_2 input.left pin Sum2_inferred__0/i__carry__0 input.left pin Sum2_inferred__0/i__carry__0_0 input.left pin Sum2_inferred__0/i__carry__0_1 input.left pin Sum2_inferred__0/i__carry__0_2 input.left pin Sum2_inferred__1/i___15_carry input.left pin Sum2_inferred__1/i___15_carry__0_0 input.left pin Sum2_inferred__1/i___15_carry__0_1 input.left pin Sum2_inferred__1/i___7_carry input.left pin Sum2_inferred__1/i___7_carry_0 input.left pin Sum2_inferred__1/i___7_carry_1 input.left pin Sum2_inferred__2/i___15_carry_1 input.left pin Sum2_inferred__2/i___15_carry__0_0 input.left pin Sum2_inferred__2/i___15_carry__0_1 input.left pin Sum2_inferred__2/i___7_carry input.left pin Sum2_inferred__2/i___7_carry_0 input.left pin Sum2_inferred__2/i___7_carry_1 input.left pin _SineWaveSampleData_reg[7]_1 output.right pin _SineWaveSampleData_reg[7]_3 output.right pinBus CO input.left [0:0] pinBus D input.left [7:0] pinBus DI output.right [1:0] pinBus EvenSampleAnalogVoltage_reg[1] output.right [2:0] pinBus O input.left [0:0] pinBus OddSampleAnalogVoltage_reg[1] output.right [2:0] pinBus Q output.right [7:0] pinBus S output.right [0:0] pinBus Sum2__25_carry__1 input.left [4:0] pinBus Sum2_inferred__0/i___25_carry__1 input.left [4:0] pinBus Sum2_inferred__1/i___15_carry_0 input.left [0:0] pinBus Sum2_inferred__1/i___15_carry__0 input.left [1:0] pinBus Sum2_inferred__2/i___15_carry input.left [0:0] pinBus Sum2_inferred__2/i___15_carry_0 input.left [0:0] pinBus Sum2_inferred__2/i___15_carry_2 input.left [0:0] pinBus Sum2_inferred__2/i___15_carry__0 input.left [1:0] pinBus _SineWaveSampleData_reg[0]_0 output.right [3:0] pinBus _SineWaveSampleData_reg[0]_1 output.right [3:0] pinBus _SineWaveSampleData_reg[0]_2 output.right [1:0] pinBus _SineWaveSampleData_reg[0]_3 output.right [0:0] pinBus _SineWaveSampleData_reg[1]_0 output.right [3:0] pinBus _SineWaveSampleData_reg[1]_1 output.right [0:0] pinBus _SineWaveSampleData_reg[1]_2 output.right [3:0] pinBus _SineWaveSampleData_reg[1]_3 output.right [0:0] pinBus _SineWaveSampleData_reg[1]_4 output.right [1:0] pinBus _SineWaveSampleData_reg[1]_5 output.right [1:0] pinBus _SineWaveSampleData_reg[2]_0 output.right [1:0] pinBus _SineWaveSampleData_reg[2]_1 output.right [1:0] pinBus _SineWaveSampleData_reg[2]_2 output.right [1:0] pinBus _SineWaveSampleData_reg[2]_3 output.right [1:0] pinBus _SineWaveSampleData_reg[3]_0 output.right [3:0] pinBus _SineWaveSampleData_reg[3]_1 output.right [3:0] pinBus _SineWaveSampleData_reg[3]_2 output.right [1:0] pinBus _SineWaveSampleData_reg[3]_3 output.right [1:0] pinBus _SineWaveSampleData_reg[3]_4 output.right [1:0] pinBus _SineWaveSampleData_reg[3]_5 output.right [1:0] pinBus _SineWaveSampleData_reg[4]_0 output.right [3:0] pinBus _SineWaveSampleData_reg[4]_1 output.right [0:0] pinBus _SineWaveSampleData_reg[4]_2 output.right [3:0] pinBus _SineWaveSampleData_reg[4]_3 output.right [0:0] pinBus _SineWaveSampleData_reg[4]_4 output.right [1:0] pinBus _SineWaveSampleData_reg[4]_5 output.right [1:0] pinBus _SineWaveSampleData_reg[5]_0 output.right [2:0] pinBus _SineWaveSampleData_reg[5]_1 output.right [1:0] pinBus _SineWaveSampleData_reg[5]_2 output.right [2:0] pinBus _SineWaveSampleData_reg[5]_3 output.right [1:0] pinBus _SineWaveSampleData_reg[6]_0 output.right [1:0] pinBus _SineWaveSampleData_reg[6]_1 output.right [1:0] pinBus _SineWaveSampleData_reg[6]_2 output.right [0:0] pinBus _SineWaveSampleData_reg[6]_3 output.right [0:0] pinBus _SineWaveSampleData_reg[7]_0 output.right [0:0] pinBus _SineWaveSampleData_reg[7]_2 output.right [0:0] pinBus i___15_carry_i_5 input.left [0:0] pinBus i___15_carry_i_5__0 input.left [0:0] boxcolor 1 fillcolor 2 minwidth 13%
load port AUD_PWM output -pg 1 -y 2760
load port M_CLK output -pg 1 -y 2610
load port M_DATA input -pg 1 -y 2090
load port M_LRSEL output -pg 1 -y 3480
load port CLK100MHZ input -pg 1 -y 2820
load port AUD_SD output -pg 1 -y 2690
load port BTNC input -pg 1 -y 350
load portBus LED output [15:0] -attr @name LED[15:0] -pg 1 -y 1070
load portBus SW input [3:0] -attr @name SW[3:0] -pg 1 -y 20
load inst FSM_sequential_FSMState_reg[1] FDRE hdi_primitives -attr @cell(#000000) FDRE -pg 1 -lvl 4 -y 2650
load inst LED_OBUF[13]_inst OBUFT hdi_primitives -attr @cell(#000000) OBUFT -pg 1 -lvl 8 -y 3290
load inst AUD_PWM_OBUF_inst OBUFT hdi_primitives -attr @cell(#000000) OBUFT -pg 1 -lvl 8 -y 2750
load inst AUD_SD_OBUF_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 2690
load inst LED_OBUF[10]_inst OBUFT hdi_primitives -attr @cell(#000000) OBUFT -pg 1 -lvl 8 -y 3020
load inst LED_OBUF[11]_inst OBUFT hdi_primitives -attr @cell(#000000) OBUFT -pg 1 -lvl 8 -y 3110
load inst FSM_sequential_FSMState_reg[0] FDRE hdi_primitives -attr @cell(#000000) FDRE -pg 1 -lvl 4 -y 2850
load inst M_CLK_OBUF_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 2610
load inst M_LRSEL_OBUF_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 3480
load inst LED_OBUF[6]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1490
load inst M_DATA_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 4 -y 2090
load inst FSM_sequential_FSMState_reg[1]_rep__0 FDRE hdi_primitives -attr @cell(#000000) FDRE -pg 1 -lvl 6 -y 2310
load inst LED_OBUF[7]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1560
load inst FSM_sequential_FSMState_reg[1]_rep__1 FDRE hdi_primitives -attr @cell(#000000) FDRE -pg 1 -lvl 4 -y 2430
load inst LED_OBUF[14]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 3410
load inst nolabel_line568 Microphone work:Microphone:NOFILE -autohide -attr @cell(#000000) Microphone -pinBusAttr FSMState @name FSMState[1:0] -pinBusAttr _MicDataSampled_reg[0]_rep__1_0 @name _MicDataSampled_reg[0]_rep__1_0 -pg 1 -lvl 5 -y 2080
load inst nolabel_line578 RAM work:RAM:NOFILE -autohide -attr @cell(#000000) RAM -pinBusAttr CO @name CO -pinBusAttr DI @name DI[1:0] -pinBusAttr EvenSampleAnalogVoltage_reg[7]_0 @name EvenSampleAnalogVoltage_reg[7]_0[4:0] -pinBusAttr FSMState @name FSMState[1:0] -pinBusAttr O @name O -pinBusAttr OddSampleAnalogVoltage[7]_i_201_0 @name OddSampleAnalogVoltage[7]_i_201_0 -pinBusAttr Q @name Q[4:0] -pinBusAttr S @name S -pinBusAttr Sum2__55_carry_0 @name Sum2__55_carry_0[3:0] -pinBusAttr Sum2__55_carry_1 @name Sum2__55_carry_1[3:0] -pinBusAttr Sum2__55_carry__0_i_11_0 @name Sum2__55_carry__0_i_11_0[1:0] -pinBusAttr Sum2__55_carry__0_i_11_1 @name Sum2__55_carry__0_i_11_1 -pinBusAttr Sum2__55_carry__0_i_8_0 @name Sum2__55_carry__0_i_8_0[3:0] -pinBusAttr Sum2__55_carry__0_i_8_1 @name Sum2__55_carry__0_i_8_1[3:0] -pinBusAttr Sum2__55_carry__1_i_7_0 @name Sum2__55_carry__1_i_7_0[1:0] -pinBusAttr Sum2__55_carry__1_i_7_1 @name Sum2__55_carry__1_i_7_1 -pinBusAttr Sum2__55_carry_i_5_0 @name Sum2__55_carry_i_5_0[1:0] -pinBusAttr Sum2__55_carry_i_5_1 @name Sum2__55_carry_i_5_1[1:0] -pinBusAttr Sum2_inferred__0/i___55_carry_0 @name Sum2_inferred__0/i___55_carry_0[1:0] -pinBusAttr Sum2_inferred__0/i___55_carry_1 @name Sum2_inferred__0/i___55_carry_1 -pinBusAttr Sum2_inferred__0/i___55_carry_2 @name Sum2_inferred__0/i___55_carry_2[3:0] -pinBusAttr Sum2_inferred__0/i___55_carry_3 @name Sum2_inferred__0/i___55_carry_3[3:0] -pinBusAttr Sum2_inferred__0/i___55_carry__2_0 @name Sum2_inferred__0/i___55_carry__2_0[7:0] -pinBusAttr Sum[0]_i_12_0 @name Sum[0]_i_12_0 -pinBusAttr Sum[0]_i_12_1 @name Sum[0]_i_12_1 -pinBusAttr Sum[0]_i_12_2 @name Sum[0]_i_12_2 -pinBusAttr Sum[0]_i_12_3 @name Sum[0]_i_12_3 -pinBusAttr Sum[0]_i_15_0 @name Sum[0]_i_15_0[1:0] -pinBusAttr Sum[0]_i_15_1 @name Sum[0]_i_15_1[2:0] -pinBusAttr Sum[0]_i_15_2 @name Sum[0]_i_15_2[1:0] -pinBusAttr Sum[0]_i_15_3 @name Sum[0]_i_15_3[2:0] -pinBusAttr _FourierResult_reg[7]_0 @name _FourierResult_reg[7]_0[7:0] -pinBusAttr _SineWaveSampleData_reg[2] @name _SineWaveSampleData_reg[2] -pinBusAttr _SineWaveSampleData_reg[2]_0 @name _SineWaveSampleData_reg[2]_0 -pinBusAttr _SineWaveSampleData_reg[3] @name _SineWaveSampleData_reg[3] -pinBusAttr _SineWaveSampleData_reg[3]_0 @name _SineWaveSampleData_reg[3]_0 -pinBusAttr _SineWaveSampleData_reg[5] @name _SineWaveSampleData_reg[5] -pinBusAttr _SineWaveSampleData_reg[5]_0 @name _SineWaveSampleData_reg[5]_0[1:0] -pinBusAttr _SineWaveSampleData_reg[5]_1 @name _SineWaveSampleData_reg[5]_1 -pinBusAttr _SineWaveSampleData_reg[5]_2 @name _SineWaveSampleData_reg[5]_2[1:0] -pinBusAttr i___15_carry_i_4_0 @name i___15_carry_i_4_0[1:0] -pinBusAttr i___15_carry_i_4_1 @name i___15_carry_i_4_1[1:0] -pinBusAttr i___15_carry_i_4__0_0 @name i___15_carry_i_4__0_0[1:0] -pinBusAttr i___15_carry_i_4__0_1 @name i___15_carry_i_4__0_1[1:0] -pinBusAttr i___15_carry_i_7 @name i___15_carry_i_7[2:0] -pinBusAttr i___15_carry_i_7_0 @name i___15_carry_i_7_0[1:0] -pinBusAttr i___15_carry_i_7__0 @name i___15_carry_i_7__0[2:0] -pinBusAttr i___15_carry_i_7__0_0 @name i___15_carry_i_7__0_0[1:0] -pinBusAttr i___55_carry__0_i_11_0 @name i___55_carry__0_i_11_0[1:0] -pinBusAttr i___55_carry__0_i_11_1 @name i___55_carry__0_i_11_1 -pinBusAttr i___55_carry__0_i_8_0 @name i___55_carry__0_i_8_0[3:0] -pinBusAttr i___55_carry__0_i_8_1 @name i___55_carry__0_i_8_1[3:0] -pinBusAttr i___55_carry__1_i_7_0 @name i___55_carry__1_i_7_0[1:0] -pinBusAttr i___55_carry__1_i_7_1 @name i___55_carry__1_i_7_1 -pinBusAttr i___55_carry_i_5_0 @name i___55_carry_i_5_0[1:0] -pinBusAttr i___55_carry_i_5_1 @name i___55_carry_i_5_1[1:0] -pinBusAttr out @name out[7:0] -pg 1 -lvl 7 -y 340
load inst CLK100MHZ_IBUF_BUFG_inst BUFG hdi_primitives -attr @cell(#000000) BUFG -pg 1 -lvl 2 -y 2820
load inst CLK100MHZ_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 1 -y 2820
load inst FSM_sequential_FSMState_reg[0]_rep__0 FDRE hdi_primitives -attr @cell(#000000) FDRE -pg 1 -lvl 4 -y 2210
load inst LED_OBUF[15]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 3570
load inst LED_OBUF[3]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1280
load inst LED_OBUF[9]_inst OBUFT hdi_primitives -attr @cell(#000000) OBUFT -pg 1 -lvl 8 -y 2930
load inst LED_OBUF[2]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1210
load inst LED_OBUF[5]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1420
load inst FSM_sequential_FSMState_reg[0]_rep FDRE hdi_primitives -attr @cell(#000000) FDRE -pg 1 -lvl 4 -y 1950
load inst LED_OBUF[0]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1070
load inst LED_OBUF[4]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1350
load inst LED_OBUF[8]_inst OBUFT hdi_primitives -attr @cell(#000000) OBUFT -pg 1 -lvl 8 -y 2840
load inst BTNC_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 6 -y 350
load inst LED_OBUF[15]_inst_i_1 LUT2 hdi_primitives -attr @cell(#000000) LUT2 -pg 1 -lvl 7 -y 3560
load inst M_CLK_OBUF_BUFG_inst BUFG hdi_primitives -attr @cell(#000000) BUFG -pg 1 -lvl 4 -y 2980
load inst FSM_sequential_FSMState_reg[1]_rep FDRE hdi_primitives -attr @cell(#000000) FDRE -pg 1 -lvl 6 -y 1990
load inst LED_OBUF[1]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -y 1140
load inst nolabel_line606 SampleSineWave work:SampleSineWave:NOFILE -autohide -attr @cell(#000000) SampleSineWave -pinBusAttr CO @name CO -pinBusAttr D @name D[7:0] -pinBusAttr DI @name DI[1:0] -pinBusAttr EvenSampleAnalogVoltage_reg[1] @name EvenSampleAnalogVoltage_reg[1][2:0] -pinBusAttr O @name O -pinBusAttr OddSampleAnalogVoltage_reg[1] @name OddSampleAnalogVoltage_reg[1][2:0] -pinBusAttr Q @name Q[7:0] -pinBusAttr S @name S -pinBusAttr Sum2__25_carry__1 @name Sum2__25_carry__1[4:0] -pinBusAttr Sum2_inferred__0/i___25_carry__1 @name Sum2_inferred__0/i___25_carry__1[4:0] -pinBusAttr Sum2_inferred__1/i___15_carry_0 @name Sum2_inferred__1/i___15_carry_0 -pinBusAttr Sum2_inferred__1/i___15_carry__0 @name Sum2_inferred__1/i___15_carry__0[1:0] -pinBusAttr Sum2_inferred__2/i___15_carry @name Sum2_inferred__2/i___15_carry -pinBusAttr Sum2_inferred__2/i___15_carry_0 @name Sum2_inferred__2/i___15_carry_0 -pinBusAttr Sum2_inferred__2/i___15_carry_2 @name Sum2_inferred__2/i___15_carry_2 -pinBusAttr Sum2_inferred__2/i___15_carry__0 @name Sum2_inferred__2/i___15_carry__0[1:0] -pinBusAttr _SineWaveSampleData_reg[0]_0 @name _SineWaveSampleData_reg[0]_0[3:0] -pinBusAttr _SineWaveSampleData_reg[0]_1 @name _SineWaveSampleData_reg[0]_1[3:0] -pinBusAttr _SineWaveSampleData_reg[0]_2 @name _SineWaveSampleData_reg[0]_2[1:0] -pinBusAttr _SineWaveSampleData_reg[0]_3 @name _SineWaveSampleData_reg[0]_3 -pinBusAttr _SineWaveSampleData_reg[1]_0 @name _SineWaveSampleData_reg[1]_0[3:0] -pinBusAttr _SineWaveSampleData_reg[1]_1 @name _SineWaveSampleData_reg[1]_1 -pinBusAttr _SineWaveSampleData_reg[1]_2 @name _SineWaveSampleData_reg[1]_2[3:0] -pinBusAttr _SineWaveSampleData_reg[1]_3 @name _SineWaveSampleData_reg[1]_3 -pinBusAttr _SineWaveSampleData_reg[1]_4 @name _SineWaveSampleData_reg[1]_4[1:0] -pinBusAttr _SineWaveSampleData_reg[1]_5 @name _SineWaveSampleData_reg[1]_5[1:0] -pinBusAttr _SineWaveSampleData_reg[2]_0 @name _SineWaveSampleData_reg[2]_0[1:0] -pinBusAttr _SineWaveSampleData_reg[2]_1 @name _SineWaveSampleData_reg[2]_1[1:0] -pinBusAttr _SineWaveSampleData_reg[2]_2 @name _SineWaveSampleData_reg[2]_2[1:0] -pinBusAttr _SineWaveSampleData_reg[2]_3 @name _SineWaveSampleData_reg[2]_3[1:0] -pinBusAttr _SineWaveSampleData_reg[3]_0 @name _SineWaveSampleData_reg[3]_0[3:0] -pinBusAttr _SineWaveSampleData_reg[3]_1 @name _SineWaveSampleData_reg[3]_1[3:0] -pinBusAttr _SineWaveSampleData_reg[3]_2 @name _SineWaveSampleData_reg[3]_2[1:0] -pinBusAttr _SineWaveSampleData_reg[3]_3 @name _SineWaveSampleData_reg[3]_3[1:0] -pinBusAttr _SineWaveSampleData_reg[3]_4 @name _SineWaveSampleData_reg[3]_4[1:0] -pinBusAttr _SineWaveSampleData_reg[3]_5 @name _SineWaveSampleData_reg[3]_5[1:0] -pinBusAttr _SineWaveSampleData_reg[4]_0 @name _SineWaveSampleData_reg[4]_0[3:0] -pinBusAttr _SineWaveSampleData_reg[4]_1 @name _SineWaveSampleData_reg[4]_1 -pinBusAttr _SineWaveSampleData_reg[4]_2 @name _SineWaveSampleData_reg[4]_2[3:0] -pinBusAttr _SineWaveSampleData_reg[4]_3 @name _SineWaveSampleData_reg[4]_3 -pinBusAttr _SineWaveSampleData_reg[4]_4 @name _SineWaveSampleData_reg[4]_4[1:0] -pinBusAttr _SineWaveSampleData_reg[4]_5 @name _SineWaveSampleData_reg[4]_5[1:0] -pinBusAttr _SineWaveSampleData_reg[5]_0 @name _SineWaveSampleData_reg[5]_0[2:0] -pinBusAttr _SineWaveSampleData_reg[5]_1 @name _SineWaveSampleData_reg[5]_1[1:0] -pinBusAttr _SineWaveSampleData_reg[5]_2 @name _SineWaveSampleData_reg[5]_2[2:0] -pinBusAttr _SineWaveSampleData_reg[5]_3 @name _SineWaveSampleData_reg[5]_3[1:0] -pinBusAttr _SineWaveSampleData_reg[6]_0 @name _SineWaveSampleData_reg[6]_0[1:0] -pinBusAttr _SineWaveSampleData_reg[6]_1 @name _SineWaveSampleData_reg[6]_1[1:0] -pinBusAttr _SineWaveSampleData_reg[6]_2 @name _SineWaveSampleData_reg[6]_2 -pinBusAttr _SineWaveSampleData_reg[6]_3 @name _SineWaveSampleData_reg[6]_3 -pinBusAttr _SineWaveSampleData_reg[7]_0 @name _SineWaveSampleData_reg[7]_0 -pinBusAttr _SineWaveSampleData_reg[7]_2 @name _SineWaveSampleData_reg[7]_2 -pinBusAttr i___15_carry_i_5 @name i___15_carry_i_5 -pinBusAttr i___15_carry_i_5__0 @name i___15_carry_i_5__0 -pg 1 -lvl 6 -y 620
load inst LED_OBUF[12]_inst OBUFT hdi_primitives -attr @cell(#000000) OBUFT -pg 1 -lvl 8 -y 3200
load inst LED_OBUF[14]_inst_i_1 LUT1 hdi_primitives -attr @cell(#000000) LUT1 -pg 1 -lvl 7 -y 3400
load inst SinWaveCLK_BUFG_inst BUFG hdi_primitives -attr @cell(#000000) BUFG -pg 1 -lvl 6 -y 3020
load inst nolabel_line562 CLK_Generator work:CLK_Generator:NOFILE -autohide -attr @cell(#000000) CLK_Generator -pinBusAttr Q @name Q -pg 1 -lvl 3 -y 2970
load net LED[11] -attr @rip(#000000) 11 -port LED[11] -pin LED_OBUF[11]_inst O
load net nolabel_line606_n_80 -attr @rip(#000000) _SineWaveSampleData_reg[4]_2[2] -pin nolabel_line578 i___55_carry__0_i_8_1[2] -pin nolabel_line606 _SineWaveSampleData_reg[4]_2[2]
load net nolabel_line606_n_81 -attr @rip(#000000) _SineWaveSampleData_reg[4]_2[1] -pin nolabel_line578 i___55_carry__0_i_8_1[1] -pin nolabel_line606 _SineWaveSampleData_reg[4]_2[1]
load net nolabel_line606_n_82 -attr @rip(#000000) _SineWaveSampleData_reg[4]_2[0] -pin nolabel_line578 i___55_carry__0_i_8_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[4]_2[0]
load net nolabel_line606_n_83 -attr @rip(#000000) _SineWaveSampleData_reg[4]_3[0] -pin nolabel_line578 i___55_carry__1_i_7_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[4]_3[0]
netloc nolabel_line606_n_83 1 6 1 3340
load net nolabel_line606_n_84 -attr @rip(#000000) _SineWaveSampleData_reg[1]_4[1] -pin nolabel_line578 i___15_carry_i_4_1[1] -pin nolabel_line606 _SineWaveSampleData_reg[1]_4[1]
load net nolabel_line606_n_85 -attr @rip(#000000) _SineWaveSampleData_reg[1]_4[0] -pin nolabel_line578 i___15_carry_i_4_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[1]_4[0]
load net LED[8] -attr @rip(#000000) 8 -port LED[8] -pin LED_OBUF[8]_inst O
load net nolabel_line606_n_86 -attr @rip(#000000) OddSampleAnalogVoltage_reg[1][2] -pin nolabel_line578 Sum[0]_i_15_1[2] -pin nolabel_line606 OddSampleAnalogVoltage_reg[1][2]
load net nolabel_line606_n_87 -attr @rip(#000000) OddSampleAnalogVoltage_reg[1][1] -pin nolabel_line578 Sum[0]_i_15_1[1] -pin nolabel_line606 OddSampleAnalogVoltage_reg[1][1]
load net nolabel_line606_n_88 -attr @rip(#000000) OddSampleAnalogVoltage_reg[1][0] -pin nolabel_line578 Sum[0]_i_15_1[0] -pin nolabel_line606 OddSampleAnalogVoltage_reg[1][0]
load net nolabel_line606_n_89 -attr @rip(#000000) _SineWaveSampleData_reg[6]_2[0] -pin nolabel_line578 Sum[0]_i_12_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[6]_2[0]
netloc nolabel_line606_n_89 1 6 1 3260
load net nolabel_line578_n_30 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[7]_0[1] -pin nolabel_line578 EvenSampleAnalogVoltage_reg[7]_0[1] -pin nolabel_line606 Sum2_inferred__0/i___25_carry__1[1]
load net M_CLK -port M_CLK -pin M_CLK_OBUF_inst O
netloc M_CLK 1 8 1 NJ
load net nolabel_line578_n_31 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[7]_0[0] -pin nolabel_line578 EvenSampleAnalogVoltage_reg[7]_0[0] -pin nolabel_line606 Sum2_inferred__0/i___25_carry__1[0]
load net nolabel_line578_n_32 -pin nolabel_line578 OddSampleAnalogVoltage_reg[2]_1 -pin nolabel_line606 Sum2_carry__0
netloc nolabel_line578_n_32 1 5 3 2510 190 NJ 190 5280
load net LED[12] -attr @rip(#000000) 12 -port LED[12] -pin LED_OBUF[12]_inst O
load net nolabel_line578_n_33 -pin nolabel_line578 OddSampleAnalogVoltage_reg[3]_0 -pin nolabel_line606 Sum2_carry__0_0
netloc nolabel_line578_n_33 1 5 3 2570 250 NJ 250 5240
load net nolabel_line606_n_90 -attr @rip(#000000) _SineWaveSampleData_reg[1]_5[1] -pin nolabel_line578 i___15_carry_i_4__0_1[1] -pin nolabel_line606 _SineWaveSampleData_reg[1]_5[1]
load net nolabel_line578_n_34 -pin nolabel_line578 OddSampleAnalogVoltage_reg[4]_0 -pin nolabel_line606 Sum2_carry__0_1
netloc nolabel_line578_n_34 1 5 3 2590 270 NJ 270 5220
load net <const0> -ground -pin AUD_PWM_OBUF_inst I -pin FSM_sequential_FSMState_reg[0] R -pin FSM_sequential_FSMState_reg[0]_rep R -pin FSM_sequential_FSMState_reg[0]_rep__0 R -pin FSM_sequential_FSMState_reg[1] R -pin FSM_sequential_FSMState_reg[1]_rep R -pin FSM_sequential_FSMState_reg[1]_rep__0 R -pin FSM_sequential_FSMState_reg[1]_rep__1 R -pin LED_OBUF[10]_inst I -pin LED_OBUF[11]_inst I -pin LED_OBUF[12]_inst I -pin LED_OBUF[13]_inst I -pin LED_OBUF[8]_inst I -pin LED_OBUF[9]_inst I -pin M_LRSEL_OBUF_inst I
load net nolabel_line606_n_91 -attr @rip(#000000) _SineWaveSampleData_reg[1]_5[0] -pin nolabel_line578 i___15_carry_i_4__0_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[1]_5[0]
load net nolabel_line578_n_35 -pin nolabel_line578 OddSampleAnalogVoltage_reg[5]_0 -pin nolabel_line606 Sum2_carry__0_2
netloc nolabel_line578_n_35 1 5 3 2610 290 NJ 290 5200
load net nolabel_line606_n_92 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[1][2] -pin nolabel_line578 Sum[0]_i_15_3[2] -pin nolabel_line606 EvenSampleAnalogVoltage_reg[1][2]
load net nolabel_line578_n_36 -pin nolabel_line578 OddSampleAnalogVoltage_reg[2]_2 -pin nolabel_line606 Sum2__25_carry__0
netloc nolabel_line578_n_36 1 5 3 2290 1510 NJ 1510 5000
load net nolabel_line606_n_93 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[1][1] -pin nolabel_line578 Sum[0]_i_15_3[1] -pin nolabel_line606 EvenSampleAnalogVoltage_reg[1][1]
load net nolabel_line578_n_37 -pin nolabel_line578 OddSampleAnalogVoltage_reg[3]_1 -pin nolabel_line606 Sum2__25_carry__0_0
netloc nolabel_line578_n_37 1 5 3 2310 1530 NJ 1530 4980
load net nolabel_line578_n_38 -pin nolabel_line578 OddSampleAnalogVoltage_reg[4]_1 -pin nolabel_line606 Sum2__25_carry__0_1
netloc nolabel_line578_n_38 1 5 3 2330 1550 NJ 1550 4960
load net nolabel_line606_n_94 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[1][0] -pin nolabel_line578 Sum[0]_i_15_3[0] -pin nolabel_line606 EvenSampleAnalogVoltage_reg[1][0]
load net nolabel_line578_n_39 -pin nolabel_line578 OddSampleAnalogVoltage_reg[5]_1 -pin nolabel_line606 Sum2__25_carry__0_2
netloc nolabel_line578_n_39 1 5 3 2350 1570 NJ 1570 4940
load net LED[9] -attr @rip(#000000) 9 -port LED[9] -pin LED_OBUF[9]_inst O
load net nolabel_line606_n_95 -attr @rip(#000000) _SineWaveSampleData_reg[6]_3[0] -pin nolabel_line578 Sum[0]_i_12_3[0] -pin nolabel_line606 _SineWaveSampleData_reg[6]_3[0]
netloc nolabel_line606_n_95 1 6 1 3380
load net nolabel_line606_n_96 -attr @rip(#000000) _SineWaveSampleData_reg[4]_4[1] -pin nolabel_line578 i___15_carry_i_7_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[4]_4[1]
load net FSM_sequential_FSMState_reg[1]_rep__1_n_0 -pin FSM_sequential_FSMState_reg[1]_rep__1 Q -pin nolabel_line568 _MicDataSampled_reg[0]_rep__1_1 -pin nolabel_line578 WriteAddress_reg[18]_0
netloc FSM_sequential_FSMState_reg[1]_rep__1_n_0 1 4 3 1310 2510 1930J 2610 4040
load net nolabel_line606_n_97 -attr @rip(#000000) _SineWaveSampleData_reg[4]_4[0] -pin nolabel_line578 i___15_carry_i_7_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[4]_4[0]
load net nolabel_line606_n_98 -attr @rip(#000000) _SineWaveSampleData_reg[4]_5[1] -pin nolabel_line578 i___15_carry_i_7__0_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[4]_5[1]
load net nolabel_line606_n_99 -attr @rip(#000000) _SineWaveSampleData_reg[4]_5[0] -pin nolabel_line578 i___15_carry_i_7__0_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[4]_5[0]
load net nolabel_line578_n_20 -pin FSM_sequential_FSMState_reg[0]_rep D -pin nolabel_line578 _PROCESS_DONE_reg_1
netloc nolabel_line578_n_20 1 3 5 860 1850 NJ 1850 NJ 1850 NJ 1850 5200
load net nolabel_line578_n_21 -pin FSM_sequential_FSMState_reg[0]_rep__0 D -pin nolabel_line578 _PROCESS_DONE_reg_2
netloc nolabel_line578_n_21 1 3 5 860 2310 NJ 2310 1990J 2210 NJ 2210 5220
load net nolabel_line578_n_22 -attr @rip(#000000) Q[4] -pin nolabel_line578 Q[4] -pin nolabel_line606 Sum2__25_carry__1[4]
load net FSM_sequential_FSMState_reg[1]_rep__0_n_0 -pin FSM_sequential_FSMState_reg[1]_rep__0 Q -pin nolabel_line578 ReadAddress_reg_rep[7]_rep__9_1
netloc FSM_sequential_FSMState_reg[1]_rep__0_n_0 1 6 1 4100
load net nolabel_line578_n_23 -attr @rip(#000000) Q[3] -pin nolabel_line578 Q[3] -pin nolabel_line606 Sum2__25_carry__1[3]
load net nolabel_line606_n_0 -attr @rip(#000000) _SineWaveSampleData_reg[6]_0[1] -pin nolabel_line578 Sum[0]_i_15_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[6]_0[1]
load net nolabel_line578_n_24 -attr @rip(#000000) Q[2] -pin nolabel_line578 Q[2] -pin nolabel_line606 Sum2__25_carry__1[2]
load net nolabel_line606_n_1 -attr @rip(#000000) _SineWaveSampleData_reg[6]_0[0] -pin nolabel_line578 Sum[0]_i_15_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[6]_0[0]
load net nolabel_line578_n_25 -attr @rip(#000000) Q[1] -pin nolabel_line578 Q[1] -pin nolabel_line606 Sum2__25_carry__1[1]
load net nolabel_line568_n_2 -pin nolabel_line568 _MicDataSampled_reg[0]_rep_0 -pin nolabel_line578 OddSampleAnalogVoltage[7]_i_457_0
netloc nolabel_line568_n_2 1 5 2 NJ 2170 4060
load net nolabel_line578_n_26 -attr @rip(#000000) Q[0] -pin nolabel_line578 Q[0] -pin nolabel_line606 Sum2__25_carry__1[0]
load net <const1> -power -pin AUD_PWM_OBUF_inst T -pin AUD_SD_OBUF_inst I -pin FSM_sequential_FSMState_reg[0] CE -pin FSM_sequential_FSMState_reg[0]_rep CE -pin FSM_sequential_FSMState_reg[0]_rep__0 CE -pin FSM_sequential_FSMState_reg[1] CE -pin FSM_sequential_FSMState_reg[1]_rep CE -pin FSM_sequential_FSMState_reg[1]_rep__0 CE -pin FSM_sequential_FSMState_reg[1]_rep__1 CE -pin LED_OBUF[10]_inst T -pin LED_OBUF[11]_inst T -pin LED_OBUF[12]_inst T -pin LED_OBUF[13]_inst T -pin LED_OBUF[8]_inst T -pin LED_OBUF[9]_inst T
load net nolabel_line568_n_3 -pin nolabel_line568 _MicDataSampled_reg[0]_rep__0_0 -pin nolabel_line578 OddSampleAnalogVoltage[4]_i_275_0
netloc nolabel_line568_n_3 1 5 2 NJ 2130 3900
load net M_CLK_OBUF -attr @rip(#000000) Q[0] -pin M_CLK_OBUF_BUFG_inst I -pin nolabel_line562 Q[0]
netloc M_CLK_OBUF 1 3 1 NJ
load net nolabel_line578_n_27 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[7]_0[4] -pin nolabel_line578 EvenSampleAnalogVoltage_reg[7]_0[4] -pin nolabel_line606 Sum2_inferred__0/i___25_carry__1[4]
load net LED[6] -attr @rip(#000000) 6 -port LED[6] -pin LED_OBUF[6]_inst O
load net nolabel_line568_n_4 -attr @rip(#000000) _MicDataSampled_reg[0]_rep__1_0[0] -pin nolabel_line568 _MicDataSampled_reg[0]_rep__1_0[0] -pin nolabel_line578 OddSampleAnalogVoltage[7]_i_201_0[0]
netloc nolabel_line568_n_4 1 5 2 NJ 2150 3980
load net nolabel_line578_n_28 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[7]_0[3] -pin nolabel_line578 EvenSampleAnalogVoltage_reg[7]_0[3] -pin nolabel_line606 Sum2_inferred__0/i___25_carry__1[3]
load net nolabel_line568_n_5 -pin FSM_sequential_FSMState_reg[1] D -pin nolabel_line568 _RECORD_DONE_reg_0
netloc nolabel_line568_n_5 1 3 3 860 2550 NJ 2550 1910
load net nolabel_line578_n_29 -attr @rip(#000000) EvenSampleAnalogVoltage_reg[7]_0[2] -pin nolabel_line578 EvenSampleAnalogVoltage_reg[7]_0[2] -pin nolabel_line606 Sum2_inferred__0/i___25_carry__1[2]
load net nolabel_line568_n_6 -pin FSM_sequential_FSMState_reg[1]_rep D -pin nolabel_line568 _RECORD_DONE_reg_1
netloc nolabel_line568_n_6 1 5 1 1950
load net nolabel_line568_n_7 -pin FSM_sequential_FSMState_reg[1]_rep__0 D -pin nolabel_line568 _RECORD_DONE_reg_2
netloc nolabel_line568_n_7 1 5 1 2010
load net nolabel_line568_n_8 -pin FSM_sequential_FSMState_reg[1]_rep__1 D -pin nolabel_line568 _RECORD_DONE_reg_3
netloc nolabel_line568_n_8 1 3 3 860 2530 NJ 2530 1890
load net M_DATA -port M_DATA -pin M_DATA_IBUF_inst I
netloc M_DATA 1 0 4 NJ 2090 NJ 2090 NJ 2090 NJ
load net LED_OBUF[4] -attr @rip(#000000) _FourierResult_reg[7]_0[4] -pin LED_OBUF[4]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[4]
load net AUD_PWM -port AUD_PWM -pin AUD_PWM_OBUF_inst O
netloc AUD_PWM 1 8 1 NJ
load net BTNC -port BTNC -pin BTNC_IBUF_inst I
netloc BTNC 1 0 6 NJ 350 NJ 350 NJ 350 NJ 350 NJ 350 NJ
load net LED[10] -attr @rip(#000000) 10 -port LED[10] -pin LED_OBUF[10]_inst O
load net nolabel_line578_n_50 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[5]_1 -pin nolabel_line606 Sum2_inferred__0/i___25_carry__0_2
netloc nolabel_line578_n_50 1 5 3 2090 2570 NJ 2570 5600
load net M_CLK_OBUF_BUFG -pin M_CLK_OBUF_BUFG_inst O -pin M_CLK_OBUF_inst I -pin nolabel_line568 M_CLK_OBUF_BUFG -pin nolabel_line578 M_CLK_OBUF_BUFG
netloc M_CLK_OBUF_BUFG 1 4 4 1290 2330 1950J 2510 4080 2610 NJ
load net nolabel_line578_n_51 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[0]_1 -pin nolabel_line606 Sum2_inferred__2/i___15_carry_1
netloc nolabel_line578_n_51 1 5 3 2250 2590 NJ 2590 5700
load net nolabel_line578_n_52 -pin nolabel_line578 _SineWaveSampleData_reg[7]_0 -pin nolabel_line606 Sum2_inferred__2/i___15_carry__0_1
netloc nolabel_line578_n_52 1 5 3 2370 2450 NJ 2450 5120
load net nolabel_line578_n_53 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[2]_3 -pin nolabel_line606 Sum2_inferred__2/i___15_carry__0_0
netloc nolabel_line578_n_53 1 5 3 2270 2470 NJ 2470 5680
load net LED[7] -attr @rip(#000000) 7 -port LED[7] -pin LED_OBUF[7]_inst O
load net FSMState[1] -attr @rip(#000000) 1 -pin FSM_sequential_FSMState_reg[1] Q -pin LED_OBUF[15]_inst_i_1 I0 -pin nolabel_line568 FSMState[1] -pin nolabel_line578 FSMState[1]
load net SinWaveCLK_BUFG -pin SinWaveCLK_BUFG_inst O -pin nolabel_line578 SinWaveCLK_BUFG
netloc SinWaveCLK_BUFG 1 6 1 4120
load net SinWaveCLK -pin SinWaveCLK_BUFG_inst I -pin nolabel_line562 SinWaveCLK
netloc SinWaveCLK 1 3 3 860J 3020 NJ 3020 NJ
load net AUD_SD -port AUD_SD -pin AUD_SD_OBUF_inst O
netloc AUD_SD 1 8 1 NJ
load net LED_OBUF[3] -attr @rip(#000000) _FourierResult_reg[7]_0[3] -pin LED_OBUF[3]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[3]
load net _MicDataSampled -pin nolabel_line568 _MicDataSampled -pin nolabel_line578 _MicDataSampled
netloc _MicDataSampled 1 5 2 NJ 2110 4180
load net _SineWaveSampleData[3] -attr @rip(#000000) Q[3] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[3] -pin nolabel_line606 Q[3]
load net nolabel_line578_n_40 -pin nolabel_line578 OddSampleAnalogVoltage_reg[0]_1 -pin nolabel_line606 Sum2_inferred__1/i___15_carry
netloc nolabel_line578_n_40 1 5 3 2450 1650 NJ 1650 5180
load net nolabel_line578_n_41 -pin nolabel_line578 _SineWaveSampleData_reg[7] -pin nolabel_line606 Sum2_inferred__1/i___15_carry__0_1
netloc nolabel_line578_n_41 1 5 3 2510 1710 NJ 1710 4880
load net nolabel_line578_n_42 -pin nolabel_line578 OddSampleAnalogVoltage_reg[2]_3 -pin nolabel_line606 Sum2_inferred__1/i___15_carry__0_0
netloc nolabel_line578_n_42 1 5 3 2490 1690 NJ 1690 5160
load net nolabel_line578_n_0 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[0]_0 -pin nolabel_line606 Sum2_inferred__2/i___7_carry
netloc nolabel_line578_n_0 1 5 3 2150 30 NJ 30 5440
load net nolabel_line578_n_43 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[2]_1 -pin nolabel_line606 Sum2_inferred__0/i__carry__0
netloc nolabel_line578_n_43 1 5 3 2390 1590 NJ 1590 5500
load net LED[4] -attr @rip(#000000) 4 -port LED[4] -pin LED_OBUF[4]_inst O
load net nolabel_line578_n_1 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[1]_0 -pin nolabel_line606 Sum2_inferred__2/i___7_carry_1
netloc nolabel_line578_n_1 1 5 3 2130 50 NJ 50 5420
load net nolabel_line578_n_44 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[3]_0 -pin nolabel_line606 Sum2_inferred__0/i__carry__0_0
netloc nolabel_line578_n_44 1 5 3 2410 1610 NJ 1610 5400
load net FSMState[0] -attr @rip(#000000) 0 -pin FSM_sequential_FSMState_reg[0] Q -pin LED_OBUF[14]_inst_i_1 I0 -pin LED_OBUF[15]_inst_i_1 I1 -pin nolabel_line568 FSMState[0] -pin nolabel_line578 FSMState[0]
load net LED[15] -attr @rip(#000000) 15 -port LED[15] -pin LED_OBUF[15]_inst O
load net nolabel_line578_n_2 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[2]_0 -pin nolabel_line606 Sum2_inferred__2/i___7_carry_0
netloc nolabel_line578_n_2 1 5 3 2170 70 NJ 70 5400
load net nolabel_line578_n_45 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[4]_0 -pin nolabel_line606 Sum2_inferred__0/i__carry__0_1
netloc nolabel_line578_n_45 1 5 3 2430 1630 NJ 1630 5260
load net nolabel_line578_n_3 -pin nolabel_line578 OddSampleAnalogVoltage_reg[0]_0 -pin nolabel_line606 Sum2_inferred__1/i___7_carry
netloc nolabel_line578_n_3 1 5 3 2230 130 NJ 130 5340
load net nolabel_line578_n_46 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[5]_0 -pin nolabel_line606 Sum2_inferred__0/i__carry__0_2
netloc nolabel_line578_n_46 1 5 3 2190 2410 NJ 2410 5580
load net nolabel_line578_n_4 -pin nolabel_line578 OddSampleAnalogVoltage_reg[1]_0 -pin nolabel_line606 Sum2_inferred__1/i___7_carry_1
netloc nolabel_line578_n_4 1 5 3 2210 150 NJ 150 5320
load net nolabel_line578_n_47 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[2]_2 -pin nolabel_line606 Sum2_inferred__0/i___25_carry__0
netloc nolabel_line578_n_47 1 5 3 2110 2430 NJ 2430 5640
load net nolabel_line578_n_5 -pin nolabel_line578 OddSampleAnalogVoltage_reg[2]_0 -pin nolabel_line606 Sum2_inferred__1/i___7_carry_0
netloc nolabel_line578_n_5 1 5 3 2250 170 NJ 170 5300
load net nolabel_line578_n_48 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[3]_1 -pin nolabel_line606 Sum2_inferred__0/i___25_carry__0_0
netloc nolabel_line578_n_48 1 5 3 2050 2530 NJ 2530 5660
load net LED_OBUF[2] -attr @rip(#000000) _FourierResult_reg[7]_0[2] -pin LED_OBUF[2]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[2]
load net nolabel_line578_n_6 -pin nolabel_line568 RecordTimeCounter_reg[0]_0 -pin nolabel_line578 FSM_sequential_FSMState_reg[1]_rep__1
netloc nolabel_line578_n_6 1 4 4 1330 2290 1930J 2190 NJ 2190 5540
load net nolabel_line578_n_49 -pin nolabel_line578 EvenSampleAnalogVoltage_reg[4]_1 -pin nolabel_line606 Sum2_inferred__0/i___25_carry__0_1
netloc nolabel_line578_n_49 1 5 3 2070 2550 NJ 2550 5620
load net nolabel_line578_n_7 -attr @rip(#000000) CO[0] -pin nolabel_line578 CO[0] -pin nolabel_line606 CO[0]
netloc nolabel_line578_n_7 1 5 3 2350 10 NJ 10 5460
load net nolabel_line578_n_8 -attr @rip(#000000) O[0] -pin nolabel_line578 O[0] -pin nolabel_line606 O[0]
netloc nolabel_line578_n_8 1 5 3 2430 110 NJ 110 5360
load net nolabel_line578_n_9 -attr @rip(#000000) _SineWaveSampleData_reg[5][0] -pin nolabel_line578 _SineWaveSampleData_reg[5][0] -pin nolabel_line606 i___15_carry_i_5[0]
netloc nolabel_line578_n_9 1 5 3 2610 1810 NJ 1810 5060
load net _SineWaveSampleData[2] -attr @rip(#000000) Q[2] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[2] -pin nolabel_line606 Q[2]
load net LED_OBUF[5] -attr @rip(#000000) _FourierResult_reg[7]_0[5] -pin LED_OBUF[5]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[5]
load net LED[5] -attr @rip(#000000) 5 -port LED[5] -pin LED_OBUF[5]_inst O
load net nolabel_line606_n_60 -attr @rip(#000000) _SineWaveSampleData_reg[3]_5[1] -pin nolabel_line578 i___55_carry_i_5_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[3]_5[1]
load net CLK100MHZ_IBUF_BUFG -pin CLK100MHZ_IBUF_BUFG_inst O -pin FSM_sequential_FSMState_reg[0] C -pin FSM_sequential_FSMState_reg[0]_rep C -pin FSM_sequential_FSMState_reg[0]_rep__0 C -pin FSM_sequential_FSMState_reg[1] C -pin FSM_sequential_FSMState_reg[1]_rep C -pin FSM_sequential_FSMState_reg[1]_rep__0 C -pin FSM_sequential_FSMState_reg[1]_rep__1 C -pin nolabel_line562 CLK100MHZ_IBUF_BUFG -pin nolabel_line606 CLK100MHZ_IBUF_BUFG
netloc CLK100MHZ_IBUF_BUFG 1 2 4 490 2820 840 2330 1230J 2350 1970
load net nolabel_line606_n_61 -attr @rip(#000000) _SineWaveSampleData_reg[3]_5[0] -pin nolabel_line578 i___55_carry_i_5_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[3]_5[0]
load net nolabel_line606_n_62 -attr @rip(#000000) S[0] -pin nolabel_line578 S[0] -pin nolabel_line606 S[0]
netloc nolabel_line606_n_62 1 6 1 3280
load net LED_OBUF[1] -attr @rip(#000000) _FourierResult_reg[7]_0[1] -pin LED_OBUF[1]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[1]
load net nolabel_line606_n_63 -attr @rip(#000000) _SineWaveSampleData_reg[1]_0[3] -pin nolabel_line578 Sum2__55_carry_1[3] -pin nolabel_line606 _SineWaveSampleData_reg[1]_0[3]
load net M_DATA_IBUF -pin M_DATA_IBUF_inst O -pin nolabel_line568 M_DATA_IBUF
netloc M_DATA_IBUF 1 4 1 1250J
load net nolabel_line606_n_64 -attr @rip(#000000) _SineWaveSampleData_reg[1]_0[2] -pin nolabel_line578 Sum2__55_carry_1[2] -pin nolabel_line606 _SineWaveSampleData_reg[1]_0[2]
load net nolabel_line606_n_65 -attr @rip(#000000) _SineWaveSampleData_reg[1]_0[1] -pin nolabel_line578 Sum2__55_carry_1[1] -pin nolabel_line606 _SineWaveSampleData_reg[1]_0[1]
load net _SineWaveSampleData[1] -attr @rip(#000000) Q[1] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[1] -pin nolabel_line606 Q[1]
load net nolabel_line606_n_66 -attr @rip(#000000) _SineWaveSampleData_reg[1]_0[0] -pin nolabel_line578 Sum2__55_carry_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[1]_0[0]
load net nolabel_line606_n_67 -attr @rip(#000000) _SineWaveSampleData_reg[1]_1[0] -pin nolabel_line578 Sum2__55_carry__0_i_11_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[1]_1[0]
netloc nolabel_line606_n_67 1 6 1 N
load net nolabel_line606_n_68 -attr @rip(#000000) _SineWaveSampleData_reg[4]_0[3] -pin nolabel_line578 Sum2__55_carry__0_i_8_1[3] -pin nolabel_line606 _SineWaveSampleData_reg[4]_0[3]
load net nolabel_line606_n_69 -attr @rip(#000000) _SineWaveSampleData_reg[4]_0[2] -pin nolabel_line578 Sum2__55_carry__0_i_8_1[2] -pin nolabel_line606 _SineWaveSampleData_reg[4]_0[2]
load net FSM_sequential_FSMState_reg[0]_rep_n_0 -pin FSM_sequential_FSMState_reg[0]_rep Q -pin nolabel_line568 FSM_sequential_FSMState_reg[1]_rep -pin nolabel_line578 _Phase_reg[4]_0
netloc FSM_sequential_FSMState_reg[0]_rep_n_0 1 4 3 1290 1870 NJ 1870 4160
load net LED[2] -attr @rip(#000000) 2 -port LED[2] -pin LED_OBUF[2]_inst O
load net LED_OBUF[6] -attr @rip(#000000) _FourierResult_reg[7]_0[6] -pin LED_OBUF[6]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[6]
load net LED[13] -attr @rip(#000000) 13 -port LED[13] -pin LED_OBUF[13]_inst O
load net nolabel_line578_n_62 -attr @rip(#000000) out[7] -pin nolabel_line578 out[7] -pin nolabel_line606 D[7]
load net nolabel_line578_n_63 -attr @rip(#000000) out[6] -pin nolabel_line578 out[6] -pin nolabel_line606 D[6]
load net nolabel_line606_n_70 -attr @rip(#000000) _SineWaveSampleData_reg[4]_0[1] -pin nolabel_line578 Sum2__55_carry__0_i_8_1[1] -pin nolabel_line606 _SineWaveSampleData_reg[4]_0[1]
load net nolabel_line578_n_64 -attr @rip(#000000) out[5] -pin nolabel_line578 out[5] -pin nolabel_line606 D[5]
load net nolabel_line606_n_71 -attr @rip(#000000) _SineWaveSampleData_reg[4]_0[0] -pin nolabel_line578 Sum2__55_carry__0_i_8_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[4]_0[0]
load net nolabel_line578_n_65 -attr @rip(#000000) out[4] -pin nolabel_line578 out[4] -pin nolabel_line606 D[4]
load net nolabel_line606_n_72 -attr @rip(#000000) _SineWaveSampleData_reg[4]_1[0] -pin nolabel_line578 Sum2__55_carry__1_i_7_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[4]_1[0]
netloc nolabel_line606_n_72 1 6 1 4000
load net nolabel_line578_n_66 -attr @rip(#000000) out[3] -pin nolabel_line578 out[3] -pin nolabel_line606 D[3]
load net nolabel_line606_n_73 -attr @rip(#000000) _SineWaveSampleData_reg[0]_3[0] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[0]_3[0]
netloc nolabel_line606_n_73 1 6 1 3800
load net FSM_sequential_FSMState_reg[0]_rep__0_n_0 -pin FSM_sequential_FSMState_reg[0]_rep__0 Q -pin nolabel_line568 FSM_sequential_FSMState_reg[1]_rep__1 -pin nolabel_line578 ReadAddress_reg_rep[7]_rep__9_0
netloc FSM_sequential_FSMState_reg[0]_rep__0_n_0 1 4 3 1230 1890 NJ 1890 3920
load net nolabel_line578_n_67 -attr @rip(#000000) out[2] -pin nolabel_line578 out[2] -pin nolabel_line606 D[2]
load net nolabel_line606_n_74 -attr @rip(#000000) _SineWaveSampleData_reg[1]_2[3] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_3[3] -pin nolabel_line606 _SineWaveSampleData_reg[1]_2[3]
load net nolabel_line578_n_68 -attr @rip(#000000) out[1] -pin nolabel_line578 out[1] -pin nolabel_line606 D[1]
load net _SineWaveSampleData[0] -attr @rip(#000000) Q[0] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[0] -pin nolabel_line606 Q[0]
load net nolabel_line606_n_75 -attr @rip(#000000) _SineWaveSampleData_reg[1]_2[2] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_3[2] -pin nolabel_line606 _SineWaveSampleData_reg[1]_2[2]
load net nolabel_line606_n_10 -attr @rip(#000000) _SineWaveSampleData_reg[6]_1[1] -pin nolabel_line578 Sum[0]_i_15_2[1] -pin nolabel_line606 _SineWaveSampleData_reg[6]_1[1]
load net nolabel_line578_n_69 -attr @rip(#000000) out[0] -pin nolabel_line578 out[0] -pin nolabel_line606 D[0]
load net nolabel_line606_n_76 -attr @rip(#000000) _SineWaveSampleData_reg[1]_2[1] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_3[1] -pin nolabel_line606 _SineWaveSampleData_reg[1]_2[1]
load net nolabel_line606_n_11 -attr @rip(#000000) _SineWaveSampleData_reg[6]_1[0] -pin nolabel_line578 Sum[0]_i_15_2[0] -pin nolabel_line606 _SineWaveSampleData_reg[6]_1[0]
load net nolabel_line606_n_77 -attr @rip(#000000) _SineWaveSampleData_reg[1]_2[0] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_3[0] -pin nolabel_line606 _SineWaveSampleData_reg[1]_2[0]
load net nolabel_line606_n_12 -attr @rip(#000000) _SineWaveSampleData_reg[0]_0[3] -pin nolabel_line578 Sum2__55_carry_0[3] -pin nolabel_line606 _SineWaveSampleData_reg[0]_0[3]
load net nolabel_line606_n_78 -attr @rip(#000000) _SineWaveSampleData_reg[1]_3[0] -pin nolabel_line578 i___55_carry__0_i_11_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[1]_3[0]
netloc nolabel_line606_n_78 1 6 1 3860
load net nolabel_line606_n_13 -attr @rip(#000000) _SineWaveSampleData_reg[0]_0[2] -pin nolabel_line578 Sum2__55_carry_0[2] -pin nolabel_line606 _SineWaveSampleData_reg[0]_0[2]
load net nolabel_line606_n_79 -attr @rip(#000000) _SineWaveSampleData_reg[4]_2[3] -pin nolabel_line578 i___55_carry__0_i_8_1[3] -pin nolabel_line606 _SineWaveSampleData_reg[4]_2[3]
load net nolabel_line606_n_14 -attr @rip(#000000) _SineWaveSampleData_reg[0]_0[1] -pin nolabel_line578 Sum2__55_carry_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[0]_0[1]
load net nolabel_line606_n_15 -attr @rip(#000000) _SineWaveSampleData_reg[0]_0[0] -pin nolabel_line578 Sum2__55_carry_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[0]_0[0]
load net nolabel_line606_n_16 -attr @rip(#000000) _SineWaveSampleData_reg[2]_0[1] -pin nolabel_line578 i___15_carry_i_4_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[2]_0[1]
load net LED[3] -attr @rip(#000000) 3 -port LED[3] -pin LED_OBUF[3]_inst O
load net nolabel_line606_n_17 -attr @rip(#000000) _SineWaveSampleData_reg[2]_0[0] -pin nolabel_line578 i___15_carry_i_4_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[2]_0[0]
load net nolabel_line606_n_40 -attr @rip(#000000) _SineWaveSampleData_reg[3]_1[2] -pin nolabel_line578 i___55_carry__0_i_8_0[2] -pin nolabel_line606 _SineWaveSampleData_reg[3]_1[2]
load net nolabel_line606_n_18 -attr @rip(#000000) _SineWaveSampleData_reg[2]_1[1] -pin nolabel_line578 Sum2__55_carry__0_i_11_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[2]_1[1]
load net LED_OBUF[7] -attr @rip(#000000) _FourierResult_reg[7]_0[7] -pin LED_OBUF[7]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[7]
load net LED[14] -attr @rip(#000000) 14 -port LED[14] -pin LED_OBUF[14]_inst O
load net nolabel_line606_n_41 -attr @rip(#000000) _SineWaveSampleData_reg[3]_1[1] -pin nolabel_line578 i___55_carry__0_i_8_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[3]_1[1]
load net nolabel_line606_n_19 -attr @rip(#000000) _SineWaveSampleData_reg[2]_1[0] -pin nolabel_line578 Sum2__55_carry__0_i_11_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[2]_1[0]
load net nolabel_line606_n_42 -attr @rip(#000000) _SineWaveSampleData_reg[3]_1[0] -pin nolabel_line578 i___55_carry__0_i_8_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[3]_1[0]
load net nolabel_line606_n_43 -attr @rip(#000000) _SineWaveSampleData_reg[5]_2[2] -pin nolabel_line578 i___15_carry_i_7__0[2] -pin nolabel_line606 _SineWaveSampleData_reg[5]_2[2]
load net nolabel_line606_n_44 -attr @rip(#000000) _SineWaveSampleData_reg[5]_2[1] -pin nolabel_line578 i___15_carry_i_7__0[1] -pin nolabel_line606 _SineWaveSampleData_reg[5]_2[1]
load net nolabel_line606_n_45 -attr @rip(#000000) _SineWaveSampleData_reg[5]_2[0] -pin nolabel_line578 i___15_carry_i_7__0[0] -pin nolabel_line606 _SineWaveSampleData_reg[5]_2[0]
load net nolabel_line606_n_46 -attr @rip(#000000) _SineWaveSampleData_reg[5]_3[1] -pin nolabel_line578 i___55_carry__1_i_7_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[5]_3[1]
load net BTNC_IBUF -pin BTNC_IBUF_inst O -pin nolabel_line578 BTNC_IBUF
netloc BTNC_IBUF 1 6 1 NJ
load net FSM_sequential_FSMState_reg[1]_rep_n_0 -pin FSM_sequential_FSMState_reg[1]_rep Q -pin nolabel_line578 EvenSampleAnalogVoltage_reg[1]_1
netloc FSM_sequential_FSMState_reg[1]_rep_n_0 1 6 1 3740
load net nolabel_line606_n_47 -attr @rip(#000000) _SineWaveSampleData_reg[5]_3[0] -pin nolabel_line578 i___55_carry__1_i_7_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[5]_3[0]
load net nolabel_line606_n_48 -attr @rip(#000000) _SineWaveSampleData_reg[7]_2[0] -pin nolabel_line578 Sum[0]_i_12_2[0] -pin nolabel_line606 _SineWaveSampleData_reg[7]_2[0]
netloc nolabel_line606_n_48 1 6 1 3640
load net nolabel_line606_n_49 -pin nolabel_line578 Sum2_inferred__2/i___15_carry_0 -pin nolabel_line606 _SineWaveSampleData_reg[7]_3
netloc nolabel_line606_n_49 1 6 1 4140
load net LED[0] -attr @rip(#000000) 0 -port LED[0] -pin LED_OBUF[0]_inst O
load net _SineWaveSampleData[7] -attr @rip(#000000) Q[7] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[7] -pin nolabel_line606 Q[7]
load net nolabel_line606_n_50 -attr @rip(#000000) _SineWaveSampleData_reg[3]_2[1] -pin nolabel_line578 Sum2__55_carry_i_5_1[1] -pin nolabel_line606 _SineWaveSampleData_reg[3]_2[1]
load net nolabel_line606_n_51 -attr @rip(#000000) _SineWaveSampleData_reg[3]_2[0] -pin nolabel_line578 Sum2__55_carry_i_5_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[3]_2[0]
load net nolabel_line606_n_52 -attr @rip(#000000) _SineWaveSampleData_reg[3]_3[1] -pin nolabel_line578 i___55_carry_i_5_1[1] -pin nolabel_line606 _SineWaveSampleData_reg[3]_3[1]
load net nolabel_line606_n_53 -attr @rip(#000000) _SineWaveSampleData_reg[3]_3[0] -pin nolabel_line578 i___55_carry_i_5_1[0] -pin nolabel_line606 _SineWaveSampleData_reg[3]_3[0]
load net nolabel_line606_n_54 -attr @rip(#000000) DI[1] -pin nolabel_line578 DI[1] -pin nolabel_line606 DI[1]
load net nolabel_line606_n_55 -attr @rip(#000000) DI[0] -pin nolabel_line578 DI[0] -pin nolabel_line606 DI[0]
load net nolabel_line606_n_56 -attr @rip(#000000) _SineWaveSampleData_reg[3]_4[1] -pin nolabel_line578 Sum2__55_carry_i_5_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[3]_4[1]
load net nolabel_line606_n_57 -attr @rip(#000000) _SineWaveSampleData_reg[3]_4[0] -pin nolabel_line578 Sum2__55_carry_i_5_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[3]_4[0]
load net nolabel_line606_n_58 -attr @rip(#000000) _SineWaveSampleData_reg[0]_2[1] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[0]_2[1]
load net nolabel_line606_n_59 -attr @rip(#000000) _SineWaveSampleData_reg[0]_2[0] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[0]_2[0]
load net nolabel_line606_n_30 -pin nolabel_line578 Sum2_inferred__1/i___15_carry_0 -pin nolabel_line606 _SineWaveSampleData_reg[7]_1
netloc nolabel_line606_n_30 1 6 1 3280
load net nolabel_line606_n_31 -attr @rip(#000000) _SineWaveSampleData_reg[0]_1[3] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_2[3] -pin nolabel_line606 _SineWaveSampleData_reg[0]_1[3]
load net CLK100MHZ -port CLK100MHZ -pin CLK100MHZ_IBUF_inst I
netloc CLK100MHZ 1 0 1 NJ
load net nolabel_line606_n_32 -attr @rip(#000000) _SineWaveSampleData_reg[0]_1[2] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_2[2] -pin nolabel_line606 _SineWaveSampleData_reg[0]_1[2]
load net nolabel_line606_n_33 -attr @rip(#000000) _SineWaveSampleData_reg[0]_1[1] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_2[1] -pin nolabel_line606 _SineWaveSampleData_reg[0]_1[1]
load net LED[1] -attr @rip(#000000) 1 -port LED[1] -pin LED_OBUF[1]_inst O
load net _SineWaveSampleData[6] -attr @rip(#000000) Q[6] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[6] -pin nolabel_line606 Q[6]
load net nolabel_line606_n_34 -attr @rip(#000000) _SineWaveSampleData_reg[0]_1[0] -pin nolabel_line578 Sum2_inferred__0/i___55_carry_2[0] -pin nolabel_line606 _SineWaveSampleData_reg[0]_1[0]
load net M_LRSEL -port M_LRSEL -pin M_LRSEL_OBUF_inst O
netloc M_LRSEL 1 8 1 NJ
load net nolabel_line606_n_35 -attr @rip(#000000) _SineWaveSampleData_reg[2]_2[1] -pin nolabel_line578 i___15_carry_i_4__0_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[2]_2[1]
load net nolabel_line606_n_36 -attr @rip(#000000) _SineWaveSampleData_reg[2]_2[0] -pin nolabel_line578 i___15_carry_i_4__0_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[2]_2[0]
load net nolabel_line606_n_37 -attr @rip(#000000) _SineWaveSampleData_reg[2]_3[1] -pin nolabel_line578 i___55_carry__0_i_11_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[2]_3[1]
load net nolabel_line606_n_38 -attr @rip(#000000) _SineWaveSampleData_reg[2]_3[0] -pin nolabel_line578 i___55_carry__0_i_11_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[2]_3[0]
load net nolabel_line606_n_39 -attr @rip(#000000) _SineWaveSampleData_reg[3]_1[3] -pin nolabel_line578 i___55_carry__0_i_8_0[3] -pin nolabel_line606 _SineWaveSampleData_reg[3]_1[3]
load net LED_OBUF[15] -pin LED_OBUF[15]_inst I -pin LED_OBUF[15]_inst_i_1 O
netloc LED_OBUF[15] 1 7 1 N
load net nolabel_line606_n_20 -attr @rip(#000000) _SineWaveSampleData_reg[3]_0[3] -pin nolabel_line578 Sum2__55_carry__0_i_8_0[3] -pin nolabel_line606 _SineWaveSampleData_reg[3]_0[3]
load net LED_OBUF[0] -attr @rip(#000000) _FourierResult_reg[7]_0[0] -pin LED_OBUF[0]_inst I -pin nolabel_line578 _FourierResult_reg[7]_0[0]
load net nolabel_line606_n_21 -attr @rip(#000000) _SineWaveSampleData_reg[3]_0[2] -pin nolabel_line578 Sum2__55_carry__0_i_8_0[2] -pin nolabel_line606 _SineWaveSampleData_reg[3]_0[2]
load net nolabel_line606_n_22 -attr @rip(#000000) _SineWaveSampleData_reg[3]_0[1] -pin nolabel_line578 Sum2__55_carry__0_i_8_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[3]_0[1]
load net _SineWaveSampleData[5] -attr @rip(#000000) Q[5] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[5] -pin nolabel_line606 Q[5]
load net nolabel_line606_n_23 -attr @rip(#000000) _SineWaveSampleData_reg[3]_0[0] -pin nolabel_line578 Sum2__55_carry__0_i_8_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[3]_0[0]
load net nolabel_line606_n_24 -attr @rip(#000000) _SineWaveSampleData_reg[5]_0[2] -pin nolabel_line578 i___15_carry_i_7[2] -pin nolabel_line606 _SineWaveSampleData_reg[5]_0[2]
load net nolabel_line606_n_25 -attr @rip(#000000) _SineWaveSampleData_reg[5]_0[1] -pin nolabel_line578 i___15_carry_i_7[1] -pin nolabel_line606 _SineWaveSampleData_reg[5]_0[1]
load net nolabel_line578_n_10 -attr @rip(#000000) _SineWaveSampleData_reg[5]_0[1] -pin nolabel_line578 _SineWaveSampleData_reg[5]_0[1] -pin nolabel_line606 Sum2_inferred__1/i___15_carry__0[1]
load net nolabel_line606_n_26 -attr @rip(#000000) _SineWaveSampleData_reg[5]_0[0] -pin nolabel_line578 i___15_carry_i_7[0] -pin nolabel_line606 _SineWaveSampleData_reg[5]_0[0]
load net nolabel_line578_n_11 -attr @rip(#000000) _SineWaveSampleData_reg[5]_0[0] -pin nolabel_line578 _SineWaveSampleData_reg[5]_0[0] -pin nolabel_line606 Sum2_inferred__1/i___15_carry__0[0]
load net nolabel_line606_n_27 -attr @rip(#000000) _SineWaveSampleData_reg[5]_1[1] -pin nolabel_line578 Sum2__55_carry__1_i_7_0[1] -pin nolabel_line606 _SineWaveSampleData_reg[5]_1[1]
load net nolabel_line578_n_12 -attr @rip(#000000) _SineWaveSampleData_reg[3][0] -pin nolabel_line578 _SineWaveSampleData_reg[3][0] -pin nolabel_line606 Sum2_inferred__1/i___15_carry_0[0]
netloc nolabel_line578_n_12 1 5 3 2270 210 NJ 210 5520
load net nolabel_line606_n_28 -attr @rip(#000000) _SineWaveSampleData_reg[5]_1[0] -pin nolabel_line578 Sum2__55_carry__1_i_7_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[5]_1[0]
load net nolabel_line578_n_13 -attr @rip(#000000) _SineWaveSampleData_reg[2][0] -pin nolabel_line578 _SineWaveSampleData_reg[2][0] -pin nolabel_line606 Sum2_inferred__2/i___15_carry[0]
netloc nolabel_line578_n_13 1 5 3 2530 1730 NJ 1730 5040
load net nolabel_line606_n_29 -attr @rip(#000000) _SineWaveSampleData_reg[7]_0[0] -pin nolabel_line578 Sum[0]_i_12_0[0] -pin nolabel_line606 _SineWaveSampleData_reg[7]_0[0]
netloc nolabel_line606_n_29 1 6 1 3300
load net RECORD_DONE -pin nolabel_line568 RECORD_DONE -pin nolabel_line578 RECORD_DONE
netloc RECORD_DONE 1 5 2 NJ 2090 3940
load net LED_OBUF[14] -pin LED_OBUF[14]_inst I -pin LED_OBUF[14]_inst_i_1 O
netloc LED_OBUF[14] 1 7 1 N
load net nolabel_line578_n_14 -attr @rip(#000000) _SineWaveSampleData_reg[2]_0[0] -pin nolabel_line578 _SineWaveSampleData_reg[2]_0[0] -pin nolabel_line606 Sum2_inferred__2/i___15_carry_0[0]
netloc nolabel_line578_n_14 1 5 3 2570 1770 NJ 1770 5100
load net nolabel_line578_n_15 -attr @rip(#000000) _SineWaveSampleData_reg[5]_1[0] -pin nolabel_line578 _SineWaveSampleData_reg[5]_1[0] -pin nolabel_line606 i___15_carry_i_5__0[0]
netloc nolabel_line578_n_15 1 5 3 2630 1830 NJ 1830 5020
load net nolabel_line578_n_16 -attr @rip(#000000) _SineWaveSampleData_reg[5]_2[1] -pin nolabel_line578 _SineWaveSampleData_reg[5]_2[1] -pin nolabel_line606 Sum2_inferred__2/i___15_carry__0[1]
load net nolabel_line578_n_17 -attr @rip(#000000) _SineWaveSampleData_reg[5]_2[0] -pin nolabel_line578 _SineWaveSampleData_reg[5]_2[0] -pin nolabel_line606 Sum2_inferred__2/i___15_carry__0[0]
load net nolabel_line578_n_18 -attr @rip(#000000) _SineWaveSampleData_reg[3]_0[0] -pin nolabel_line578 _SineWaveSampleData_reg[3]_0[0] -pin nolabel_line606 Sum2_inferred__2/i___15_carry_2[0]
netloc nolabel_line578_n_18 1 5 3 2590 1790 NJ 1790 5080
load net nolabel_line578_n_19 -pin FSM_sequential_FSMState_reg[0] D -pin nolabel_line578 _PROCESS_DONE_reg_0
netloc nolabel_line578_n_19 1 3 5 860 2750 NJ 2750 NJ 2750 NJ 2750 5560
load net CLK100MHZ_IBUF -pin CLK100MHZ_IBUF_BUFG_inst I -pin CLK100MHZ_IBUF_inst O
netloc CLK100MHZ_IBUF 1 1 1 NJ
load net _SineWaveSampleData[4] -attr @rip(#000000) Q[4] -pin nolabel_line578 Sum2_inferred__0/i___55_carry__2_0[4] -pin nolabel_line606 Q[4]
load netBundle @nolabel_line578_n_62 8 nolabel_line578_n_62 nolabel_line578_n_63 nolabel_line578_n_64 nolabel_line578_n_65 nolabel_line578_n_66 nolabel_line578_n_67 nolabel_line578_n_68 nolabel_line578_n_69 -autobundled
netbloc @nolabel_line578_n_62 1 5 3 2030 2490 NJ 2490 5140
load netBundle @nolabel_line606_n_24 3 nolabel_line606_n_24 nolabel_line606_n_25 nolabel_line606_n_26 -autobundled
netbloc @nolabel_line606_n_24 1 6 1 N
load netBundle @nolabel_line578_n_10 2 nolabel_line578_n_10 nolabel_line578_n_11 -autobundled
netbloc @nolabel_line578_n_10 1 5 3 2470 1670 NJ 1670 4900
load netBundle @nolabel_line606_n_96 2 nolabel_line606_n_96 nolabel_line606_n_97 -autobundled
netbloc @nolabel_line606_n_96 1 6 1 3360
load netBundle @nolabel_line606_n_43 3 nolabel_line606_n_43 nolabel_line606_n_44 nolabel_line606_n_45 -autobundled
netbloc @nolabel_line606_n_43 1 6 1 3540
load netBundle @nolabel_line606_n_12 4 nolabel_line606_n_12 nolabel_line606_n_13 nolabel_line606_n_14 nolabel_line606_n_15 -autobundled
netbloc @nolabel_line606_n_12 1 6 1 3420
load netBundle @nolabel_line606_n_37 2 nolabel_line606_n_37 nolabel_line606_n_38 -autobundled
netbloc @nolabel_line606_n_37 1 6 1 3700
load netBundle @LED 16 LED[15] LED[14] LED[13] LED[12] LED[11] LED[10] LED[9] LED[8] LED[7] LED[6] LED[5] LED[4] LED[3] LED[2] LED[1] LED[0] -autobundled
netbloc @LED 1 8 1 5980
load netBundle @nolabel_line606_n_98 2 nolabel_line606_n_98 nolabel_line606_n_99 -autobundled
netbloc @nolabel_line606_n_98 1 6 1 3680
load netBundle @nolabel_line606_n_74 4 nolabel_line606_n_74 nolabel_line606_n_75 nolabel_line606_n_76 nolabel_line606_n_77 -autobundled
netbloc @nolabel_line606_n_74 1 6 1 3480
load netBundle @nolabel_line606_n_68 4 nolabel_line606_n_68 nolabel_line606_n_69 nolabel_line606_n_70 nolabel_line606_n_71 -autobundled
netbloc @nolabel_line606_n_68 1 6 1 3880
load netBundle @nolabel_line606_n_50 2 nolabel_line606_n_50 nolabel_line606_n_51 -autobundled
netbloc @nolabel_line606_n_50 1 6 1 3460
load netBundle @nolabel_line606_n_39 4 nolabel_line606_n_39 nolabel_line606_n_40 nolabel_line606_n_41 nolabel_line606_n_42 -autobundled
netbloc @nolabel_line606_n_39 1 6 1 3580
load netBundle @nolabel_line606_n_27 2 nolabel_line606_n_27 nolabel_line606_n_28 -autobundled
netbloc @nolabel_line606_n_27 1 6 1 3500
load netBundle @nolabel_line606_n_0 2 nolabel_line606_n_0 nolabel_line606_n_1 -autobundled
netbloc @nolabel_line606_n_0 1 6 1 3560
load netBundle @nolabel_line606_n_52 2 nolabel_line606_n_52 nolabel_line606_n_53 -autobundled
netbloc @nolabel_line606_n_52 1 6 1 3240
load netBundle @nolabel_line578_n_27 5 nolabel_line578_n_27 nolabel_line578_n_28 nolabel_line578_n_29 nolabel_line578_n_30 nolabel_line578_n_31 -autobundled
netbloc @nolabel_line578_n_27 1 5 3 2190 90 NJ 90 5380
load netBundle @nolabel_line606_n_46 2 nolabel_line606_n_46 nolabel_line606_n_47 -autobundled
netbloc @nolabel_line606_n_46 1 6 1 3320
load netBundle @nolabel_line606_n_16 2 nolabel_line606_n_16 nolabel_line606_n_17 -autobundled
netbloc @nolabel_line606_n_16 1 6 1 3400
load netBundle @FSMState 2 FSMState[1] FSMState[0] -autobundled
netbloc @FSMState 1 4 3 1270 3060 NJ 3060 4020
load netBundle @LED_OBUF 8 LED_OBUF[7] LED_OBUF[6] LED_OBUF[5] LED_OBUF[4] LED_OBUF[3] LED_OBUF[2] LED_OBUF[1] LED_OBUF[0] -autobundled
netbloc @LED_OBUF 1 7 1 5720
load netBundle @nolabel_line578_n_16 2 nolabel_line578_n_16 nolabel_line578_n_17 -autobundled
netbloc @nolabel_line578_n_16 1 5 3 2550 1750 NJ 1750 4920
load netBundle @nolabel_line606_n_54 2 nolabel_line606_n_54 nolabel_line606_n_55 -autobundled
netbloc @nolabel_line606_n_54 1 6 1 3240
load netBundle @nolabel_line606_n_90 2 nolabel_line606_n_90 nolabel_line606_n_91 -autobundled
netbloc @nolabel_line606_n_90 1 6 1 3360
load netBundle @nolabel_line606_n_84 2 nolabel_line606_n_84 nolabel_line606_n_85 -autobundled
netbloc @nolabel_line606_n_84 1 6 1 3720
load netBundle @nolabel_line606_n_79 4 nolabel_line606_n_79 nolabel_line606_n_80 nolabel_line606_n_81 nolabel_line606_n_82 -autobundled
netbloc @nolabel_line606_n_79 1 6 1 3460
load netBundle @nolabel_line606_n_60 2 nolabel_line606_n_60 nolabel_line606_n_61 -autobundled
netbloc @nolabel_line606_n_60 1 6 1 3660
load netBundle @_SineWaveSampleData 8 _SineWaveSampleData[7] _SineWaveSampleData[6] _SineWaveSampleData[5] _SineWaveSampleData[4] _SineWaveSampleData[3] _SineWaveSampleData[2] _SineWaveSampleData[1] _SineWaveSampleData[0] -autobundled
netbloc @_SineWaveSampleData 1 6 1 3540
load netBundle @nolabel_line606_n_18 2 nolabel_line606_n_18 nolabel_line606_n_19 -autobundled
netbloc @nolabel_line606_n_18 1 6 1 3840
load netBundle @nolabel_line606_n_31 4 nolabel_line606_n_31 nolabel_line606_n_32 nolabel_line606_n_33 nolabel_line606_n_34 -autobundled
netbloc @nolabel_line606_n_31 1 6 1 3600
load netBundle @nolabel_line606_n_56 2 nolabel_line606_n_56 nolabel_line606_n_57 -autobundled
netbloc @nolabel_line606_n_56 1 6 1 3960
load netBundle @nolabel_line606_n_20 4 nolabel_line606_n_20 nolabel_line606_n_21 nolabel_line606_n_22 nolabel_line606_n_23 -autobundled
netbloc @nolabel_line606_n_20 1 6 1 3780
load netBundle @nolabel_line606_n_86 3 nolabel_line606_n_86 nolabel_line606_n_87 nolabel_line606_n_88 -autobundled
netbloc @nolabel_line606_n_86 1 6 1 3360
load netBundle @nolabel_line606_n_92 3 nolabel_line606_n_92 nolabel_line606_n_93 nolabel_line606_n_94 -autobundled
netbloc @nolabel_line606_n_92 1 6 1 3620
load netBundle @nolabel_line606_n_63 4 nolabel_line606_n_63 nolabel_line606_n_64 nolabel_line606_n_65 nolabel_line606_n_66 -autobundled
netbloc @nolabel_line606_n_63 1 6 1 3820
load netBundle @nolabel_line606_n_58 2 nolabel_line606_n_58 nolabel_line606_n_59 -autobundled
netbloc @nolabel_line606_n_58 1 6 1 3760
load netBundle @nolabel_line606_n_10 2 nolabel_line606_n_10 nolabel_line606_n_11 -autobundled
netbloc @nolabel_line606_n_10 1 6 1 3440
load netBundle @nolabel_line578_n_22 5 nolabel_line578_n_22 nolabel_line578_n_23 nolabel_line578_n_24 nolabel_line578_n_25 nolabel_line578_n_26 -autobundled
netbloc @nolabel_line578_n_22 1 5 3 2630 230 NJ 230 5480
load netBundle @nolabel_line606_n_35 2 nolabel_line606_n_35 nolabel_line606_n_36 -autobundled
netbloc @nolabel_line606_n_35 1 6 1 3520
levelinfo -pg 1 0 40 250 670 1020 1600 2880 4450 5800 6000 -top 0 -bot 3630
show
fullfit
#
# initialize ictrl to current module Frq_Analyzer work:Frq_Analyzer:NOFILE
ictrl init topinfo |
