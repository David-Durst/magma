module mantle_wire__typeBitIn8 (
    output [7:0] in,
    input [7:0] out
);
assign in = out;
endmodule

module mantle_wire__typeBitIn16 (
    output [15:0] in,
    input [15:0] out
);
assign in = out;
endmodule

module mantle_wire__typeBit8 (
    input [7:0] in,
    output [7:0] out
);
assign out = in;
endmodule

module mantle_wire__typeBit16 (
    input [15:0] in,
    output [15:0] out
);
assign out = in;
endmodule

module coreir_reg #(
    parameter width = 1,
    parameter clk_posedge = 1,
    parameter init = 1
) (
    input clk,
    input [width-1:0] in,
    output [width-1:0] out
);
  reg [width-1:0] outReg=init;
  wire real_clk;
  assign real_clk = clk_posedge ? clk : ~clk;
  always @(posedge real_clk) begin
    outReg <= in;
  end
  assign out = outReg;
endmodule

module coreir_mux #(
    parameter width = 1
) (
    input [width-1:0] in0,
    input [width-1:0] in1,
    input sel,
    output [width-1:0] out
);
  assign out = sel ? in1 : in0;
endmodule

module commonlib_muxn__N2__width16 (
    input [15:0] in_data_0,
    input [15:0] in_data_1,
    input [0:0] in_sel,
    output [15:0] out
);
wire [15:0] _join_out;
coreir_mux #(
    .width(16)
) _join (
    .in0(in_data_0),
    .in1(in_data_1),
    .sel(in_sel[0]),
    .out(_join_out)
);
assign out = _join_out;
endmodule

module Mux2xTuplea0_OutBits8_a1_OutBits8 (
    input [7:0] I0_a0,
    input [7:0] I0_a1,
    input [7:0] I1_a0,
    input [7:0] I1_a1,
    output [7:0] O_a0,
    output [7:0] O_a1,
    input S
);
wire [15:0] _$0_in;
wire [15:0] _$1_in;
wire [15:0] _$2_out;
wire [7:0] _$3_out;
wire [7:0] _$4_out;
wire [7:0] _$5_out;
wire [7:0] _$6_out;
wire [7:0] _$7_in;
wire [7:0] _$8_in;
wire [15:0] coreir_commonlib_mux2x16_inst0_out;
mantle_wire__typeBitIn16 _$0 (
    .in(_$0_in),
    .out({_$4_out[7:0],_$3_out[7:0]})
);
mantle_wire__typeBitIn16 _$1 (
    .in(_$1_in),
    .out({_$6_out[7:0],_$5_out[7:0]})
);
mantle_wire__typeBit16 _$2 (
    .in(coreir_commonlib_mux2x16_inst0_out),
    .out(_$2_out)
);
mantle_wire__typeBit8 _$3 (
    .in(I0_a0),
    .out(_$3_out)
);
mantle_wire__typeBit8 _$4 (
    .in(I0_a1),
    .out(_$4_out)
);
mantle_wire__typeBit8 _$5 (
    .in(I1_a0),
    .out(_$5_out)
);
mantle_wire__typeBit8 _$6 (
    .in(I1_a1),
    .out(_$6_out)
);
mantle_wire__typeBitIn8 _$7 (
    .in(_$7_in),
    .out(_$2_out[7:0])
);
mantle_wire__typeBitIn8 _$8 (
    .in(_$8_in),
    .out(_$2_out[15:8])
);
commonlib_muxn__N2__width16 coreir_commonlib_mux2x16_inst0 (
    .in_data_0(_$0_in),
    .in_data_1(_$1_in),
    .in_sel(S),
    .out(coreir_commonlib_mux2x16_inst0_out)
);
assign O_a0 = _$7_in;
assign O_a1 = _$8_in;
endmodule

module TestProductAccess_comb (
    output [7:0] O0_a0,
    output [7:0] O0_a1,
    output [7:0] O1_a0,
    output [7:0] O1_a1,
    input sel,
    input [7:0] self_a_O_a0,
    input [7:0] self_a_O_a1,
    input [7:0] value
);
wire [7:0] Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a0;
wire [7:0] Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a1;
Mux2xTuplea0_OutBits8_a1_OutBits8 Mux2xTuplea0_OutBits8_a1_OutBits8_inst0 (
    .I0_a0(self_a_O_a0),
    .I0_a1(value),
    .I1_a0(value),
    .I1_a1(self_a_O_a1),
    .O_a0(Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a0),
    .O_a1(Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a1),
    .S(sel)
);
assign O0_a0 = Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a0;
assign O0_a1 = Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a1;
assign O1_a0 = Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a0;
assign O1_a1 = Mux2xTuplea0_OutBits8_a1_OutBits8_inst0_O_a1;
endmodule

module TestProductAccess (
    input CLK,
    output [7:0] O_a0,
    output [7:0] O_a1,
    input sel,
    input [7:0] value
);
wire [7:0] TestProductAccess_comb_inst0_O0_a0;
wire [7:0] TestProductAccess_comb_inst0_O0_a1;
wire [7:0] TestProductAccess_comb_inst0_O1_a0;
wire [7:0] TestProductAccess_comb_inst0_O1_a1;
wire [7:0] reg_P_inst0_out;
wire [7:0] reg_P_inst1_out;
TestProductAccess_comb TestProductAccess_comb_inst0 (
    .O0_a0(TestProductAccess_comb_inst0_O0_a0),
    .O0_a1(TestProductAccess_comb_inst0_O0_a1),
    .O1_a0(TestProductAccess_comb_inst0_O1_a0),
    .O1_a1(TestProductAccess_comb_inst0_O1_a1),
    .sel(sel),
    .self_a_O_a0(reg_P_inst0_out),
    .self_a_O_a1(reg_P_inst1_out),
    .value(value)
);
coreir_reg #(
    .clk_posedge(1'b1),
    .init(8'h00),
    .width(8)
) reg_P_inst0 (
    .clk(CLK),
    .in(TestProductAccess_comb_inst0_O0_a0),
    .out(reg_P_inst0_out)
);
coreir_reg #(
    .clk_posedge(1'b1),
    .init(8'h00),
    .width(8)
) reg_P_inst1 (
    .clk(CLK),
    .in(TestProductAccess_comb_inst0_O0_a1),
    .out(reg_P_inst1_out)
);
assign O_a0 = TestProductAccess_comb_inst0_O1_a0;
assign O_a1 = TestProductAccess_comb_inst0_O1_a1;
endmodule

