module systolic_array (
  input wire clk,
  input wire rst,
  input wire [15:0] inp_west_0,
  input wire [15:0] inp_west_1,
  input wire [15:0] inp_west_2,
  input wire [15:0] inp_west_3,
  input wire [15:0] inp_north_0,
  input wire [15:0] inp_north_1,
  input wire [15:0] inp_north_2,
  input wire [15:0] inp_north_3,
  input wire [3:0] size,
  input wire done,
  output reg [15:0] [15:0] final_result
);

  // 16 east, south, and result output ports
  wire [15:0] outp_south_0_0, outp_south_0_1, outp_south_0_2, outp_south_0_3;
  wire [15:0] outp_east_0_0, outp_east_0_1, outp_east_0_2, outp_east_0_3;
  wire [31:0] result_0_0, result_0_1, result_0_2, result_0_3;

  wire [15:0] outp_south_1_0, outp_south_1_1, outp_south_1_2, outp_south_1_3;
  wire [15:0] outp_east_1_0, outp_east_1_1, outp_east_1_2, outp_east_1_3;
  wire [31:0] result_1_0, result_1_1, result_1_2, result_1_3;

  wire [15:0] outp_south_2_0, outp_south_2_1, outp_south_2_2, outp_south_2_3;
  wire [15:0] outp_east_2_0, outp_east_2_1, outp_east_2_2, outp_east_2_3;
  wire [31:0] result_2_0, result_2_1, result_2_2, result_2_3;

  wire [15:0] outp_south_3_0, outp_south_3_1, outp_south_3_2, outp_south_3_3;
  wire [15:0] outp_east_3_0, outp_east_3_1, outp_east_3_2, outp_east_3_3;
  wire [31:0] result_3_0, result_3_1, result_3_2, result_3_3;

  reg [3:0] count = 0;

  // Instantiate 16 blocks, where each block gets input from its west and north neighbors
  block P0_0 (
    .inp_north(inp_north_0),
    .inp_west(inp_west_0),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_0_0),
    .outp_east(outp_east_0_0),
    .result(result_0_0)
  );

  block P0_1 (
    .inp_north(inp_north_1),
    .inp_west(outp_east_0_0),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_0_1),
    .outp_east(outp_east_0_1),
    .result(result_0_1)
  );

  block P0_2 (
    .inp_north(inp_north_2),
    .inp_west(outp_east_0_1),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_0_2),
    .outp_east(outp_east_0_2),
    .result(result_0_2)
  );

  block P0_3 (
    .inp_north(inp_north_3),
    .inp_west(outp_east_0_2),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_0_3),
    .outp_east(outp_east_0_3),
    .result(result_0_3)
  );

  block P1_0 (
    .inp_north(outp_south_0_0),
    .inp_west(inp_west_1),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_1_0),
    .outp_east(outp_east_1_0),
    .result(result_1_0)
  );

  block P1_1 (
    .inp_north(outp_south_0_1),
    .inp_west(outp_east_1_0),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_1_1),
    .outp_east(outp_east_1_1),
    .result(result_1_1)
  );

  block P1_2 (
    .inp_north(outp_south_0_2),
    .inp_west(outp_east_1_1),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_1_2),
    .outp_east(outp_east_1_2),
    .result(result_1_2)
  );

  block P1_3 (
    .inp_north(outp_south_0_3),
    .inp_west(outp_east_1_2),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_1_3),
    .outp_east(outp_east_1_3),
    .result(result_1_3)
  );

  block P2_0 (
    .inp_north(outp_south_1_0),
    .inp_west(inp_west_2),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_2_0),
    .outp_east(outp_east_2_0),
    .result(result_2_0)
  );

  block P2_1 (
    .inp_north(outp_south_1_1),
    .inp_west(outp_east_2_0),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_2_1),
    .outp_east(outp_east_2_1),
    .result(result_2_1)
  );

  block P2_2 (
    .inp_north(outp_south_1_2),
    .inp_west(outp_east_2_1),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_2_2),
    .outp_east(outp_east_2_2),
    .result(result_2_2)
  );

  block P2_3 (
    .inp_north(outp_south_1_3),
    .inp_west(outp_east_2_2),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_2_3),
    .outp_east(outp_east_2_3),
    .result(result_2_3)
  );

  block P3_0 (
    .inp_north(outp_south_2_0),
    .inp_west(inp_west_3),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_3_0),
    .outp_east(outp_east_3_0),
    .result(result_3_0)
  );

  block P3_1 (
    .inp_north(outp_south_2_1),
    .inp_west(outp_east_3_0),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_3_1),
    .outp_east(outp_east_3_1),
    .result(result_3_1)
  );

  block P3_2 (
    .inp_north(outp_south_2_2),
    .inp_west(outp_east_3_1),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_3_2),
    .outp_east(outp_east_3_2),
    .result(result_3_2)
  );

  block P3_3 (
    .inp_north(outp_south_2_3),
    .inp_west(outp_east_3_2),
    .clk(clk),
    .rst(rst),
    .outp_south(outp_south_3_3),
    .outp_east(outp_east_3_3),
    .result(result_3_3)
  );

  parameter IDLE = 3'b000;
  parameter CALCULATE = 3'b001;
  parameter DONE = 3'b010;

  reg [2:0] state = IDLE;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      count <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (size != 0) begin
            count <= 3 + size;
            state <= CALCULATE;
          end
        end

        CALCULATE: begin
          count <= count - 1;
          if (count == 0) begin
            state <= DONE;
          end
        end

        DONE: begin
          final_result[0] <= result_0_0;
          final_result[1] <= result_0_1;
          final_result[2] <= result_0_2;
          final_result[3] <= result_0_3;
          final_result[4] <= result_1_0;
          final_result[5] <= result_1_1;
          final_result[6] <= result_1_2;
          final_result[7] <= result_1_3;
          final_result[8] <= result_2_0;
          final_result[9] <= result_2_1;
          final_result[10] <= result_2_2;
          final_result[11] <= result_2_3;
          final_result[12] <= result_3_0;
          final_result[13] <= result_3_1;
          final_result[14] <= result_3_2;
          final_result[15] <= result_3_3;
          state <= IDLE;
        end
    endcase

    end
  end

endmodule
