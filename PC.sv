// In RISC-V XLEn denotes bits of CPU. XLEN=32

module PC 
(
    input  logic        clk,
    input  logic        rst,
    input  logic        en,
    input  logic [31:0] pc_in,
    output logic [31:0] pc_out
);

    always_ff @(posedge clk) 
    begin 
        if (rst)
        begin
            pc_out <= 0;
        end
        else if (en)
        begin
            pc_out <= pc_in;
        end
    end    

endmodule