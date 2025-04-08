module sign_mul (
    input  logic signed [7:0] A,  // First signed 8-bit number
    input  logic signed [7:0] B,  // Second signed 8-bit number
    output logic signed [15:0] P  // Product of the multiplication
);

    logic signed [7:0] A_corrected, B_corrected;
    logic signed [15:0] product;

    always_comb begin
        if (A[7] == 1'b1)  // A is negative
            A_corrected = ~A + 1;  // 2's complement of A
        else
            A_corrected = A;  // A is positive, no change
        
        if (B[7] == 1'b1)  // B is negative
            B_corrected = ~B + 1;  // 2's complement of B
        else
            B_corrected = B;  // B is positive, no change
    end

    Vedic_multiplier_8x8 Vedic_inst (
        .A(A_corrected),
        .B(B_corrected),
        .P(product)
    );

    always_comb begin
        if (A[7] ^ B[7])  // If A and B have different signs
            P = -product;  // Negative product
        else
            P = product;  // Positive product (both negative or both positive)
    end

endmodule
