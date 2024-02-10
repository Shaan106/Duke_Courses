### Dedicated to Will Denton.

inputLen = 32 # length of X & Y 
outputLen = inputLen*2

## Base case row = 0


print('''

module wallaceTreeMultiplier(
data_operandA, data_operandB, 
clock, 
data_result, data_exception, data_resultRDY);

input [''' + str(inputLen-1) + ''':0] data_operandA, data_operandB;
input clock;

output [''' + str((2*inputLen)-1) + ''':0] data_result;
output data_exception, data_resultRDY;

assign data_resultRDY = 1'b0;
      ''')

wireStr = "wire "
assignStr = ""

assignOutputStr = ""

for bit in range(0, inputLen+0+1): # for each bit 
    if (bit < inputLen+0):
        wireStr += "w_" + str(0) + "_" + str(bit) + ", "
    else:
        wireStr += "w_" + str(0) + "_" + str(bit) + ";"

    if (bit != inputLen):
        assignStr += "assign w_" + str(0) + "_" + str(bit) + " = data_operandA[0] & data_operandB[" + str(bit) + "];\n"
    else:
        assignStr += "assign w_" + str(0) + "_" + str(bit) + " = 1'b0;\n"

assignOutputStr += "assign data_result[0] = w_0_0;\n"

print("// BASE CASE BASE CASE")
print(wireStr)
print()
print(assignStr)
print()

for row in range(1, inputLen): # for each row (ie each bit of Y)


    #Printing wires
    wireStr = "wire w_" + str(row) + "_" + str(inputLen+row) + ", "
    coutStr = "wire "
    fullAdderStr = ""
    for bit in range(row, inputLen+row): # for each bit 

        # has form w_{row}_{bit}

        wStr = "w_" + str(row) + "_" + str(bit)
        cStr = "c_" + str(row) + "_" + str(bit)

        if (bit < inputLen+row - 1):            
            wireStr += "w_" + str(row) + "_" + str(bit) + ", "
            coutStr += "c_" + str(row) + "_" + str(bit) + ", "
        else:
            wireStr += "w_" + str(row) + "_" + str(bit) + ";"
            coutStr += "c_" + str(row) + "_" + str(bit) + ";"
        
        if (bit == inputLen+row-1):
            fullAdderStr += "full_adder add_" + wStr + "(.S(" + wStr + "), .Cout("+ "w_" + str(row) + "_" + str(inputLen+row) + "),  .A(" + "w_" + str(row-1) + "_" + str(bit) + "), .B(data_operandA[" + str(row) + "] & data_operandB[" + str(bit-row) + "]), .Cin(" + "c_" + str(row) + "_" + str(bit-1) + "));\n"
        elif (bit != row):
            fullAdderStr += "full_adder add_" + wStr + "(.S(" + wStr + "), .Cout("+ cStr + "),  .A(" + "w_" + str(row-1) + "_" + str(bit) + "), .B(data_operandA[" + str(row) + "] & data_operandB[" + str(bit-row) + "]), .Cin(" + "c_" + str(row) + "_" + str(bit-1) + "));\n"
        else:
            fullAdderStr += "full_adder add_" + wStr + "(.S(" + wStr + "), .Cout("+ cStr + "),  .A(" + "w_" + str(row-1) + "_" + str(bit) + "), .B(data_operandA[" + str(row) + "] & data_operandB[" + str(bit-row) + "]), .Cin(1'b0));\n"
        
        if (bit == row):
            assignOutputStr += "assign data_result[" + str(row) + "] = " + wStr + ";\n"

    print("// these are my wires that have the result of each full adder")
    print(wireStr)
    print()
    print("// these are my carry outs (I know I don't need these many but it made the python code easier)")
    print(coutStr)
    print()
    print(fullAdderStr)
    print()
    print()


for zIndex in range(inputLen, outputLen):

    assignOutputStr += "assign data_result[" + str(zIndex) + "] = w_" + str(inputLen-1) + "_" + str(zIndex) + ";\n"

    # assign data_result[3] = w_3_3;

