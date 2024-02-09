module two_bit_adder (
    S,
    Cout,
    A,
    B,
    Cin
);
    
    input [1:0] A, B;
    input Cin;

    output [1:0] S;
    output Cout;

    wire w1;

    full_adder adder1(.S(S[0]), .Cout(w1), .A(A[0]), .B(B[0]), .Cin(Cin));

    full_adder adder2(.S(S[1]), .Cout(Cout), .A(A[1]), .B(B[1]), .Cin(w1));

endmodule