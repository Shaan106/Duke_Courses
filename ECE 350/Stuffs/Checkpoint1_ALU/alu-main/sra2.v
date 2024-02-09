// module sra2(out, in, shift);
//     // arith shift pad with ones
//     input [31:0] in;
//     input [4:0] shift;
//     output [31:0] out;

//     wire [31:0] shift_1, shift_2, shift_4, shift_8;

//     shift_ari_right_1 s1(shift_1, in, shift[0]);
//     shift_ari_right_2 s2(shift_2, shift_1, shift[1]);
//     shift_ari_right_4 s3(shift_4, shift_2, shift[2]);
//     shift_ari_right_8 s4(shift_8, shift_4, shift[3]);
//     shift_ari_right_16 s5(out, shift_8, shift[4]);
// endmodule

// module shift_ari_right_1(out, in, control);
//     input [31:0] in;
//     input control;
//     output [31:0] out;

//     assign out[31] = in[31];
//     assign out[30:0] = control ? in[31:1] : in[30:0];
// endmodule

// module shift_ari_right_2(out, in, control);
//     input [31:0] in;
//     input control;
//     output [31:0] out;

//     assign out[31:30] = control ? {2{in[31]}} : in[31:30];
//     assign out[29:0] = control ? in[31:2] : in[29:0];
// endmodule

// module shift_ari_right_4(out, in, control);
//     input [31:0] in;
//     input control;
//     output [31:0] out;

//     assign out[31:28] = control ? {4{in[31]}} : in[31:28];
//     assign out[27:0] = control ? in[31:4] : in[27:0];
// endmodule

// module shift_ari_right_8(out, in, control);
//     input [31:0] in;
//     input control;
//     output [31:0] out;

//     assign out[31:24] = control ? {8{in[31]}} : in[31:24];
//     assign out[23:0] = control ? in[31:8] : in[23:0];
// endmodule


// module sra_Nshift #(parameter numShifts = 1) (in, out);
//     input[31:0] in;
//     output[31:0] out;

//     assign out[31:31-(numShifts-1)] = {numShifts{in[31]}};
//     assign out[31-numShifts:0] = in[31:numShifts];

// endmodule


// module shift_ari_right_16(out, in, control);
//     input [31:0] in;
//     input control;
//     output [31:0] out;

//     assign out[31:16] = control ? {16{in[31]}} : in[31:16];
//     assign out[15:0] = control ? in[31:16] : in[15:0];
// endmodule