print(assignOutputStr)

print("endmodule")



'''
    wire w_0_0, w_0_1, w_0_2;
    wire cout_row0;

    assign w_0_0 = data_operandA[0] & data_operandB[0];
    assign w_0_1 = data_operandA[0] & data_operandB[1];
    assign w_0_2 = data_operandA[0] & data_operandB[2];
    assign w_0_3 = data_operandA[0] & data_operandB[3];
    assign cout_row0 = 1'b0;

    // row 0 done, z[0] = w_0_0
    // if i == j then assign z[i] = w_i_i

    wire w_1_1, w_1_2, w_1_3, w_1_4;
    wire cout_row1;
    wire c_1_1, c_1_2, c_1_3;
    
    full_adder add_w_1_1(.S(w_1_1), .Cout(c_1_1),  .A(w_0_1), .B(data_operandA[1] & data_operandB[0]), .Cin(1'b0) );

    full_adder add_w_1_2(.S(w_1_2), .Cout(c_1_2),  .A(w_0_2), .B(data_operandA[1] & data_operandB[1]), .Cin(c_1_1));
    full_adder add_w_1_3(.S(w_1_3), .Cout(c_1_3),  .A(w_0_3), .B(data_operandA[1] & data_operandB[2]), .Cin(c_1_2));

    full_adder add_w_1_4(.S(w_1_4), .Cout(cout_row1),  .A(cout_row0), .B(data_operandA[1] & data_operandB[3]), .Cin(c_1_3));

    // row 1 done

    wire w_2_2, w_2_3, w_2_4, w_2_5, w_2_6; // add (r+1)_(i+1)
    wire cout_row2;
    wire c_2_2, c_2_3, c_2_4; //same as above
    
    full_adder add_w_2_2(.S(w_2_2), .Cout(c_2_2),  .A(w_1_2), .B(data_operandA[2] & data_operandB[0]), .Cin(1'b0) );
    
    full_adder add_w_2_3(.S(w_2_3), .Cout(c_2_3),  .A(w_1_3), .B(data_operandA[2] & data_operandB[1]), .Cin(c_2_2));
    full_adder add_w_2_4(.S(w_2_4), .Cout(c_2_4),  .A(w_1_4), .B(data_operandA[2] & data_operandB[2]), .Cin(c_2_3));

    //last 2 bits to add are the prev rows last carry 
    full_adder add_w_2_5(.S(w_2_5), .Cout(cout_row2),  .A(cout_row1), .B(data_operandA[2] & data_operandB[3]), .Cin(c_2_4));

    // row 2 done

    wire w_3_3, w_3_4, w_3_5, w_3_6; // add (r+1)_(i+1)
    wire cout_row3;
    wire c_3_3, c_3_4, c_3_5; //same as above
    
    full_adder add_w_3_3(.S(w_3_3), .Cout(c_3_3),  .A(w_2_3), .B(data_operandA[3] & data_operandB[0]), .Cin(1'b0) );
    
    full_adder add_w_3_4(.S(w_3_4), .Cout(c_3_4),  .A(w_2_4), .B(data_operandA[3] & data_operandB[1]), .Cin(c_3_3));
    full_adder add_w_3_5(.S(w_3_5), .Cout(c_3_5),  .A(w_2_5), .B(data_operandA[3] & data_operandB[2]), .Cin(c_3_4));

    //last 2 bits to add are the prev rows last carry 
    full_adder add_w_3_6(.S(w_3_6), .Cout(cout_row3),  .A(cout_row2), .B(data_operandA[3] & data_operandB[3]), .Cin(c_3_5));

    //row 3 done

    // assigning to outputs

    assign data_result[0] = w_0_0;
    assign data_result[1] = w_1_1;
    assign data_result[2] = w_2_2;
    assign data_result[3] = w_3_3;

    assign data_result[4] = w_3_4;
    assign data_result[5] = w_3_5;
    assign data_result[6] = w_3_6;

    assign data_result[7] = cout_row3;

'''