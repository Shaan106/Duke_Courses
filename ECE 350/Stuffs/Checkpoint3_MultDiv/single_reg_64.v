module single_reg_64 (q, d, clk, en, clr);
   
   //Inputs
   input[63:0] d;
   input clk, en, clr;
   
   //Internal wire
   wire clr;

   //Output
   output[63:0] q;

    //generating 32 flip flops as part of one register.
   genvar i;
   generate
        for (i = 0; i <= 63; i = i + 1) begin: loop1

            dffe_ref d_flip_flop(.q(q[i]), .d(d[i]), .clk(clk), .en(en), .clr(clr));

        end

   endgenerate

endmodule