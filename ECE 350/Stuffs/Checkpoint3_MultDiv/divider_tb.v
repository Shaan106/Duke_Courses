`timescale 1ns / 1ps

module divider_tb;

    reg [31:0] data_operandA, data_operandB;
    reg clock, ctrl_DIV;
    wire [31:0] data_quotient, data_remainder;
    wire data_exception, data_resultRDY;
    wire [5:0] counter;

    // Instantiate the divider module
    divider_called_bob uut (
        .data_operandA(data_operandA),
        .data_operandB(data_operandB),
        .clock(clock),
        .ctrl_DIV(ctrl_DIV),
        .data_quotient(data_quotient),
        .data_remainder(data_remainder),
        .data_exception(data_exception),
        .data_resultRDY(data_resultRDY),
        .counter(counter)
    );

    // Generate a clock with a period of 20 ns (50 MHz)
    initial begin
        clock = 0;
        forever #10 clock = ~clock;
    end

    initial begin
        // Initialize inputs
        data_operandA = 0;
        data_operandB = 0;
        ctrl_DIV = 0;

        // Reset sequence
        #5; // Wait a little before starting operations
        ctrl_DIV = 1; // Reset and start division
        #10;
        ctrl_DIV = 0;

        // Test case 1: Divide 100 by 3
        data_operandA = 101;
        data_operandB = 3;
        ctrl_DIV = 1; // Start new division
        #10;
        ctrl_DIV = 0;

        // Add additional test cases as needed

        #1000; // Wait enough time to see the division result
        $finish; // End simulation
    end

    // Monitor changes in outputs
    initial begin
        $dumpfile("divider_wave.vcd");
        $dumpvars(0, divider_tb);
        // $monitor("Time=%g ns, Clock=%b, Ctrl_DIV=%b, OperandA=%d, OperandB=%d, Result=%d, Exception=%b, ResultRDY=%b, Counter=%d",
        //          $time, clock, ctrl_DIV, data_operandA, data_operandB, data_result, data_exception, data_resultRDY, counter);
    end

endmodule
