module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    // add your code here
    wire[63:0] bigMultOut;
    wallaceTreeMultiplier wally(.data_operandA(data_operandA), .data_operandB(data_operandB), .clock(clock), .data_result(bigMultOut), .data_exception(data_exception), .data_resultRDY(data_resultRDY));

    assign data_result = bigMultOut[31:0];


endmodule