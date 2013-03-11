// Verilog netlist produced by program LSE :  version Diamond (64-bit) 2.1.0.103
// Netlist written on Sun Mar 10 19:51:37 2013

//
// Verilog Description of module Top
//

module Top (RESET, H_SYNC, V_SYNC, RED, BLUE, GREEN) /* synthesis syn_module_defined=1 */ ;   // c:/users/fox/programming/stm32/src/verilog/top.v(9[8:11])
    input RESET;   // c:/users/fox/programming/stm32/src/verilog/top.v(10[14:19])
    output H_SYNC;   // c:/users/fox/programming/stm32/src/verilog/top.v(11[14:20])
    output V_SYNC;   // c:/users/fox/programming/stm32/src/verilog/top.v(12[14:20])
    output RED;   // c:/users/fox/programming/stm32/src/verilog/top.v(13[13:16])
    output BLUE;   // c:/users/fox/programming/stm32/src/verilog/top.v(13[18:22])
    output GREEN;   // c:/users/fox/programming/stm32/src/verilog/top.v(13[24:29])
    
    wire GND_net;   // c:/users/fox/programming/stm32/src/verilog/top.v(13[24:29])
    wire VCC_net;   // c:/users/fox/programming/stm32/src/verilog/top.v(13[13:16])
    wire RESET_c;   // c:/users/fox/programming/stm32/src/verilog/top.v(10[14:19])
    wire H_SYNC_c;   // c:/users/fox/programming/stm32/src/verilog/top.v(11[14:20])
    wire V_SYNC_c;   // c:/users/fox/programming/stm32/src/verilog/top.v(12[14:20])
    wire clk;   // c:/users/fox/programming/stm32/src/verilog/top.v(17[19:22])
    
    VHI i2 (.Z(VCC_net));
    OSCC oscc_0 (.OSC(clk)) /* synthesis syn_instantiated=1 */ ;
    OB RED_pad (.I(VCC_net), .O(RED));
    OB V_SYNC_pad (.I(V_SYNC_c), .O(V_SYNC));
    CtrlLines CONTORLLINES (.GND_net(GND_net), .clk(clk), .V_SYNC_c(V_SYNC_c), 
            .H_SYNC_c(H_SYNC_c)) /* synthesis syn_module_defined=1 */ ;
    VLO i1 (.Z(GND_net));
    OB H_SYNC_pad (.I(H_SYNC_c), .O(H_SYNC));
    TSALL TSALL_INST (.TSALL(GND_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    GSR GSR_INST (.GSR(VCC_net));
    OB BLUE_pad (.I(GND_net), .O(BLUE));
    OB GREEN_pad (.I(GND_net), .O(GREEN));
    IB RESET_pad (.I(RESET), .O(RESET_c));
    
endmodule

//
// Verilog Description of module CtrlLines
//

module CtrlLines (GND_net, clk, V_SYNC_c, H_SYNC_c) /* synthesis syn_module_defined=1 */ ;
    input GND_net;
    input clk;
    output V_SYNC_c;
    output H_SYNC_c;
    
    wire [10:0]h_counter;   // c:/users/fox/programming/stm32/src/verilog/ctrl_lines.v(23[13:22])
    wire [10:0]v_counter;   // c:/users/fox/programming/stm32/src/verilog/ctrl_lines.v(23[24:33])
    wire [10:0]n48;
    
    wire n339;
    wire [10:0]n39;
    
    wire n340, n382, n384, n8, n156, n38, n362;
    wire [0:0]n103;
    
    wire n157;
    wire [10:0]n39_adj_13;
    
    wire n385, n345, n202, n17, n8_adj_1, n7, n177, n344, n343, 
        n342, n10, n14, n341, n338, n388, n389, n337, n336;
    
    INV inv_13_i1 (.A(h_counter[0]), .Z(n48[0]));
    CCU2 h_counter_75_add_4_10 (.A0(h_counter[8]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(h_counter[9]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n339), .COUT1(n340), .S0(n39[8]), .S1(n39[9]));
    defparam h_counter_75_add_4_10.INIT0 = 16'hfaaa;
    defparam h_counter_75_add_4_10.INIT1 = 16'hfaaa;
    defparam h_counter_75_add_4_10.INJECT1_0 = "NO";
    defparam h_counter_75_add_4_10.INJECT1_1 = "NO";
    ORCALUT4 i1_2_lut (.A(h_counter[7]), .B(n382), .Z(n384)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i1_2_lut.init = 16'hdddd;
    ORCALUT4 i3_3_lut (.A(n382), .B(h_counter[7]), .C(h_counter[0]), .Z(n8)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i3_3_lut.init = 16'hfefe;
    FD1S3IX h_counter_75__i0 (.D(n39[0]), .CK(clk), .CD(n156), .Q(h_counter[0]));
    defparam h_counter_75__i0.GSR = "DISABLED";
    ORCALUT4 i38_2_lut (.A(h_counter[5]), .B(h_counter[8]), .Z(n38)) /* synthesis lut_function=(A (B)) */ ;
    defparam i38_2_lut.init = 16'h8888;
    FD1P3IX V_SYNC_28 (.D(n103[0]), .SP(v_counter[1]), .CD(n362), .CK(n48[0]), 
            .Q(V_SYNC_c));
    defparam V_SYNC_28.GSR = "DISABLED";
    FD1S3IX v_counter_76__i1 (.D(n39_adj_13[1]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[1]));
    defparam v_counter_76__i1.GSR = "DISABLED";
    ORCALUT4 i339_3_lut_4_lut (.A(v_counter[4]), .B(v_counter[9]), .C(n385), 
            .D(v_counter[1]), .Z(n157)) /* synthesis lut_function=(!(((C+(D))+!B)+!A)) */ ;
    defparam i339_3_lut_4_lut.init = 16'h0008;
    CCU2 v_counter_76_add_4_12 (.A0(v_counter[10]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
         .CIN(n345), .S0(n39_adj_13[10]));
    defparam v_counter_76_add_4_12.INIT0 = 16'hfaaa;
    defparam v_counter_76_add_4_12.INIT1 = 16'h0000;
    defparam v_counter_76_add_4_12.INJECT1_0 = "NO";
    defparam v_counter_76_add_4_12.INJECT1_1 = "NO";
    FD1P3IX H_SYNC_26 (.D(h_counter[0]), .SP(h_counter[4]), .CD(n202), 
            .CK(clk), .Q(H_SYNC_c));
    defparam H_SYNC_26.GSR = "DISABLED";
    ORCALUT4 i3_3_lut_adj_1 (.A(h_counter[5]), .B(h_counter[10]), .C(n17), 
            .Z(n8_adj_1)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i3_3_lut_adj_1.init = 16'hfefe;
    ORCALUT4 i2_2_lut (.A(h_counter[8]), .B(h_counter[6]), .Z(n7)) /* synthesis lut_function=(A+!(B)) */ ;
    defparam i2_2_lut.init = 16'hbbbb;
    ORCALUT4 i149_4_lut (.A(n177), .B(n7), .C(h_counter[4]), .D(n8_adj_1), 
            .Z(n202)) /* synthesis lut_function=(A (B+((D)+!C))+!A (B (C)+!B (C (D)))) */ ;
    defparam i149_4_lut.init = 16'hfaca;
    CCU2 v_counter_76_add_4_10 (.A0(v_counter[8]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(v_counter[9]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n344), .COUT1(n345), .S0(n39_adj_13[8]), 
         .S1(n39_adj_13[9]));
    defparam v_counter_76_add_4_10.INIT0 = 16'hfaaa;
    defparam v_counter_76_add_4_10.INIT1 = 16'hfaaa;
    defparam v_counter_76_add_4_10.INJECT1_0 = "NO";
    defparam v_counter_76_add_4_10.INJECT1_1 = "NO";
    INV i50 (.A(v_counter[9]), .Z(n103[0]));
    CCU2 v_counter_76_add_4_8 (.A0(v_counter[6]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(v_counter[7]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n343), .COUT1(n344), .S0(n39_adj_13[6]), 
         .S1(n39_adj_13[7]));
    defparam v_counter_76_add_4_8.INIT0 = 16'hfaaa;
    defparam v_counter_76_add_4_8.INIT1 = 16'hfaaa;
    defparam v_counter_76_add_4_8.INJECT1_0 = "NO";
    defparam v_counter_76_add_4_8.INJECT1_1 = "NO";
    CCU2 v_counter_76_add_4_6 (.A0(v_counter[4]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(v_counter[5]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n342), .COUT1(n343), .S0(n39_adj_13[4]), 
         .S1(n39_adj_13[5]));
    defparam v_counter_76_add_4_6.INIT0 = 16'hfaaa;
    defparam v_counter_76_add_4_6.INIT1 = 16'hfaaa;
    defparam v_counter_76_add_4_6.INJECT1_0 = "NO";
    defparam v_counter_76_add_4_6.INJECT1_1 = "NO";
    ORCALUT4 i2_2_lut_adj_2 (.A(v_counter[2]), .B(v_counter[10]), .Z(n10)) /* synthesis lut_function=(A+(B)) */ ;
    defparam i2_2_lut_adj_2.init = 16'heeee;
    ORCALUT4 i6_4_lut (.A(v_counter[8]), .B(v_counter[5]), .C(v_counter[3]), 
            .D(v_counter[0]), .Z(n14)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i6_4_lut.init = 16'hfffe;
    ORCALUT4 i1_4_lut (.A(h_counter[6]), .B(n38), .C(n8), .D(h_counter[10]), 
            .Z(n177)) /* synthesis lut_function=(A+((C+(D))+!B)) */ ;
    defparam i1_4_lut.init = 16'hfffb;
    ORCALUT4 i7_4_lut (.A(v_counter[7]), .B(n14), .C(n10), .D(v_counter[6]), 
            .Z(n385)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i7_4_lut.init = 16'hfffe;
    ORCALUT4 i1_4_lut_4_lut (.A(v_counter[4]), .B(v_counter[9]), .C(v_counter[1]), 
            .D(n385), .Z(n362)) /* synthesis lut_function=(A ((C+(D))+!B)+!A ((D)+!C)) */ ;
    defparam i1_4_lut_4_lut.init = 16'hffa7;
    ORCALUT4 i337_2_lut (.A(h_counter[4]), .B(n177), .Z(n156)) /* synthesis lut_function=(!(A+(B))) */ ;
    defparam i337_2_lut.init = 16'h1111;
    CCU2 v_counter_76_add_4_4 (.A0(v_counter[2]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(v_counter[3]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n341), .COUT1(n342), .S0(n39_adj_13[2]), 
         .S1(n39_adj_13[3]));
    defparam v_counter_76_add_4_4.INIT0 = 16'hfaaa;
    defparam v_counter_76_add_4_4.INIT1 = 16'hfaaa;
    defparam v_counter_76_add_4_4.INJECT1_0 = "NO";
    defparam v_counter_76_add_4_4.INJECT1_1 = "NO";
    CCU2 h_counter_75_add_4_8 (.A0(h_counter[6]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(h_counter[7]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n338), .COUT1(n339), .S0(n39[6]), .S1(n39[7]));
    defparam h_counter_75_add_4_8.INIT0 = 16'hfaaa;
    defparam h_counter_75_add_4_8.INIT1 = 16'hfaaa;
    defparam h_counter_75_add_4_8.INJECT1_0 = "NO";
    defparam h_counter_75_add_4_8.INJECT1_1 = "NO";
    CCU2 v_counter_76_add_4_2 (.A0(v_counter[0]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(v_counter[1]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(GND_net), .COUT1(n341), .S0(n39_adj_13[0]), 
         .S1(n39_adj_13[1]));
    defparam v_counter_76_add_4_2.INIT0 = 16'h0555;
    defparam v_counter_76_add_4_2.INIT1 = 16'hfaaa;
    defparam v_counter_76_add_4_2.INJECT1_0 = "NO";
    defparam v_counter_76_add_4_2.INJECT1_1 = "NO";
    CCU2 h_counter_75_add_4_12 (.A0(h_counter[10]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
         .CIN(n340), .S0(n39[10]));
    defparam h_counter_75_add_4_12.INIT0 = 16'hfaaa;
    defparam h_counter_75_add_4_12.INIT1 = 16'h0000;
    defparam h_counter_75_add_4_12.INJECT1_0 = "NO";
    defparam h_counter_75_add_4_12.INJECT1_1 = "NO";
    FD1S3IX v_counter_76__i0 (.D(n39_adj_13[0]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[0]));
    defparam v_counter_76__i0.GSR = "DISABLED";
    PFUMX i17 (.BLUT(n384), .ALUT(n388), .C0(h_counter[0]), .Z(n17));
    ORCALUT4 i3_4_lut (.A(h_counter[9]), .B(h_counter[2]), .C(h_counter[3]), 
            .D(h_counter[1]), .Z(n382)) /* synthesis lut_function=((B+(C+(D)))+!A) */ ;
    defparam i3_4_lut.init = 16'hfffd;
    ORCALUT4 i330_2_lut (.A(h_counter[1]), .B(h_counter[2]), .Z(n389)) /* synthesis lut_function=(A (B)) */ ;
    defparam i330_2_lut.init = 16'h8888;
    FD1S3IX h_counter_75__i10 (.D(n39[10]), .CK(clk), .CD(n156), .Q(h_counter[10]));
    defparam h_counter_75__i10.GSR = "DISABLED";
    FD1S3IX h_counter_75__i9 (.D(n39[9]), .CK(clk), .CD(n156), .Q(h_counter[9]));
    defparam h_counter_75__i9.GSR = "DISABLED";
    FD1S3IX h_counter_75__i8 (.D(n39[8]), .CK(clk), .CD(n156), .Q(h_counter[8]));
    defparam h_counter_75__i8.GSR = "DISABLED";
    FD1S3IX h_counter_75__i7 (.D(n39[7]), .CK(clk), .CD(n156), .Q(h_counter[7]));
    defparam h_counter_75__i7.GSR = "DISABLED";
    FD1S3IX h_counter_75__i6 (.D(n39[6]), .CK(clk), .CD(n156), .Q(h_counter[6]));
    defparam h_counter_75__i6.GSR = "DISABLED";
    FD1S3IX h_counter_75__i5 (.D(n39[5]), .CK(clk), .CD(n156), .Q(h_counter[5]));
    defparam h_counter_75__i5.GSR = "DISABLED";
    FD1S3IX h_counter_75__i4 (.D(n39[4]), .CK(clk), .CD(n156), .Q(h_counter[4]));
    defparam h_counter_75__i4.GSR = "DISABLED";
    FD1S3IX h_counter_75__i3 (.D(n39[3]), .CK(clk), .CD(n156), .Q(h_counter[3]));
    defparam h_counter_75__i3.GSR = "DISABLED";
    FD1S3IX h_counter_75__i2 (.D(n39[2]), .CK(clk), .CD(n156), .Q(h_counter[2]));
    defparam h_counter_75__i2.GSR = "DISABLED";
    FD1S3IX h_counter_75__i1 (.D(n39[1]), .CK(clk), .CD(n156), .Q(h_counter[1]));
    defparam h_counter_75__i1.GSR = "DISABLED";
    FD1S3IX v_counter_76__i10 (.D(n39_adj_13[10]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[10]));
    defparam v_counter_76__i10.GSR = "DISABLED";
    CCU2 h_counter_75_add_4_6 (.A0(h_counter[4]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(h_counter[5]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n337), .COUT1(n338), .S0(n39[4]), .S1(n39[5]));
    defparam h_counter_75_add_4_6.INIT0 = 16'hfaaa;
    defparam h_counter_75_add_4_6.INIT1 = 16'hfaaa;
    defparam h_counter_75_add_4_6.INJECT1_0 = "NO";
    defparam h_counter_75_add_4_6.INJECT1_1 = "NO";
    ORCALUT4 i2_4_lut (.A(h_counter[3]), .B(h_counter[9]), .C(n389), .D(h_counter[7]), 
            .Z(n388)) /* synthesis lut_function=((B+((D)+!C))+!A) */ ;
    defparam i2_4_lut.init = 16'hffdf;
    CCU2 h_counter_75_add_4_4 (.A0(h_counter[2]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(h_counter[3]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(n336), .COUT1(n337), .S0(n39[2]), .S1(n39[3]));
    defparam h_counter_75_add_4_4.INIT0 = 16'hfaaa;
    defparam h_counter_75_add_4_4.INIT1 = 16'hfaaa;
    defparam h_counter_75_add_4_4.INJECT1_0 = "NO";
    defparam h_counter_75_add_4_4.INJECT1_1 = "NO";
    CCU2 h_counter_75_add_4_2 (.A0(h_counter[0]), .B0(GND_net), .C0(GND_net), 
         .D0(GND_net), .A1(h_counter[1]), .B1(GND_net), .C1(GND_net), 
         .D1(GND_net), .CIN(GND_net), .COUT1(n336), .S0(n39[0]), .S1(n39[1]));
    defparam h_counter_75_add_4_2.INIT0 = 16'h0555;
    defparam h_counter_75_add_4_2.INIT1 = 16'hfaaa;
    defparam h_counter_75_add_4_2.INJECT1_0 = "NO";
    defparam h_counter_75_add_4_2.INJECT1_1 = "NO";
    FD1S3IX v_counter_76__i9 (.D(n39_adj_13[9]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[9]));
    defparam v_counter_76__i9.GSR = "DISABLED";
    FD1S3IX v_counter_76__i8 (.D(n39_adj_13[8]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[8]));
    defparam v_counter_76__i8.GSR = "DISABLED";
    FD1S3IX v_counter_76__i7 (.D(n39_adj_13[7]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[7]));
    defparam v_counter_76__i7.GSR = "DISABLED";
    FD1S3IX v_counter_76__i6 (.D(n39_adj_13[6]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[6]));
    defparam v_counter_76__i6.GSR = "DISABLED";
    FD1S3IX v_counter_76__i5 (.D(n39_adj_13[5]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[5]));
    defparam v_counter_76__i5.GSR = "DISABLED";
    FD1S3IX v_counter_76__i4 (.D(n39_adj_13[4]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[4]));
    defparam v_counter_76__i4.GSR = "DISABLED";
    FD1S3IX v_counter_76__i3 (.D(n39_adj_13[3]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[3]));
    defparam v_counter_76__i3.GSR = "DISABLED";
    FD1S3IX v_counter_76__i2 (.D(n39_adj_13[2]), .CK(n48[0]), .CD(n157), 
            .Q(v_counter[2]));
    defparam v_counter_76__i2.GSR = "DISABLED";
    
endmodule

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//


//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

