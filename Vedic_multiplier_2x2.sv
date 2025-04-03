module Vedic_multiplier_2x2(
    input logic [1:0] A, 
    input logic [1:0] B, 
    output logic [3:0] P 
);

logic and00, and01 , and10 , and11;
logic S1,S2,Cout1,Cout2;

assign and00 = A[0] & B[0]; 
assign and01 = A[0] & B[1]; 
assign and10 = A[1] & B[0]; 
assign and11 = A[1] & B[1]; 

assign P[0] = and00;

half_adder HA1 (.A(and01), .B(and10), .Sum(S1), .Cout(Cout1));
half_adder HA2(.A(Cout1), .B(and11), .Sum(S2), .Cout(Cout2));

assign P[1] = S1;
assign P[2] = S2;
assign P[3] = Cout2;

endmodule

