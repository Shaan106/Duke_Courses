`timescale  1 ns / 100 ps
module two_bit_adder_tb;

    //inputs
    wire [1:0] A, B;
    wire Cin;

    //outputs 
    wire [1:0] S;
    wire Cout;

    //instantiate
    two_bit_adder adder(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

    integer i;

    assign {Cin, A, B} = i[4:0];

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            #20;
            $display("A:%b, B:%b, Cin:%b => S:%b, Cout:%b", A, B, Cin, S, Cout);
        end
        $finish;
    end

    initial begin
        // Output file name
        $dumpfile("output_two_bit_adderVCD.vcd");
        // Module to capture and what level, 0 means all wires
        $dumpvars (0, two_bit_adder_tb);
    end

endmodule