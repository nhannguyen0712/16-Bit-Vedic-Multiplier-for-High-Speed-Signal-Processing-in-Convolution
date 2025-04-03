module vedic_multiplier_4x4(
    input logic [3:0] A, 
    input logic [3:0] B, 
    output logic [7:0] P 
);

logic [3:0] P1,P2,P3,P4;
logic [3:0] sum_out1,sum_out2;
logic carry_out1,carry_out2;
logic [3:0] sum_RCA;
logic Cout_RCA;
logic half_sum,half_cout;

Vedic_multiplier_2x2 VE21 (.A(A[1:0]), .B(B[1:0]), .P(P1));
Vedic_multiplier_2x2 VE22 (.A(A[1:0]), .B(B[3:2]), .P(P2));
Vedic_multiplier_2x2 VE23 (.A(A[3:2]), .B(B[1:0]), .P(P3));
Vedic_multiplier_2x2 VE24 (.A(A[3:2]), .B(B[3:2]), .P(P4));

ripple_carry_adder_4x4 RCA1 (.A(P2) ,.B(P3) ,.Cin(1'b0) ,.Sum(sum_out1) ,.Cout(carry_out1));
ripple_carry_adder_4x4 RCA2 (.A({2'b00,P1[3:2]}) ,.B(sum_out1) ,.Cin(1'b0) ,.Sum(sum_out2) ,.Cout(carry_out2));

half_adder HA (.A(carry_out2) ,.B(carry_out1) ,.Sum(half_sum) ,.Cout(half_cout));

ripple_carry_adder_4x4 RCA3 (.A({half_cout, half_sum, sum_out2[3:2]}) ,.B(P4) ,.Cin(1'b0) ,.Sum(sum_RCA) ,.Cout(Cout_RCA));




assign P[1:0] = P1[1:0];
assign P[3:2] = sum_out2[1:0];
assign P[7:4] = sum_RCA;



endmodule 