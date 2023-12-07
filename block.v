module block (
  input [15:0] inp_north,
  input [15:0] inp_west,
  input wire clk,
  input wire rst,
  output reg [15:0] outp_south,
  output reg [15:0] outp_east,
  output reg [31:0] result
);

  wire [31:0] multi;

  always @(posedge rst or posedge clk) begin
    if (rst) begin
      result <= 0;
      outp_east <= 0;
      outp_south <= 0;
    end
    else begin
      result <= result + multi;
      outp_east <= inp_west;
      outp_south <= inp_north;
    end
  end

  assign multi = inp_north * inp_west;

endmodule
