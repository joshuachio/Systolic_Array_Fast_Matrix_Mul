module top_module(
    input wire clk,
    input wire rst,
    input wire enA, enB, enI, enO,
    input wire [31:0] addrO_row, addrA_row, addrB_row, addrI_row,
    input wire [3:0] addrO_col, addrA_col, addrB_col, addrI_col,
    input wire [15:0] dataA, dataB, dataI, dataO,
    input wire ap_done,
    input wire ap_start,
    input wire [15:0] dataA_out, dataB_out, dataI_out, dataO_out
);

    wire [15:0] inp_west_0, inp_west_1, inp_west_2, inp_west_3;
    wire [15:0] inp_north_0, inp_north_1, inp_north_2, inp_north_3;
    wire [3:0] matrix_size;
    wire [15:0] [15:0] final_result;

    memory memA (.clk(clk), .row(addrA_row), .col(addrA_col), .data_in(dataA), .en(enA), .data_out(dataA_out));
    memory memB (.clk(clk), .row(addrB_row), .col(addrB_col), .data_in(dataB), .en(enB), .data_out(dataB_out));
    memory memI (.clk(clk), .row(addrI_row), .col(addrI_col), .data_in(dataI), .en(enI), .data_out(dataI_out));
    memory memO (.clk(clk), .row(addrO_row), .col(addrO_col), .data_in(dataO), .en(enO), .data_out(dataO_out));

    controller cntr (
        .clk(clk), .rst(rst),
        .enA(enA), .enB(enB), .enI(enI), .enO(enO),
        .addrO_row(addrO_row), .addrA_row(addrA_row), .addrB_row(addrB_row), .addrI_row(addrI_row),
        .addrO_col(addrO_col), .addrA_col(addrA_col), .addrB_col(addrB_col), .addrI_col(addrI_col),
        .dataA(dataA), .dataB(dataB), .dataI(dataI), .dataO(dataO),
        .dataA_out(dataA_out), .dataB_out(dataB_out), .dataI_out(dataI_out), .dataO_out(dataO_out),
        .inp_north_0(inp_north_0), .inp_north_1(inp_north_1), .inp_north_2(inp_north_2), .inp_north_3(inp_north_3),
        .inp_west_0(inp_west_0), .inp_west_1(inp_west_1), .inp_west_2(inp_west_2), .inp_west_3(inp_west_3),
        .matrix_size(matrix_size), .final_result(final_result),
        .ap_done(ap_done), .ap_start(ap_start)
    );

    systolic_array sa (
        .clk(clk), .rst(rst),
        .inp_west_0(inp_west_0), .inp_west_1(inp_west_1), .inp_west_2(inp_west_2), .inp_west_3(inp_west_3),
        .inp_north_0(inp_north_0), .inp_north_1(inp_north_1), .inp_north_2(inp_north_2), .inp_north_3(inp_north_3),
        .done(ap_done), .size(matrix_size), .final_result(final_result)
    );

endmodule