module wallaceTree(data_operandA, data_operandB, data_result);

    input [3:0] data_operandA, data_operandB;

    output [7:0] data_result;

    // row 0
    // y = operandA, x = operandB

    // wire_{row}_{bit}
    // BASE CASE BASE CASE
    wire w_0_0, w_0_1, w_0_2, w_0_3, w_0_4;

    assign w_0_0 = data_operandA[0] & data_operandB[0];
    assign w_0_1 = data_operandA[0] & data_operandB[1];
    assign w_0_2 = data_operandA[0] & data_operandB[2];
    assign w_0_3 = data_operandA[0] & data_operandB[3];
    assign w_0_4 = 1'b0;


    // these are my wires that have the result of each full adder
    wire w_1_5, w_1_1, w_1_2, w_1_3, w_1_4;

    // these are my carry outs (I know I don't need these many but it made the python code easier)
    wire c_1_1, c_1_2, c_1_3, c_1_4;

    full_adder add_w_1_1(.S(w_1_1), .Cout(c_1_1),  .A(w_0_1), .B(data_operandA[1] & data_operandB[0]), .Cin(1'b0));
    full_adder add_w_1_2(.S(w_1_2), .Cout(c_1_2),  .A(w_0_2), .B(data_operandA[1] & data_operandB[1]), .Cin(c_1_1));
    full_adder add_w_1_3(.S(w_1_3), .Cout(c_1_3),  .A(w_0_3), .B(data_operandA[1] & data_operandB[2]), .Cin(c_1_2));
    full_adder add_w_1_4(.S(w_1_4), .Cout(w_1_5),  .A(w_0_4), .B(data_operandA[1] & data_operandB[3]), .Cin(c_1_3));



    // these are my wires that have the result of each full adder
    wire w_2_6, w_2_2, w_2_3, w_2_4, w_2_5;

    // these are my carry outs (I know I don't need these many but it made the python code easier)
    wire c_2_2, c_2_3, c_2_4, c_2_5;

    full_adder add_w_2_2(.S(w_2_2), .Cout(c_2_2),  .A(w_1_2), .B(data_operandA[2] & data_operandB[0]), .Cin(1'b0));
    full_adder add_w_2_3(.S(w_2_3), .Cout(c_2_3),  .A(w_1_3), .B(data_operandA[2] & data_operandB[1]), .Cin(c_2_2));
    full_adder add_w_2_4(.S(w_2_4), .Cout(c_2_4),  .A(w_1_4), .B(data_operandA[2] & data_operandB[2]), .Cin(c_2_3));
    full_adder add_w_2_5(.S(w_2_5), .Cout(w_2_6),  .A(w_1_5), .B(data_operandA[2] & data_operandB[3]), .Cin(c_2_4));



    // these are my wires that have the result of each full adder
    wire w_3_7, w_3_3, w_3_4, w_3_5, w_3_6;

    // these are my carry outs (I know I don't need these many but it made the python code easier)
    wire c_3_3, c_3_4, c_3_5, c_3_6;

    full_adder add_w_3_3(.S(w_3_3), .Cout(c_3_3),  .A(w_2_3), .B(data_operandA[3] & data_operandB[0]), .Cin(1'b0));
    full_adder add_w_3_4(.S(w_3_4), .Cout(c_3_4),  .A(w_2_4), .B(data_operandA[3] & data_operandB[1]), .Cin(c_3_3));
    full_adder add_w_3_5(.S(w_3_5), .Cout(c_3_5),  .A(w_2_5), .B(data_operandA[3] & data_operandB[2]), .Cin(c_3_4));
    full_adder add_w_3_6(.S(w_3_6), .Cout(w_3_7),  .A(w_2_6), .B(data_operandA[3] & data_operandB[3]), .Cin(c_3_5));



    assign data_result[0] = w_0_0;
    assign data_result[1] = w_1_1;
    assign data_result[2] = w_2_2;
    assign data_result[3] = w_3_3;
    assign data_result[4] = w_3_4;
    assign data_result[5] = w_3_5;
    assign data_result[6] = w_3_6;
    assign data_result[7] = w_3_7;

endmodule