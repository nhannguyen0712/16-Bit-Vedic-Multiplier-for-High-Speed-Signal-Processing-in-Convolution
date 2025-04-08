`timescale 1ns / 1ps  // 1 ns time unit, 1 ps precision

module sign_mul_tb;

  // Inputs
  logic  signed [7:0] A;
  logic  signed [7:0] B;

  // Output
  logic signed [15:0] P;

  // Instantiate the Unit Under Test (UUT)
  sign_mul uut (
    .A(A),
    .B(B),
    .P(P)
  );

  
  initial begin
    // Test cases for A = 1 to 20, B = -1 to -10
    // Loop A from 1 to 20
    for (A = -30; A <= 30; A = A + 1) begin
      // Loop B from -1 to -10
      for (B = -1; B >= -10; B = B - 1) begin
        #10; // wait for 10 time units for the multiplication to happen
        $display("A: %d, B: %d, Product (P): %d", A, B, P);
      end
    end

    // Finish the simulation
    $finish;
  end


endmodule
