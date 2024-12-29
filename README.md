# Three-Stage Pipeline RISC-V Processor in SystemVerilog

## Introduction
This GitHub repository is home to a three-stage pipeline RISC-V processor. The processor is adept at managing control and data hazards and includes CSR read/write capabilities and a hazard detection unit. The implementation is in SystemVerilog, using ModelSim and GTKWave as the primary tools for simulation and waveform analysis.

## Features
- **Three-Stage Pipeline Architecture:** Comprising Fetch, Decode and Execute, and Memory and Write Back stages.
- **CSR Read/Write Operations:** Provides dynamic control over processor operations through CSRs.
- **Hazard Detection Unit:** Integrated unit for identifying and resolving control and data hazards.

## Implementation Details
- **Language:** Implemented in SystemVerilog.
- **Tools:**
  - **ModelSim:** For simulation.
  - **GTKWave:** For waveform analysis.
- **Modules:**
  - `Branch_comp.sv`: Branch comparison logic.
  - `PC.sv`: Program Counter module.
  - `Processor.sv`: Main processor module.
  - `alu.sv`: Arithmetic Logic Unit.
  - `controller.sv`: Control unit.
  - `csr_reg.sv`: CSR Register module.
  - `data_mem.sv`: Data Memory module.
  - `hazard_detection.sv`: Hazard Detection unit.
  - `imm_gen.sv`: Immediate Generator.
  - `inst_decode.sv`: Instruction Decoder.
  - `inst_mem.sv`: Instruction Memory module.
  - `interupt.sv`: Interrupt handling module.
  - `reg_file.sv`: Register File module.
  - `tb_processor.sv`: Testbench for the processor.
- **Testing:** SystemVerilog testbenches are provided for simulation and verification.
