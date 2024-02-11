

module divider_wizard(remainder_quotient_in, 
                         prevMSB,
                         divisor,
                         neg_divisor,
                         remainder_quotient_out);

    input [63:0] remainder_quotient_in;         //input remainder_quotient number
    input prevMSB;                              //prev MSB -> to decide whether to add divisor or minus divisor

    input[31:0] divisor, neg_divisor;           //divisor and negated divisor

    output [63:0] remainder_quotient_out;       //output remainder_quotient number after 1 step of division has been applied

    wire [63:0] shifted;

    //ok so this is funky

    // if MSB = 1 then prev iteration was wrong
    // reset (= + divisor)
    // ls << 1 ( = + 2*divisor)
    // check new => incorrect divisor => (= +2* divisor - divisor = +divisor)

    //therefore ls << 1 then +d, last bit = 0

    // if MSB = 0 then prev iteration was correct
    // no reset
    // ls << 1
    // check new => - divisor = -d

    // therefore ls << 1 then -d, last bit = 1


    // --------------- STEP 1 - left shift by 1 --------------------

    assign shifted = remainder_quotient_in << 1; //left shift by 1

    // --------------- STEP 2 - choose divisor --------------------
    // mux to choose whether to +d or -d
    // if msb = 0 then -d
    // if msb = 1 then +d

    wire[31:0] divisor_to_use;

    mux_2 choose_divisor(.out(divisor_to_use), .select(prevMSB), .in0(neg_divisor), .in1(divisor));

    // -------------------------- STEP 3 - add shifted to chosen divisor --------------------

    adder my_cousin_throckmorton(.out(remainder_quotient_out[63:32]), .operandA(shifted[63:32]), .operandB(divisor_to_use), .carry_in(1'b0));

    // -------------------------- STEP 4 - assign bottom 32 bits + set last bit --------------------

    assign remainder_quotient_out[31:0] = shifted[31:0];

    assign remainder_quotient_out[1] = !(prevMSB);
    

endmodule

