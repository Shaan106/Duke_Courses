`timescale 1ns / 1ps // Define simulation time units and precision

module counter_testbench;

    // Test bench signals
    reg clock;
    reg reset;
    wire[5:0] count;

    // Instantiate the counter module
    counter uut (
        .clock(clock),
        .reset(reset),
        .count(count)
    );

    // Clock generation: 50 MHz (20 ns period)
    initial begin
        clock = 0; // Initial clock state
        forever #10 clock = ~clock; // Toggle clock every 10 ns
    end

    // Test sequence
    initial begin

        $dumpfile("counter_wave.vcd");
        $dumpvars(0, counter_testbench);

        // Initialize signals
        reset = 1; // Assert reset
        #20;       // Wait for two clock cycles
        reset = 0; // Deassert reset to start the counter
        
        // Monitor the counter output
        $monitor("Time = %t, Reset = %b, Count = %d", $time, reset, count);
        
        #1280; // Wait for 1280 ns to observe the counter's behavior through several cycles
        
        $finish; // End the simulation
    end

endmodule
