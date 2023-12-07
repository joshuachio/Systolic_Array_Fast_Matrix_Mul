module controller (
    input wire clk,
    input wire rst,

    output reg enA, enB, enI, enO,
    output reg [31:0] addrO_row, addrA_row, addrB_row, addrI_row,
    output reg [3:0] addrO_col, addrA_col, addrB_col, addrI_col,
    output reg [15:0] dataA, dataB, dataI, dataO,
    input wire [15:0] dataA_out, dataB_out, dataI_out, dataO_out,

    output reg [15:0] inp_north_0, inp_north_1, inp_north_2, inp_north_3,
    output reg [15:0] inp_west_0, inp_west_1, inp_west_2, inp_west_3,
    output reg [3:0] matrix_size,
    input wire [15:0] [15:0] final_result,

    output reg ap_done,
    input wire ap_start
);

    reg [3:0] current_col;
    reg [31:0] current_row;
    reg [2:0] state;
    reg [15:0] matrixA[0:32][0:3], matrixB[0:32][0:3]; // Internal storage for entire matrices
    reg [15:0] final_result_local[0:3][0:3];
    reg [3:0] local_size;
    reg [31:0]temp_output_row;
    reg [3:0]temp_output_col;

    parameter READ_INSTRUCTION = 3'b001;
    parameter READ_DATA = 3'b010;
    parameter UPDATE_ADDR = 3'b011;
    parameter COMPUTE = 3'b100;
    parameter IDLE = 3'b000;

    always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        current_col <= 0;
        current_row <= 0;
        matrix_size <= 0;
        inp_north_0 <= 0;
        inp_north_1 <= 0;
        inp_north_2 <= 0;
        inp_north_3 <= 0;
        inp_west_0 <= 0;
        inp_west_1 <= 0;
        inp_west_2 <= 0;
        inp_west_3 <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (ap_start) begin
                    state <= READ_INSTRUCTION;
                    current_col <= 0;
                    current_row <= 0;
                    addrA_col <= 0;
                    addrA_row <= 0;
                    addrB_col <= 0;
                    addrB_row <= 0;
                    addrO_col <= 0;
                    addrO_row <= 0;
                    addrI_col <= 0;
                    addrI_row <= 0;
                end
            end

            READ_INSTRUCTION: begin
                enI <= 0;
                local_size <= dataI_out;

                if (addrI_col < 4) begin
                    addrI_col <= addrI_col + 1;
                end else if (addrI_row < 32) begin
                    addrI_col <= 0;
                    addrI_row <= addrI_row + 1;
                end

                if (dataI_out == 0) begin
                    state <= IDLE;
                end else begin
                    addrA_row <= 0;
                    addrA_col <= 0;
                    addrB_row <= 0;
                    addrB_col <= 0;
                    state <= READ_DATA;
                end
            end

            READ_DATA: begin
                matrixA[addrA_row + addrA_col][addrA_col] <= memA.mem[addrA_row][addrA_col];
                matrixB[addrB_row + addrB_col][addrB_col] <= memB.mem[addrB_row][addrB_col];
                if (addrA_col < 3) begin
                    addrA_col <= addrA_col + 1;
                    addrB_col <= addrB_col + 1;
                end else if (addrA_row < local_size - 1) begin
                    addrA_col <= 0;
                    addrB_col <= 0;
                    addrA_row <= addrA_row + 1;
                    addrB_row <= addrB_row + 1;
                end else begin
                    state <= COMPUTE;
                    current_col <= 0;
                    current_row <= 0;
                end
            end
            
            COMPUTE: begin
                matrix_size <= local_size;
                if (current_row < local_size + 6) begin
                    if (current_row < local_size) begin
                        inp_north_0 <= matrixA[current_row][0];
                        inp_west_0 <= matrixB[current_row][0];
                    end else begin
                        inp_north_0 <= 0;
                        inp_west_0 <= 0;
                    end
                    if (current_row > 0 & current_row < local_size + 1) begin
                        inp_north_1 <= matrixA[current_row][1];
                        inp_west_1 <= matrixB[current_row][1];
                    end else begin
                        inp_north_1 <= 0;
                        inp_west_1 <= 0;
                    end
                    if (current_row > 1 & current_row < local_size + 2) begin
                        inp_north_2 <= matrixA[current_row][2];
                        inp_west_2 <= matrixB[current_row][2];
                    end else begin
                        inp_north_2 <= 0;
                        inp_west_2 <= 0;
                    end
                    if (current_row > 2 & current_row < local_size + 3) begin
                        inp_north_3 <= matrixA[current_row][3];
                        inp_west_3 <= matrixB[current_row][3];
                    end else begin
                        inp_north_3 <= 0;
                        inp_west_3 <= 0;
                    end

                    current_row <= current_row + 1;
                end else begin
                    enO <= 0;
                    memO.mem[0][0] <= final_result[0];
                    memO.mem[addrO_row][addrO_col] <= final_result[addrO_row * 4 + addrO_col];

                    if (addrO_col < 3) begin
                        addrO_col <= addrO_col + 1;
                    end else if (addrO_row < local_size - 1) begin
                        addrO_col <= 0;
                        addrO_row <= addrO_row + 1;
                    end else begin
                        ap_done <= 1;
                        state <= IDLE;
                    end
                end
            end
        
        endcase
    end
    end

endmodule