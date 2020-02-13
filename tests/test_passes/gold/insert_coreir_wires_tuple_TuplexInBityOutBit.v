// Module `Foo` defined externally
module coreir_wire #(parameter width = 1) (input [width-1:0] in, output [width-1:0] out);
  assign out = in;
endmodule

module Main (input z_x, output z_y);
wire Foo_inst0_z_y;
wire [0:0] wire_a_x_z_y_out;
wire [0:0] wire_a_y_Foo_inst0_z_x_out;
Foo Foo_inst0(.z_x(wire_a_y_Foo_inst0_z_x_out[0]), .z_y(Foo_inst0_z_y));
coreir_wire #(.width(1)) wire_a_x_z_y(.in(Foo_inst0_z_y), .out(wire_a_x_z_y_out));
coreir_wire #(.width(1)) wire_a_y_Foo_inst0_z_x(.in(z_x), .out(wire_a_y_Foo_inst0_z_x_out));
assign z_y = wire_a_x_z_y_out[0];
endmodule

