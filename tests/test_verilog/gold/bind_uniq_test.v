module coreir_wrap (
    input in,
    output out
);
  assign out = in;
endmodule

module coreir_undriven #(
    parameter width = 1
) (
    output [width-1:0] out
);

endmodule

module coreir_term #(
    parameter width = 1
) (
    input [width-1:0] in
);

endmodule

module corebit_undriven (
    output out
);

endmodule

            module orr_5 (input [4:0] I, output O);
            assign O = |(I);
            endmodule
            module orr_4 (input [3:0] I, output O);
            assign O = |(I);
            endmodule
module corebit_term (
    input in
);

endmodule

            module logical_and (input I0, input I1, output O);
            assign O = I0 && I1;
            endmodule
            module andr_5 (input [4:0] I, output O);
            assign O = &(I);
            endmodule
            module andr_4 (input [3:0] I, output O);
            assign O = &(I);
            endmodule
module SomeCircuit_unq1 (
    input [4:0] I
);
coreir_term #(
    .width(5)
) term_inst0 (
    .in(I)
);
endmodule

module SomeCircuit (
    input [3:0] I
);
coreir_term #(
    .width(4)
) term_inst0 (
    .in(I)
);
endmodule

module RTL_unq1 (
    input CLK,
    input handshake_arr_0_ready,
    output handshake_arr_0_valid,
    input handshake_arr_1_ready,
    output handshake_arr_1_valid,
    input handshake_arr_2_ready,
    output handshake_arr_2_valid,
    input handshake_ready,
    output handshake_valid,
    input [4:0] in1,
    input [4:0] in2,
    output out
);
wire andr_5_inst0_O;
wire coreir_wrapInClock_inst0_out;
wire [4:0] magma_Bits_5_xor_inst0_out;
wire orr_5_inst0_O;
SomeCircuit_unq1 SomeCircuit_inst0 (
    .I(magma_Bits_5_xor_inst0_out)
);
andr_5 andr_5_inst0 (
    .I(in1),
    .O(andr_5_inst0_O)
);
corebit_term corebit_term_inst0 (
    .in(orr_5_inst0_O)
);
corebit_term corebit_term_inst1 (
    .in(andr_5_inst0_O)
);
corebit_term corebit_term_inst2 (
    .in(coreir_wrapInClock_inst0_out)
);
coreir_wrap coreir_wrapInClock_inst0 (
    .in(CLK),
    .out(coreir_wrapInClock_inst0_out)
);
logical_and logical_and_inst0 (
    .I0(orr_5_inst0_O),
    .I1(andr_5_inst0_O),
    .O(out)
);
assign magma_Bits_5_xor_inst0_out = in1 ^ in2;
orr_5 orr_5_inst0 (
    .I(in1),
    .O(orr_5_inst0_O)
);
coreir_term #(
    .width(5)
) term_inst0 (
    .in(magma_Bits_5_xor_inst0_out)
);
assign handshake_arr_0_valid = handshake_arr_2_ready;
assign handshake_arr_1_valid = handshake_arr_1_ready;
assign handshake_arr_2_valid = handshake_arr_0_ready;
assign handshake_valid = handshake_ready;
endmodule

module RTL (
    input CLK,
    input handshake_arr_0_ready,
    output handshake_arr_0_valid,
    input handshake_arr_1_ready,
    output handshake_arr_1_valid,
    input handshake_arr_2_ready,
    output handshake_arr_2_valid,
    input handshake_ready,
    output handshake_valid,
    input [3:0] in1,
    input [3:0] in2,
    output out
);
wire andr_4_inst0_O;
wire coreir_wrapInClock_inst0_out;
wire [3:0] magma_Bits_4_xor_inst0_out;
wire orr_4_inst0_O;
SomeCircuit SomeCircuit_inst0 (
    .I(magma_Bits_4_xor_inst0_out)
);
andr_4 andr_4_inst0 (
    .I(in1),
    .O(andr_4_inst0_O)
);
corebit_term corebit_term_inst0 (
    .in(orr_4_inst0_O)
);
corebit_term corebit_term_inst1 (
    .in(andr_4_inst0_O)
);
corebit_term corebit_term_inst2 (
    .in(coreir_wrapInClock_inst0_out)
);
coreir_wrap coreir_wrapInClock_inst0 (
    .in(CLK),
    .out(coreir_wrapInClock_inst0_out)
);
logical_and logical_and_inst0 (
    .I0(orr_4_inst0_O),
    .I1(andr_4_inst0_O),
    .O(out)
);
assign magma_Bits_4_xor_inst0_out = in1 ^ in2;
orr_4 orr_4_inst0 (
    .I(in1),
    .O(orr_4_inst0_O)
);
coreir_term #(
    .width(4)
) term_inst0 (
    .in(magma_Bits_4_xor_inst0_out)
);
assign handshake_arr_0_valid = handshake_arr_2_ready;
assign handshake_arr_1_valid = handshake_arr_1_ready;
assign handshake_arr_2_valid = handshake_arr_0_ready;
assign handshake_valid = handshake_ready;
endmodule

