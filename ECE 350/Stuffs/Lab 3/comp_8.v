module comp_8(EQ1, GT1, A, B, EQ0, GT0);
    input EQ1, GT1;
    input [7:0] A, B;
    output EQ0, GT0;

    wire a, apple;
    comp_2 sally(.EQ1(EQ1), .GT1(GT1), .A(A[7:6]), .B(B[7:6]), .EQ0(a), .GT0(apple));

    wire bartholemew, boy;
    comp_2 bozo(.EQ1(a), .GT1(apple), .A(A[5:4]), .B(B[5:4]), .EQ0(bartholemew), .GT0(boy));

    wire crumbs, crumbss;
    comp_2 crumbsss(.EQ1(bartholemew), .GT1(boy), .A(A[3:2]), .B(B[3:2]), .EQ0(crumbs), .GT0(crumbss));

    comp_2 drockmortonIII(.EQ1(crumbs), .GT1(crumbss), .A(A[1:0]), .B(B[1:0]), .EQ0(EQ0), .GT0(GT0));

endmodule