# **8-bit Vedic Multiplier with Sign Detection for High-Speed DSP**

## **Project Overview**
This project implements an enhanced **8-bit Vedic multiplier** with an integrated **sign detection module**, designed in **SystemVerilog** for **high-speed, low-power digital signal processing (DSP)** applications, such as convolution. The design uses **pipelining** to maximize throughput, and verification is carried out using **QuestaSim** via a dedicated testbench named `sign_mul_tb`.

## **Key Features**
- **Signed Multiplication Support**: Handles both positive and negative operands using an integrated sign detection module.
- **Vedic Multiplication Core**: Based on Urdhva Tiryagbhyam Sutra, optimized for 8x8-bit multiplication.
- **Pipelined Architecture**: Enhances performance and supports continuous operand input.
- **SystemVerilog RTL**: Clean, synthesizable modules suitable for FPGA/ASIC.
- **QuestaSim Verification**: Uses `sign_mul_tb` to verify signed multiplication correctness and pipeline behavior.

## **Technology Stack**
- **Design Language**: SystemVerilog
- **Verification Tool**: QuestaSim
- **Domain**: Digital Signal Processing (DSP), Convolution
- **Design Goals**: Speed, low power, signed operand handling

## **How It Works**
1. Inputs are two 8-bit signed operands.
2. The **sign detection module** preprocesses the inputs to determine sign and adjusts operands.
3. The **Vedic multiplier** performs unsigned multiplication on absolute values.
4. The result is post-processed to reapply the correct sign.
5. A pipelined architecture ensures continuous and fast operation.
6. **Testbench `sign_mul_tb`** applies both positive and negative test vectors to verify correctness.

## **File Structure**
- `vedic_multiplier.sv`: RTL code for the unsigned Vedic multiplier core.
- `sign_detection.sv`: Module to detect and manage signed operands.
- `sign_mul_wrapper.sv`: Top-level module integrating sign detection and Vedic core.
- `sign_mul_tb.sv`: SystemVerilog testbench used for QuestaSim simulation.
- `run.do`: QuestaSim script to compile and simulate the testbench.
- `wave.do` *(optional)*: Script to configure waveform views for analysis.

## **Setup & Usage**
1. Launch **QuestaSim**.
2. Run: `vlog vedic_multiplier.sv sign_detection.sv sign_mul_wrapper.sv sign_mul_tb.sv`
3. Start simulation: `vsim work.sign_mul_tb`
4. (Optional) Load waveforms: `do wave.do`
5. Observe waveform and output logs to verify signed multiplication behavior.

## **Responsibilities**
- Designed and implemented an 8-bit **signed Vedic multiplier** with pipelined optimization.
- Developed a **sign detection module** for signed operand support.
- Built and executed `sign_mul_tb` testbench in QuestaSim.
- Verified functionality across a wide range of signed and unsigned test vectors.

## **Conclusion**
This project showcases a complete **signed 8-bit Vedic multiplier** tailored for DSP pipelines. By combining fast arithmetic with proper sign handling and thorough simulation using **QuestaSim**, the design is efficient, scalable, and robust for real-world signal processing tasks.