module Main (
    input CLK
);
wire RTL_inst0_handshake_arr_0_valid;
wire RTL_inst0_handshake_arr_1_valid;
wire RTL_inst0_handshake_arr_2_valid;
wire RTL_inst0_handshake_valid;
wire RTL_inst0_out;
wire RTL_inst1_handshake_arr_0_valid;
wire RTL_inst1_handshake_arr_1_valid;
wire RTL_inst1_handshake_arr_2_valid;
wire RTL_inst1_handshake_valid;
wire RTL_inst1_out;
wire corebit_undriven_inst0_out;
wire corebit_undriven_inst1_out;
wire corebit_undriven_inst2_out;
wire corebit_undriven_inst3_out;
wire corebit_undriven_inst4_out;
wire corebit_undriven_inst5_out;
wire corebit_undriven_inst6_out;
wire corebit_undriven_inst7_out;
wire corebit_undriven_inst8_out;
wire corebit_undriven_inst9_out;
wire coreir_wrapInClock_inst0_out;
wire coreir_wrapOutClock_inst0_out;
wire coreir_wrapOutClock_inst1_out;
wire [3:0] undriven_inst0_out;
wire [3:0] undriven_inst1_out;
wire [4:0] undriven_inst2_out;
wire [4:0] undriven_inst3_out;
RTL RTL_inst0 (
    .CLK(coreir_wrapOutClock_inst0_out),
    .handshake_arr_0_ready(corebit_undriven_inst2_out),
    .handshake_arr_0_valid(RTL_inst0_handshake_arr_0_valid),
    .handshake_arr_1_ready(corebit_undriven_inst3_out),
    .handshake_arr_1_valid(RTL_inst0_handshake_arr_1_valid),
    .handshake_arr_2_ready(corebit_undriven_inst4_out),
    .handshake_arr_2_valid(RTL_inst0_handshake_arr_2_valid),
    .handshake_ready(corebit_undriven_inst1_out),
    .handshake_valid(RTL_inst0_handshake_valid),
    .in1(undriven_inst0_out),
    .in2(undriven_inst1_out),
    .out(RTL_inst0_out)
);
RTL_unq1 RTL_inst1 (
    .CLK(coreir_wrapOutClock_inst1_out),
    .handshake_arr_0_ready(corebit_undriven_inst7_out),
    .handshake_arr_0_valid(RTL_inst1_handshake_arr_0_valid),
    .handshake_arr_1_ready(corebit_undriven_inst8_out),
    .handshake_arr_1_valid(RTL_inst1_handshake_arr_1_valid),
    .handshake_arr_2_ready(corebit_undriven_inst9_out),
    .handshake_arr_2_valid(RTL_inst1_handshake_arr_2_valid),
    .handshake_ready(corebit_undriven_inst6_out),
    .handshake_valid(RTL_inst1_handshake_valid),
    .in1(undriven_inst2_out),
    .in2(undriven_inst3_out),
    .out(RTL_inst1_out)
);
corebit_term corebit_term_inst0 (
    .in(coreir_wrapInClock_inst0_out)
);
corebit_term corebit_term_inst1 (
    .in(RTL_inst0_out)
);
corebit_term corebit_term_inst10 (
    .in(RTL_inst1_handshake_arr_2_valid)
);
corebit_term corebit_term_inst2 (
    .in(RTL_inst0_handshake_valid)
);
corebit_term corebit_term_inst3 (
    .in(RTL_inst0_handshake_arr_0_valid)
);
corebit_term corebit_term_inst4 (
    .in(RTL_inst0_handshake_arr_1_valid)
);
corebit_term corebit_term_inst5 (
    .in(RTL_inst0_handshake_arr_2_valid)
);
corebit_term corebit_term_inst6 (
    .in(RTL_inst1_out)
);
corebit_term corebit_term_inst7 (
    .in(RTL_inst1_handshake_valid)
);
corebit_term corebit_term_inst8 (
    .in(RTL_inst1_handshake_arr_0_valid)
);
corebit_term corebit_term_inst9 (
    .in(RTL_inst1_handshake_arr_1_valid)
);
corebit_undriven corebit_undriven_inst0 (
    .out(corebit_undriven_inst0_out)
);
corebit_undriven corebit_undriven_inst1 (
    .out(corebit_undriven_inst1_out)
);
corebit_undriven corebit_undriven_inst2 (
    .out(corebit_undriven_inst2_out)
);
corebit_undriven corebit_undriven_inst3 (
    .out(corebit_undriven_inst3_out)
);
corebit_undriven corebit_undriven_inst4 (
    .out(corebit_undriven_inst4_out)
);
corebit_undriven corebit_undriven_inst5 (
    .out(corebit_undriven_inst5_out)
);
corebit_undriven corebit_undriven_inst6 (
    .out(corebit_undriven_inst6_out)
);
corebit_undriven corebit_undriven_inst7 (
    .out(corebit_undriven_inst7_out)
);
corebit_undriven corebit_undriven_inst8 (
    .out(corebit_undriven_inst8_out)
);
corebit_undriven corebit_undriven_inst9 (
    .out(corebit_undriven_inst9_out)
);
coreir_wrap coreir_wrapInClock_inst0 (
    .in(CLK),
    .out(coreir_wrapInClock_inst0_out)
);
coreir_wrap coreir_wrapOutClock_inst0 (
    .in(corebit_undriven_inst0_out),
    .out(coreir_wrapOutClock_inst0_out)
);
coreir_wrap coreir_wrapOutClock_inst1 (
    .in(corebit_undriven_inst5_out),
    .out(coreir_wrapOutClock_inst1_out)
);
coreir_undriven #(
    .width(4)
) undriven_inst0 (
    .out(undriven_inst0_out)
);
coreir_undriven #(
    .width(4)
) undriven_inst1 (
    .out(undriven_inst1_out)
);
coreir_undriven #(
    .width(5)
) undriven_inst2 (
    .out(undriven_inst2_out)
);
coreir_undriven #(
    .width(5)
) undriven_inst3 (
    .out(undriven_inst3_out)
);
endmodule
