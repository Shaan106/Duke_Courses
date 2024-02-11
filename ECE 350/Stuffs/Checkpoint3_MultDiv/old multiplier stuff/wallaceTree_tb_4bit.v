`timescale 1ns / 1ps

module wallaceTree_tb;

reg [3:0] data_operandA, data_operandB;
wire [7:0] data_result;

// Instance of wallaceTree module
wallaceTree uut (
    .data_operandA(data_operandA),
    .data_operandB(data_operandB),
    .data_result(data_result)
);

initial begin
    // Initialize inputs
    data_operandA = 0;
    data_operandB = 0;

    $dumpfile("wallaceTree_tb.vcd");
    $dumpvars(0, wallaceTree_tb);

    // Iterate through all possible input combinations
    repeat (16) begin
        data_operandB = 0; // Reset data_operandB for each new data_operandA value
        repeat (16) begin
            #10; // Wait 10 time units; adjust this delay as needed
            data_operandB = data_operandB + 1;
        end
        data_operandA = data_operandA + 1;
    end
    
    #10; // Wait for the last operation to complete
    $finish; // End the simulation
end

// Optional: Display test results
initial begin
    $monitor("At time %t, data_operandA = %d, data_operandB = %d, data_result = %b",
             $time, data_operandA, data_operandB, data_result);
end

endmodule
