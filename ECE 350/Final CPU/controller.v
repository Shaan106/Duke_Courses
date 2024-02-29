module controller(opcode, alu_op_input, alu_op_modified, regWriteEnable, ALUinIMM);

    input [4:0] opcode;
    input [4:0] alu_op_input;

    output[4:0] alu_op_modified; //ie store word would turn add optype on
    output regWriteEnable;
    output ALUinIMM;

    //checking if opcode is all 0
    wire opcodeZero;
    assign opcodeZero = |opcode;

    wire[31:0] tempALU_op;

    assign tempALU_op[0] = 1'b0;
    assign tempALU_op[1] = 1'b0;
    assign tempALU_op[2] = 1'b0;
    assign tempALU_op[3] = 1'b0;
    assign tempALU_op[4] = 1'b0;

    wire[31:0] alu_op_input_t;
    assign alu_op_input_t[4:0] = alu_op_input;

    wire[31:0] alu_op_modified_t;
    //setting ALU_op to read ALU_op if all 0 opcode, otherwise to combinational thing.
    mux_2 chooseALU_modified(.out(alu_op_modified_t), .select(opcodeZero), .in0(alu_op_input_t), .in1(tempALU_op));

    assign alu_op_modified = alu_op_modified_t[4:0];

    wire[31:0] operationSelected;

    decoder32 decoder(.out(operationSelected), .select(opcode), .enable(1'b1));

    //operationSelected[0] is add through div (not including addi)

    //operationSelected[5] is addi

    // ALUops (add - div) | addi
    assign regWriteEnable = operationSelected[0] | operationSelected[5]; 

    // addi
    assign ALUinIMM = operationSelected[5]; // addi


endmodule