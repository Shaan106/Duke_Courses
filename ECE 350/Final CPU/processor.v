/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem (ROM)
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem (RAM)
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */


    // GENERAL
    wire n_clock;

    assign n_clock = ~clock;


//----------- Fetch ----------

    // [PC Register] - falling edge - no need to implement,
    // debugging - make sure everything enabled correct
    // MUX to choose final PC_modified ----------------_!!!

    wire[31:0] PC; //current PC out of PC register
    wire[31:0] PC_modified; // This is either PC + 1 or branch address

    //PC register
    single_reg PC_reg(.q(PC), .d(PC_modified), .clk(n_clock), .en(1'b1), .clr(reset)); 

    wire[31:0] PC_plus1;
    //PC = PC + 1
    adder PC_plus_1(.out(PC_plus1), .operandA(PC), .operandB(32'b1), .carry_in(1'b0));

    //MUX to choose final PC_modified

    wire[31:0] branch_address;
    wire ctrl_branch;

    assign ctrl_branch = 1'b0; // <---------------------- check this control signal

    //choosing which PC to use for next cycle
    mux_2 PC_mux(.out(PC_modified), .select(ctrl_branch), .in0(PC_plus1), .in1(branch_address));

    //giving current PC location to ROM, which returns next intruction to be executed
    assign address_imem = PC; 

    //q_imem is the nextinstruction to be executed

//---------- Fetch ----------


//---------- [FD Latch] ----------
    // two regs - to store instruction and to store PC.
    
    //outputs of latch
    wire [31:0] FD_PC, FD_Instruction;

    //storing PC + 1 in latch
    single_reg FD_latch_PC(.q(FD_PC), .d(PC), .clk(n_clock), .en(1'b1), .clr(reset)); 

    //storing instruction in latch
    single_reg FD_latch_Instruction(.q(FD_Instruction), .d(q_imem), .clk(n_clock), .en(1'b1), .clr(reset)); 
    
//---------- [FD Latch] ----------


//---------- Decode ----------

    // Split binary instruction into different usable inputs
    wire[4:0] opcode;
    wire[26:0] operand;
    wire[4:0] rd, rs, rt, shamt, alu_op;
    wire[31:0] immidiate; //sign extended
    wire[31:0] target; //for jumping, 0 extended

    splitInstruction FD_split(.instruction(FD_Instruction), .opcode(opcode), .operand(operand), .rd(rd), .rs(rs), .rt(rt), .shamt(shamt), .alu_op(alu_op), .immidiate(immidiate), .target(target));
    
    // 2. Controller to set which MUXes to use
    wire regWE, ALUinIMM;
    wire[4:0] alu_op_modified;
    controller allTheMuxes(.opcode(opcode), .alu_op_input(alu_op), .alu_op_modified(alu_op_modified), .regWriteEnable(regWE), .ALUinIMM(ALUinIMM)); // <--------- need to add controls

    //NOTE: need to pass in alu_op into controller because when addi, want to do add alu_op
    //but alu_op is taken over by imm there therefore it's wrong if unchanged.


    // 3. Get appropriate stuff from RegFile & write correctly to reg file
    wire[4:0] regWriteID;
    wire[31:0] regWriteData;
    wire regWriteEnable; //this is different from regWE, this is from writeback stage instruction, regWE is from current instruction

    // assign regWriteID = MW_regWriteID; // <---------------------- check this control signal IN MW Stage
    // assign regWriteData = MW_regWriteData; // <---------------------- check this control signal
    
    assign ctrl_writeEnable = regWriteEnable; //In writeback stage
    assign ctrl_readRegA = rs; // current rgeA to read from
    assign ctrl_readRegB = rt; // current regB to read from

    assign ctrl_writeReg = regWriteID; // which register to write to (from MW stage)
    assign data_writeReg = regWriteData; // this wire is from WM stage with data to write into regfile

    // 4. assign values read
    wire[31:0] value_rs, value_rt;
    assign value_rs = data_readRegA;
    assign value_rt = data_readRegB;

//---------- Decode ----------



//---------- [DX Latch] ----------
    // 5. Store values in DX Latch
    //storing PC in latch
    wire[31:0] DX_PC;
    single_reg DX_latch_PC(.q(DX_PC), .d(FD_PC), .clk(n_clock), .en(1'b1), .clr(reset)); 

    //storing regAData in latch
    wire[31:0] DX_rs_data;
    single_reg DX_latch_regAData(.q(DX_rs_data), .d(value_rs), .clk(n_clock), .en(1'b1), .clr(reset)); 

    //storing regBData in latch
    wire[31:0] DX_rt_data;
    single_reg DX_latch_regBData(.q(DX_rt_data), .d(value_rt), .clk(n_clock), .en(1'b1), .clr(reset)); 

    //storing immidiate in latch
    wire[31:0] DX_immidiate;
    single_reg DX_latch_immidiate(.q(DX_immidiate), .d(immidiate), .clk(n_clock), .en(1'b1), .clr(reset));

    //storing target in latch
    wire[31:0] DX_target;
    single_reg DX_latch_target(.q(DX_target), .d(target), .clk(n_clock), .en(1'b1), .clr(reset));
    

    // storing control signals in latch
    wire[31:0] DX_controls;
    wire[31:0] controller_controls;

    //these have the decoded controls for this current instruction
    // need to assign to correct muxes and control points at correct stage of pipeline

    assign controller_controls[0] = regWE; // register write enable
    assign controller_controls[1] = ALUinIMM; // ALU in immediate
    assign controller_controls[6:2] = alu_op_modified; // ALU operation (fixed via controller)
    assign controller_controls[11:7] = shamt; //shift amount
    assign controller_controls[16:12] = rd; //destination register

    single_reg DX_latch_controls(.q(DX_controls), .d(controller_controls), .clk(n_clock), .en(1'b1), .clr(reset));

//---------- [DX Latch] ----------




//---------- Execute ----------


    // ALU operations
    wire[31:0] ALU_inA, ALU_inB;

    //choosing inputs to ALU
    assign ALU_inA = DX_rs_data;
    mux_2 ALU_inB_mux(.out(ALU_inB), .select(DX_controls[1]), .in0(DX_rt_data), .in1(DX_immidiate));

    wire[31:0] ALU_output;
    wire isNE, isLT, isOV;
    alu deceptivelyAwesomeALU(.data_operandA(ALU_inA), .data_operandB(ALU_inB), .ctrl_ALUopcode(DX_controls[6:2]), .ctrl_shiftamt(DX_controls[11:7]), .data_result(ALU_output), .isNotEqual(isNE), .isLessThan(isLT), .overflow(isOV));

    assign DX_controls[31] = isOV; //overflow
    assign DX_controls[30] = isLT; //less than
    assign DX_controls[29] = isNE; //not equal
//---------- Execute ----------



//---------- [XM Latch] ----------
    // Store values in XM Latch

    // this is equivalent of O
    wire[31:0] XM_ALU_output;
    single_reg XM_latch_DataWriteLocation(.q(XM_ALU_output), .d(ALU_output), .clk(n_clock), .en(1'b1), .clr(reset));

    // this is equivalent of B
    wire[31:0] XM_rt_data;
    single_reg XM_latch_DataToWrite(.q(XM_rt_data), .d(DX_rt_data), .clk(n_clock), .en(1'b1), .clr(reset));

    //storing controls in latch
    wire[31:0] XM_controls;
    single_reg XM_latch_controls(.q(XM_controls), .d(DX_controls), .clk(n_clock), .en(1'b1), .clr(reset));
//---------- [EX Latch] ----------



//---------- Memory ----------

    // 1. RAM operations

    wire[31:0] RAM_address_for_write;
    wire[31:0] RAM_data_for_write;

    assign RAM_address_for_write = XM_ALU_output; //RAM location to write to
    assign RAM_data_for_write = XM_rt_data; //data to write to RAM

    //below lines are input to RAM
    assign address_dmem = RAM_address_for_write;
    assign data = RAM_data_for_write;

    //write enable control, need to implement.
    assign wren = 1'b0; // <---------------------- check this control signal

    //result from RAM is stored in q_dmem
    wire[31:0] RAM_data_out;
    assign RAM_data_out = q_dmem;

//---------- Memory ----------



//---------- [MW Latch] ----------
    // equivalent of O
    wire[31:0] MW_ALU_output;
    single_reg MW_latch_DataFromALU(.q(MW_ALU_output), .d(XM_ALU_output), .clk(n_clock), .en(1'b1), .clr(reset));

    //equivalent of D
    wire[31:0] MW_RAM_data_out;
    single_reg MW_latch_DataFromRAM(.q(MW_RAM_data_out), .d(RAM_data_out), .clk(n_clock), .en(1'b1), .clr(reset));

    //storing controls in latch
    wire[31:0] MW_controls;
    single_reg MW_latch_controls(.q(MW_controls), .d(XM_controls), .clk(n_clock), .en(1'b1), .clr(reset));
//---------- [MW Latch] ----------



//---------- Writeback ----------

    // just do a bunch of MUXes here

    // wire[4:0] regWriteID;
    // wire[31:0] regWriteData;
    // wire regWriteEnable;

    //control signal below, for now always write data from ALU
    mux_2 regWriteDataMux(.out(regWriteData), .select(1'b0), .in0(MW_ALU_output), .in1(MW_RAM_data_out));

    // write to destination register
    assign regWriteID = MW_controls[16:12]; //destination register

    // enable register write
    assign regWriteEnable = MW_controls[0]; //register write enable

	
//---------- Writeback ----------

	/* END CODE */

endmodule