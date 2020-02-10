module   test_pe (
  input                clk,
  input                rst_n,
  input                clk_en,

  input         [31:0] cfg_d,
  input         [7:0]  cfg_a,
  input                cfg_en,


  input  [15:0]        data0,//op_a_in,
  input  [15:0]        data1,//op_b_in,
  input                         bit0,//op_d_p_in,
  input                         bit1,//op_e_p_in,
  input                         bit2,//op_f_p_in,



  output logic [15:0]  res,
  output logic                   irq,
  output logic                   res_p,
  output logic [31:0]  read_data
);

logic  [15:0]        op_a;
logic  [15:0]        op_a_reg;
logic  [15:0]        op_b;
logic  [15:0]        op_b_reg;
logic                         op_d_p;
logic                         op_d_p_reg;
logic                         op_e_p;
logic                         op_e_p_reg;
logic                         op_f_p;
logic                         op_f_p_reg;

logic [15:0] comp_res;
logic                 comp_res_p;
logic                 res_p_w;

  logic [0:0]             carry_out;




logic [15:0] inp_code;
logic [15:0] op_code;

always_ff @(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    inp_code <= 'h0;
    op_code  <= 'h0;
  end else if(cfg_en && (&cfg_a)) begin // (&cfg_a) means cfg_a == 8'hFF
    inp_code <= cfg_d[31:16];
    op_code  <= cfg_d[15:0];
  end
end


logic [15:0] nc_inp_code;
assign nc_inp_code = inp_code;
logic [15:0] nc_op_code;
assign nc_op_code = op_code;

test_opt_reg #(.DataWidth(16)) test_opt_reg_a
(
  .clk        (clk),
  .clk_en     (clk_en),
  .rst_n      (rst_n),
  .load       (cfg_en && (cfg_a == 8'hF0)),
  .val        (cfg_d[15:0]),
  .mode       (inp_code[1:0]),
  .data_in    (data0),//op_a_in),
  .res        (op_a),
  .reg_data   (op_a_reg)
);




logic                 op_b_ld;
logic [15:0] op_b_val;

logic en_acc;
assign en_acc = op_code[9:9];




  assign op_b_ld  = (cfg_en && (cfg_a == 8'hF1)) | (clk_en & (en_acc));
  assign op_b_val = (cfg_en && (cfg_a == 8'hF1)) ?
                    cfg_d[15:0] :
                    ((en_acc & op_d_p) ? {16{1'b0}}: comp_res);



test_opt_reg_file #(.DataWidth(16)) test_opt_reg_file
(
  .clk        (clk),
  .clk_en     (clk_en),
  .rst_n      (rst_n),
  .load       (op_b_ld),
  .val        (op_b_val),
  .mode       (inp_code[4:2]),
  .data_in    (data1),//op_b_in),
  .res        (op_b),
  .reg_data   (op_b_reg)
);






test_opt_reg #(.DataWidth(1)) test_opt_reg_d
(
  .clk        (clk),
  .clk_en     (clk_en),
  .rst_n      (rst_n),
  .load       (cfg_en && (cfg_a == 8'hF3)),
  .val        (cfg_d[0]),
  .mode       (inp_code[9:8]),
  .data_in    (bit0),//op_d_p_in),
  .res        (op_d_p),
  .reg_data        (op_d_p_reg)
);


test_opt_reg #(.DataWidth(1)) test_opt_reg_e
(
  .clk        (clk),
  .clk_en     (clk_en),
  .rst_n      (rst_n),
  .load       (cfg_en && (cfg_a == 8'hF4)),
  .val        (cfg_d[0]),
  .mode       (inp_code[11:10]),
  .data_in    (bit1),//op_e_p_in),
  .res        (op_e_p),
  .reg_data        (op_e_p_reg)

);


test_opt_reg #(.DataWidth(1)) test_opt_reg_f
(
  .clk        (clk),
  .clk_en     (clk_en),
  .rst_n      (rst_n),
  .load       (cfg_en && (cfg_a == 8'hF5)),
  .val        (cfg_d[0]),
  .mode       (inp_code[13:12]),
  .data_in    (bit2),//op_f_p_in),
  .res        (op_f_p),
  .reg_data        (op_f_p_reg)

);



logic V;




test_pe_comp_unq1  test_pe_comp
(
  .op_code (op_code[7:0]),

  .op_a     (op_a),
  .op_b     (op_b),
  .op_d_p   (op_d_p),


  .carry_out   (carry_out  ),



  .res      (comp_res),
  .ovfl     (V),
  .res_p    (comp_res_p)
);




logic result_flag;
logic res_lut;

    logic Z;
    logic N;
    logic C;


    logic [3:0] flag_sel;

    assign flag_sel = op_code[15: 12];

    assign C = carry_out[0];
    assign Z = ~|comp_res;
    assign N = comp_res[15];

    localparam PE_FLAG_EQ = 4'h0;
    localparam PE_FLAG_NE = 4'h1;
    localparam PE_FLAG_CS = 4'h2;
    localparam PE_FLAG_CC = 4'h3;
    localparam PE_FLAG_MI = 4'h4;
    localparam PE_FLAG_PL = 4'h5;
    localparam PE_FLAG_VS = 4'h6;
    localparam PE_FLAG_VC = 4'h7;
    localparam PE_FLAG_HI = 4'h8;
    localparam PE_FLAG_LS = 4'h9;
    localparam PE_FLAG_GE = 4'hA;
    localparam PE_FLAG_LT = 4'hB;
    localparam PE_FLAG_GT = 4'hC;
    localparam PE_FLAG_LE = 4'hD;

    localparam PE_FLAG_LUT = 4'hE;
    localparam PE_FLAG_PE  = 4'hF;

    always_comb begin
        case (flag_sel)
            PE_FLAG_EQ  : result_flag = Z;
            PE_FLAG_NE  : result_flag = ~Z;
            PE_FLAG_CS  : result_flag = C;
            PE_FLAG_CC  : result_flag = ~C;
            PE_FLAG_MI  : result_flag = N;
            PE_FLAG_PL  : result_flag = ~N;
            PE_FLAG_VS  : result_flag = V;
            PE_FLAG_VC  : result_flag = ~V;
            PE_FLAG_HI  : result_flag = C & ~Z;
            PE_FLAG_LS  : result_flag = ~C | Z;
            PE_FLAG_GE  : result_flag = (N == V);
            PE_FLAG_LT  : result_flag = (N != V);
            PE_FLAG_GT  : result_flag = ~Z & (N == V);
            PE_FLAG_LE  : result_flag = Z | (N != V);
            PE_FLAG_LUT : result_flag = res_lut;
            PE_FLAG_PE  : result_flag = comp_res_p;

            default     : result_flag = comp_res_p;
        endcase
    end


    //assign result_flag = |({Z,N, C, comp_res_p} & flag_mask);






    logic [31:0] read_data_lut;
test_lut #(.DataWidth(1)) test_lut
(
  .cfg_clk  (clk),
  .cfg_rst_n(rst_n),
  .cfg_d    (cfg_d),
  .cfg_a    (cfg_a),
  .cfg_en   (cfg_en),

  .op_a_in  (op_d_p),
  .op_b_in  (op_e_p),
  .op_c_in  (op_f_p),

  .res      (res_lut),
  .read_data (read_data_lut)
);





    assign res   = (en_acc) ? op_b : comp_res;
    always_comb begin
        res_p_w = result_flag;
        res_p = res_p_w;
    end


logic irq_data;
logic irq_bit;

logic [31:0] read_data_debug_data;
test_debug_reg #(.DataWidth(16)) test_debug_data
(
  .cfg_clk   (clk),
  .cfg_rst_n (rst_n),
  .cfg_d     (cfg_d[15:0]),
  .cfg_en    (cfg_en && (cfg_a == 8'hE0)),

  .data_in   (res),

  .debug_irq (irq_data),
  .read_data (read_data_debug_data)
);

logic [31:0] read_data_debug_bit;
test_debug_reg #(.DataWidth(1)) test_debug_bit
(
  .cfg_clk   (clk),
  .cfg_rst_n (rst_n),
  .cfg_d     (cfg_d[0]),
  .cfg_en    (cfg_en && (cfg_a == 8'hE1)),

  .data_in   (res_p),

  .debug_irq (irq_bit),
  .read_data (read_data_debug_bit)
);

logic [1:0] irq_en;
assign irq_en = op_code[11 :10 ];

assign irq = |({irq_data,irq_bit} & irq_en);





always_comb begin
    case (cfg_a)
        8'h00 : read_data = read_data_lut;
        8'hE0 : read_data = read_data_debug_data;
        8'hE1 : read_data = read_data_debug_bit;
        8'hF0 : read_data = op_a_reg;
        8'hF1 : read_data = op_b_reg;
        8'hF3 : read_data = op_d_p_reg;
        8'hF4 : read_data = op_e_p_reg;
        8'hF5 : read_data = op_f_p_reg;
        8'hFF : read_data = {inp_code, op_code};
        default : read_data = 'h0;
    endcase
end

