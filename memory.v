module memory (
  input wire clk,
  input wire [31:0] row,
  input wire [3:0] col,
  input wire [15:0] data_in,
  input wire en,
  output reg [15:0] data_out
);

  // Define memory array size
  reg [15:0] mem [31:0][3:0];

  // Read operation
  always @(posedge clk) begin
    if (!en) // Read operation when enable is not active
      data_out <= mem[row][col];
  end

  // Write operation
  always @(posedge clk) begin
    if (en) // Write operation when enable is active
    begin
      mem[row][col] <= data_in;
    end
  end

endmodule
