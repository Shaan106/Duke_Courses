module NAND_1bitAdder(Sout, Cout, A, B, Cin);
    input A, B, Cin;
    output Sout, Cout;

    wire w1, w2, w3, w4, w5, w6, w7;

    nand nand1(w1, A, B);

    nand nand2(w2, A, w1);

    nand nand3(w3, w1, B);

    nand nand4(w4, w2, w3);

    nand nand7(w7, w4, Cin);

    nand nand5(w5, w4, w7);

    nand nand6(w6, w7, Cin);

    nand nandSout(Sout, w5, w6);

    nand nandCout(Cout, w1, w7);
    
endmodule
