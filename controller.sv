module controller
(
    input  logic [6:0]    opcode,
    input  logic [6:0]     func7,
    input  logic [2:0]     func3,
    output logic           rf_en,
    output logic           rd_en,
    output logic           wr_en,
    output logic       sel_opr_a,
    output logic       sel_opr_b,
    output logic [3:0]     aluop,
    output logic [2:0]   br_type,
    output logic [2:0]  mem_type,
    output logic [1:0]    sel_wb,
    output logic [2:0]  imm_type,
    output logic          csr_rd,   // Ctrl signal for read
    output logic          csr_wr,   // Ctrl signal for write
    output logic          is_mret   // Ctrl signal for 'mret' instruction 
);
 
    always_comb
    begin
        case(opcode)
            7'b0110011: //R-Type
            begin

                rf_en = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;
                
                // mux Ctrls
                sel_opr_a = 1'b0;
                sel_opr_b = 1'b0;
                sel_wb    = 2'b00;

                // imm ctrls
                imm_type  = 3'b000;
                br_type   = 3'b110;

                case(func3)
                    3'b000: 
                    begin
                        case(func7)
                            7'b0000000: aluop = 4'b0000; //ADD
                            7'b0100000: aluop = 4'b0001; //SUB
                        endcase
                    end
                    3'b001: aluop = 4'b0010;             //SLL
                    3'b010: aluop = 4'b0011;             //SLT
                    3'b011: aluop = 4'b0100;             //SLTU
                    3'b100: aluop = 4'b0101;             //XOR
                    3'b101:
                    begin
                        case(func7)
                            7'b0000000: aluop = 4'b0110; //SRL
                            7'b0100000: aluop = 4'b0111; //SRA
                        endcase
                    end
                    3'b110: aluop = 4'b1000;             //OR
                    3'b111: aluop = 4'b1001;             //AND
                endcase
            end

            7'b0010011: //I-Type
            begin
                rf_en = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;
                // mux Ctrls
                sel_opr_a = 1'b0;
                sel_opr_b = 1'b1;
                sel_wb    = 2'b00;

                // imm ctrls
                imm_type  = 3'b000;


                case (func3)
                    3'b000: aluop = 4'b0000;             //ADDI
                    3'b001: aluop = 4'b0010;             //SLLI
                    3'b010: aluop = 4'b0011;             //SLTI
                    3'b011: aluop = 4'b0100;             //SLTUI
                    3'b100: aluop = 4'b0101;             //XORI
                    3'b101:
                    begin
                        case (func7)
                            7'b0000000: aluop = 4'b0110; //SRL
                            7'b0100000: aluop = 4'b0111; //SRA
                        endcase    
                    end
                    3'b110: aluop = 4'b1000;             //ORI
                    3'b111: aluop = 4'b1001;             //ANDI

                    
                endcase
            end

            // I-Type Jump
            7'b1100111:
            begin
                // mem ctrls
                rf_en = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;
                
                // mux Ctrls
                sel_opr_a = 1'b0;
                sel_opr_b = 1'b1;
                sel_wb    = 2'b10;

                // imm ctrls
                imm_type  = 3'b000;

                // op ctrls
                aluop = 4'b0000; // add
                br_type = 3'b111;  
            end
            // S-type
            7'b0100011: // S-type
            begin
                // mem ctrls
                rf_en = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b1;

                // mux Ctrls
                sel_opr_a = 1'b0;
                sel_opr_b = 1'b1;
                sel_wb    = 2'b11;

                // imm ctrls
                imm_type  = 3'b100;

                // op ctrls
                aluop = 4'b0000; // add
                case (func3)
                3'b000: mem_type = 3'b000;
                3'b001: mem_type = 3'b001;
                3'b010: mem_type = 3'b010;
                endcase

            end
            // L-type
            7'b0000011: // L-type
            begin
                // mem ctrls
                rf_en = 1'b1;
                rd_en = 1'b1;
                wr_en = 1'b0;

                // mux Ctrls
                sel_opr_a = 1'b0;
                sel_opr_b = 1'b1;
                sel_wb    = 2'b01;

                // imm ctrls
                imm_type  = 3'b000;

                // op ctrls
                aluop = 4'b0000; // add
                case (func3)
                3'b000: mem_type = 3'b000;
                3'b001: mem_type = 3'b001;
                3'b010: mem_type = 3'b010;
                3'b100: mem_type = 3'b011;
                3'b101: mem_type = 3'b100;
                endcase

            end

            // J-Type
            7'b1101111: // J-Type
            begin
                // mem ctrls
                rf_en = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;

                // mux Ctrls
                sel_opr_a = 1'b1;
                sel_opr_b = 1'b1;
                sel_wb    = 2'b10;

                // imm ctrls
                imm_type  = 3'b001;

                // op ctrls
                aluop = 4'b0000; // add
                br_type = 3'b111;
            end
            // LUI-Type
            7'b0110111: // U-Type
            begin
                // mem ctrls
                rf_en = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;

                // mux Ctrls
                sel_opr_a = 1'b0;
                sel_opr_b = 1'b1;
                sel_wb    = 2'b00;

                // imm ctrls
                imm_type  = 3'b010;

                // op ctrls
                aluop = 4'b1010; // add-U
            end
            // AUIPC-Type
            7'b0010111: // U-Type
            begin
                // mem ctrls
                rf_en = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;

                // mux Ctrls
                sel_opr_a = 1'b1;
                sel_opr_b = 1'b1;
                sel_wb    = 2'b00;

                // imm ctrls
                imm_type  = 3'b010;

                // op ctrls
                aluop = 4'b0000; // add-U
            end
            // B-Type
            7'b1100011:
            begin
                // mem ctrls
                rf_en = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b0;

                // mux Ctrls
                sel_opr_a = 1'b1;
                sel_opr_b = 1'b1;

                // imm ctrls
                imm_type  = 3'b011;

                // op ctrls
                aluop = 4'b0000;
                case (func3)
                3'b000: br_type = 3'b000;
                3'b001: br_type = 3'b001;
                3'b100: br_type = 3'b010;
                3'b101: br_type = 3'b011;
                3'b110: br_type = 3'b100;
                3'b111: br_type = 3'b101;
                endcase
            end
            7'b1110011: // CSR
            begin
                case (func3)
                3'b000: // CSRRW
                    begin
                        // csr mem ctrls
                        rf_en = 1'b1;
                        rd_en = 1'b0;
                        wr_en = 1'b0;

                        // csr mux Ctrls
                        sel_opr_a = 1'b0;
                        sel_opr_b = 1'b1;
                        sel_wb    = 2'b11;

                        // csr imm ctrls
                        imm_type  = 3'b000;

                        //csr reg
                        csr_rd       = 1'b1;
                        csr_wr       = 1'b1;
                        is_mret      = 1'b0;
                        aluop        = 4'b1010;
                    end

                default:
                    begin
                        // csr mem ctrls
                        rf_en = 1'b0;
                        rd_en = 1'b0;
                        wr_en = 1'b0;

                        // csr mux Ctrls
                        sel_opr_a = 1'b0;
                        sel_opr_b = 1'b1;
                        sel_wb    = 2'b11;

                        // csr imm ctrls
                        imm_type  = 3'b000;
                        
                        // csr reg
                        csr_rd       = 1'b0;
                        csr_wr       = 1'b0;
                        is_mret      = 1'b1;
                    end
                endcase
            end

            default:
            begin
                 // mem ctrls
                rf_en = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b0;

                // mux Ctrls
                sel_opr_a = 1'b0;
                sel_opr_b = 1'b0;
                sel_wb    = 2'b00;

                // imm ctrls
                imm_type  = 3'b000;

                //csr reg
                csr_rd       = 1'b0;
                csr_wr       = 1'b0;
                
            end
        endcase
    end

endmodule
