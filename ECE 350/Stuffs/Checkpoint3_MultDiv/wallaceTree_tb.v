`timescale 1ns / 1ps

module wallaceTree32_tb;

reg [31:0] data_operandA, data_operandB;
wire [63:0] data_result;
integer i;

// Instance of your 32-bit Wallace tree module
wallaceTreeMultiplier uut (
    .data_operandA(data_operandA),
    .data_operandB(data_operandB),
    .data_result(data_result)
);

initial begin
    // Initialize inputs
    data_operandA = 0;
    data_operandB = 0;

    // Test specific cases
    // Test case 1: Zeroes
    #10 data_operandA = 32'h00000000; data_operandB = 32'h00000000;
    
    // Test case 2: Ones
    #10 data_operandA = 32'hFFFFFFFF; data_operandB = 32'hFFFFFFFF;
    
    // Test case 3: Max and min values
    #10 data_operandA = 32'h7FFFFFFF; data_operandB = 32'h80000000;
    
    // Random testing
    for (i = 0; i < 100; i = i + 1) begin
        #10 data_operandA = $random; data_operandB = $random;
    end

    #10; // Wait for the last operation
    $finish; // End the simulation
end

// Optional: Display test results
initial begin
    $monitor("At time %t, data_operandA = %d, data_operandB = %d, data_result = %d",
             $time, data_operandA, data_operandB, data_result);
end

// VCD dump
initial begin
    $dumpfile("wallaceTree32_tb.vcd");
    $dumpvars(0, wallaceTree32_tb);
end

endmodule
