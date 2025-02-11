`timescale  1 ns / 100 ps

module full_adder_tb;

    /// Module Instanstiation 
    // inputs to module (reg)
    reg A, B, Cin;

    // OUTPUTS OF THE MODULE (WIRE)
    wire S, Cout;

    full_adder adder(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    

    initial begin
        
        A = 0;
        B = 0;
        Cin = 0;

        #80;

        $finish;

    end

    always 
        #10 A = ~A;

    always
        #20 B = ~B;
    
    always
        #40 Cin = ~Cin;


    always @(A,B, Cin) begin
        #1;
        $display("A:%b, B:%b, Cin:%b => S:%b, Cout:%b", A, B, Cin, S, Cout);
    end

    initial begin
        // Output file name
        $dumpfile("output_full_adderVCD.vcd");
        // Module to capture and what level, 0 means all wires
        $dumpvars (0, full_adder_tb);
    end

endmodule
