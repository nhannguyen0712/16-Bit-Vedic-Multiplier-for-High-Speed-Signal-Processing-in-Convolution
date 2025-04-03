module Vedic_multiplier_8x8 (
    input  logic signed [7:0] A,  // signed 8-bit input A
    input  logic signed [7:0] B,  // signed 8-bit input B
    output logic signed [15:0] P  // signed 16-bit output product
);

	 logic signed [8:0] A_ext_0 = {{1{A[7]}}, A[3:0]}; // Correct sign-extension for A[3:0]
	 logic signed [8:0] A_ext_1 = {{1{A[7]}}, A[7:4]}; // Correct sign-extension for A[7:4]
	 logic signed [8:0] B_ext_0 = {{1{B[7]}}, B[3:0]}; // Correct sign-extension for B[3:0]
	 logic signed [8:0] B_ext_1 = {{1{B[7]}}, B[7:4]}; // Correct sign-extension for B[7:4]


    logic [7:0] m1, m2, m3, m4;
    logic signed [7:0] sum1, sum2, sum3;
    logic carry1, carry2, carry3;

    
    signed_vedic_multiplier_4x4 V1 (.A(A_ext_0[3:0]), .B(B_ext_0[3:0]), .P(m1));
    signed_vedic_multiplier_4x4 V2 (.A(A_ext_1[3:0]), .B(B_ext_0[3:0]), .P(m2));
    signed_vedic_multiplier_4x4 V3 (.A(A_ext_0[3:0]), .B(B_ext_1[3:0]), .P(m3));
    signed_vedic_multiplier_4x4 V4 (.A(A_ext_1[3:0]), .B(B_ext_1[3:0]), .P(m4));

	 
    ripple_carry_adder_8x8 RCA1 (.A(m2), .B(m3), .Sum(sum1), .Cout(carry1));             
    ripple_carry_adder_8x8 RCA2 (.A({4'b0000, m1[7:4]}), .B(sum1), .Sum(sum2), .Cout(carry2));
    ripple_carry_adder_8x8 RCA3 (.A({3'b000, sum2[7:4], carry1}), .B(m4), .Sum(sum3), .Cout(carry3));  

    
    assign P[3:0] = m1[3:0];         
    assign P[7:4] = sum2[3:0];       
    assign P[15:8] = sum3;           
endmodule