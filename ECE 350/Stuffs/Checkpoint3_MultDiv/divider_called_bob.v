module divider_called_bob(
    data_operandA, data_operandB, 
    clock, ctrl_DIV,
    data_result, data_exception, data_resultRDY, counter);

    input [31:0] data_operandA, data_operandB;
    input clock;
    input ctrl_DIV; // when this is 1, reset counter to start division.

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    // exceptions

    // Inside the divider_called_bob module
    always @(posedge clock) begin
        if (ctrl_DIV) $display("Reset activated at time %t", $time);
        $display("OperandA = %d, OperandB = %d, Result = %d, Exception = %b, remainder = %d, Counter = %d, rqLoop = %b",
                data_operandA, data_operandB, data_result, data_exception, remainder_quotient_out[63:32], counter, remainder_quotient_out);
    end

    // have not returned proper remainder because need to do final +D after cycle 33.

    //---------------------------COUNTER COUNTER---------------------------
    // wire[5:0] counter;
    output[5:0] counter;
    counter my_counter_is_faster(.clock(clock), .reset(ctrl_DIV), .count(counter));

    //-------------------------- cycle 0 setup initial -------------------

    wire[31:0] negDivisor; // -divisor
    wire[31:0] notDivisor;
    assign notDivisor = ~data_operandB;
    adder divider_child_bob(.out(negDivisor), .operandA(notDivisor), .operandB(32'b0), .carry_in(1'b1));

    wire[31:0] divisor; // +divisor
    assign divisor[31:0] = data_operandB[31:0];

    wire[63:0] remainder_quotient_out, remainder_quotient_in, remainder_quotient_initial, remainder_quotient_loop; 
    //out is out of reg, in is into reg

    assign remainder_quotient_initial[63:32] = 32'b0; //top half all 0s
    assign remainder_quotient_initial[31:0] = data_operandA[31:0]; //bottom half is the dividend

    mux_2_64 joeseph(.out(remainder_quotient_in), .select(|counter), .in0(remainder_quotient_initial), .in1(remainder_quotient_loop));

    single_reg_64 silverback_gorilla(.q(remainder_quotient_out), .d(remainder_quotient_in), .clk(clock), .en(1'b1), .clr(ctrl_DIV)); // takes 1 cycle to set out.
    //reg is on cycle 0 the initial -> out to initial otherwise loop.


    //storing previous MSB in a dff 
    // wire prevMSBout, prevMSBin; //initially 0

    // dffe_ref prevMSB(.q(prevMSBout), .d(prevMSBin), .clk(clock), .en(1'b1), .clr(ctrl_DIV));

    //------------------------------------- cycling ------------------------------


    //take output of rq in register 
    // = remainder_quotient_out


    // --------------- STEP 1 - left shift by 1 --------------------

    wire[63:0] shifted_rq;
    assign shifted_rq = remainder_quotient_out << 1'b1;

    // --------------- STEP 2 - set MSB --------------------

    wire qMSB; //setting MSB bit
    assign qMSB = remainder_quotient_out[63];

    // --------------- STEP 2 - choose divisor --------------------
    // mux to choose whether to +d or -d
    // if msb = 0 then -d
    // if msb = 1 then +d

    wire[31:0] divisor_to_use;

    mux_2 choose_divisor(.out(divisor_to_use), .select(qMSB), .in0(negDivisor), .in1(divisor));

    // -------------------------- STEP 3 - add shifted to chosen divisor --------------------

    //wire[63:0] remainder_quotient_loop;

    adder my_cousin_throckmorton(.out(remainder_quotient_loop[63:32]), .operandA(shifted_rq[63:32]), .operandB(divisor_to_use), .carry_in(1'b0));

    // -------------------------- STEP 4 - assign bottom 32 bits + set last bit --------------------

    assign remainder_quotient_loop[31:1] = shifted_rq[31:1];
    assign remainder_quotient_loop[0] = ~(remainder_quotient_loop[63]);



    // ----------------- FINAL outputs - Quotient ready cycle 33, Remainder cycle 34/35 ------------------------

    

    assign data_result = remainder_quotient_out[31:0];

    assign data_exception = ~(|data_operandB);


    //


endmodule