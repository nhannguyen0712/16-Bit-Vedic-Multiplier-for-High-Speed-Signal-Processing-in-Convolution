module Vedic_multiplier_8x8 (
	input logic clk,rst_n,
	input  logic [7:0] A,  
	input  logic [7:0] B,  
	output logic [15:0] P  
);

logic [3:0] m1_reg1 , m1_reg2 , m1_reg3 , m1_reg4 ;
logic [7:0] m2_reg , m3_reg             ;
logic [7:0] m4_reg1, m4_reg2            ;
logic [7:0] sum1_reg, sum2_reg_1, sum2_reg_2         ;
logic carry1_reg                        ;
logic [7:0] ripple_adder2_input_A       ;
logic [7:0] ripple_adder3_input_A       ;
logic [7:0] m1, m2, m3, m4              ;
logic [7:0] sum1, sum2, sum3            ;
logic carry1, carry2, carry3            ;

    // Instantiate 4x4 Vedic Multipliers
vedic_multiplier_4x4 V1 (.A(A[3:0]),  .B(B[3:0]),  .P(m1));
vedic_multiplier_4x4 V2 (.A(A[3:0]),  .B(B[7:4]),  .P(m2));
vedic_multiplier_4x4 V3 (.A(A[7:4]),  .B(B[3:0]),  .P(m3));
vedic_multiplier_4x4 V4 (.A(A[7:4]),  .B(B[7:4]),  .P(m4));

    // Add partial products using Ripple Carry Adders (RCA)
ripple_carry_adder_8x8 RCA1 (.A(m2_reg), .B(m3_reg), .Sum(sum1), .Cout(carry1_reg))              ;
ripple_carry_adder_8x8 RCA2 (.A(ripple_adder2_input_A), .B(sum1_reg), .Sum(sum2), .Cout(carry2)) ;
ripple_carry_adder_8x8 RCA3 (.A(ripple_adder3_input_A), .B(m4_reg2), .Sum(sum3), .Cout(carry3)) ;
	 
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
           	 // Reset all pipeline registers
		m1_reg1 <= 4'b0; 
		m1_reg2 <= 4'b0; 
		m1_reg3 <= 4'b0;
		m1_reg4 <= 4'b0;
            	m2_reg <= 8'b0; 
		m3_reg <= 8'b0;
            	sum1_reg <= 8'b0; 
		sum2_reg_1 <= 8'b0; 
		sum2_reg_2 <= 8'b0;
            	m4_reg1 <= 8'b0;
		m4_reg2 <= 8'b0;
            	carry1_reg <= 1'b0;
				
        end else begin
		//stage 1 : get value for a1,b1 and output S(3..0)
		m1_reg1 <= m1[3:0];
		m1_reg4 <= m1[7:4];
		m1_reg2 <= m1_reg1;
		m1_reg3 <= m1_reg2;
		//stage 2 : get value for a2,b2,a3,b3 and Two 8-bit RCA sum 
		m2_reg <= m2;
		m3_reg <= m3;
		sum1_reg <= sum1;
		ripple_adder2_input_A <= {4'b0000,m1_reg4} ;
		sum2_reg_1 <= sum2[3:0];
		sum2_reg_2 <= sum2[7:4];
		//stage 3 : get value for a4,b4 and last RCA 
		m4_reg1 <= m4;
		m4_reg2 <= m4_reg1;
		carry1_reg <= carry1;
		ripple_adder3_input_A <= {carry1_reg, 3'b000, sum2_reg_2};
	end
end
				
// Assign final product bits
logic [15:0] P_reg;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n)
		P_reg <= 16'd0;
	else
		P_reg <= {sum3, sum2_reg_1, m1_reg3};
end

assign P = P_reg;
endmodule

