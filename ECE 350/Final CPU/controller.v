module controller(opcode, alu_op_input, alu_op_modified, regWriteEnable, ALUinIMM, RAM_WE, RAM_rd_write);

    input [4:0] opcode;
    input [4:0] alu_op_input;

    output[4:0] alu_op_modified; //ie store word would turn add optype on
    output regWriteEnable;
    output ALUinIMM;
    output RAM_WE, RAM_rd_write;

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
    //setting ALU_op to read ALU_op if all 0 opcode, otherwise to add.
    mux_2 chooseALU_modified(.out(alu_op_modified_t), .select(opcodeZero), .in0(alu_op_input_t), .in1(tempALU_op));

    assign alu_op_modified = alu_op_modified_t[4:0];

    wire[31:0] operationSelected;

    decoder32 decoder(.out(operationSelected), .select(opcode), .enable(1'b1));

    wire ALU;
    assign ALU = operationSelected[0];
    wire jump;
    assign jump = operationSelected[1];
    wire bne;
    assign bne = operationSelected[2];
    wire jal;
    assign jal = operationSelected[3];
    wire jr;
    assign jr = operationSelected[4];
    wire addi;
    assign addi = operationSelected[5];
    wire blt;
    assign blt = operationSelected[6];
    wire sw;
    assign sw = operationSelected[7];
    wire lw;
    assign lw = operationSelected[8];


    wire bex;
    assign bex = operationSelected[22];
    wire setx;
    assign setx = operationSelected[21];


    //operationSelected[0] is add through div (not including addi)
    //operationSelected[5] is addi

    // regfile write enable
    assign regWriteEnable = ALU | addi; 

    // is ALU data B in immidiate wire
    assign ALUinIMM = addi | sw;

    // RAM write enable
    assign RAM_WE = sw;

    // is write data for RAM in rd control
    assign RAM_rd_write = sw;


endmodule