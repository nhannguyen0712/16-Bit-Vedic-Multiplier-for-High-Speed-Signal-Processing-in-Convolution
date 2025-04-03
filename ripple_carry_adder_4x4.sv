module ripple_carry_adder_4x4 (
    input logic [3:0] A,       
    input logic [3:0] B,       
    input logic Cin,           
    output logic [3:0] Sum,    
    output logic Cout         
);
    logic [3:1] Carry;    

    // Instantiate Full Adders for 4-bit Ripple Carry Adder
    full_adder FA0 (.A(A[0]), .B(B[0]), .Cin(1'b0),       .Sum(Sum[0]), .Cout(Carry[1]));
    full_adder FA1 (.A(A[1]), .B(B[1]), .Cin(Carry[1]),  .Sum(Sum[1]), .Cout(Carry[2]));
    full_adder FA2 (.A(A[2]), .B(B[2]), .Cin(Carry[2]),  .Sum(Sum[2]), .Cout(Carry[3]));
    full_adder FA3 (.A(A[3]), .B(B[3]), .Cin(Carry[3]),  .Sum(Sum[3]), .Cout(Cout));

endmodule
