`timescale  1 ns / 100 ps

module NAND_1bitAdder_tb;

    /// Module Instanstiation 
    // inputs to module (reg)
    reg A, B, Cin;

    // OUTPUTS OF THE MODULE (WIRE)
    wire Sout, Cout;

    NAND_1bitAdder nand_adder(.Sout(Sout), .Cout(Cout), .A(A), .B(B), .Cin(Cin));
    

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
        $display("A:%b, B:%b, Cin:%b => S:%b, Cout:%b", A, B, Cin, Sout, Cout);
    end

endmodule
