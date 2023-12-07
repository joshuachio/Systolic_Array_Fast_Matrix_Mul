module top_module_tb;
    parameter CLK_PERIOD = 11;
    parameter SIM_TIME = 2000;

    reg clk;
    reg rst;
    wire enA, enB, enI, enO;
    wire [31:0] addrO_row, addrA_row, addrB_row, addrI_row;
    wire [3:0] addrO_col, addrA_col, addrB_col, addrI_col;
    wire [15:0] dataA, dataB, dataI, dataO;
    wire [15:0] dataA_out, dataB_out, dataI_out, dataO_out;
    wire ap_done;
    reg ap_start;
    reg [15:0] [15:0] memory_A [0:15];

    top_module uut (
        .clk(clk),
        .rst(rst),
        .enA(enA),
        .enB(enB),
        .enI(enI),
        .enO(enO),
        .addrO_row(addrO_row),
        .addrA_row(addrA_row),
        .addrB_row(addrB_row),
        .addrI_row(addrI_row),
        .addrO_col(addrO_col),
        .addrA_col(addrA_col),
        .addrB_col(addrB_col),
        .addrI_col(addrI_col),
        .dataA(dataA),
        .dataB(dataB),
        .dataI(dataI),
        .dataO(dataO),
        .dataA_out(dataA_out),
        .dataB_out(dataB_out),
        .dataI_out(dataI_out),
        .dataO_out(dataO_out),
        .ap_done(ap_done),
        .ap_start(ap_start)
    );

    reg [3:0] enA_local, enB_local, enI_local, enO_local;

    always #((CLK_PERIOD / 2)) clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        ap_start = 0;
        
        $dumpfile("top_module_wave.vcd");
        $dumpvars;
        rst = 1;
        #10
        rst = 0;
        uut.cntr.enI <= 1;
        uut.cntr.addrI_row <= 0;
        uut.cntr.addrI_col <= 0;
        uut.cntr.dataI <= 16'h0004;
        #10
        uut.cntr.enI <= 0;

        uut.cntr.enA <= 1;
        uut.cntr.enB <= 1;
        uut.cntr.addrA_row <= 0;
        uut.cntr.addrA_col <= 0;
        uut.cntr.addrB_row <= 0;
        uut.cntr.addrB_col <= 0;

        #10
        uut.cntr.dataA <= 'd2;
        uut.cntr.dataB <= 'd6;
        #10
        uut.cntr.addrA_col <= 1;
        uut.cntr.addrB_col <= 1;
        uut.cntr.dataA <= 'd10;
        uut.cntr.dataB <= 'd11;
        #10
        uut.cntr.addrA_col <= 2;
        uut.cntr.addrB_col <= 2;
        uut.cntr.dataA <= 'd2;
        uut.cntr.dataB <= 'd7;
        #10
        uut.cntr.addrA_col <= 3;
        uut.cntr.addrB_col <= 3;
        uut.cntr.dataA <= 'd0;
        uut.cntr.dataB <= 'd4;
        #10
        uut.cntr.addrA_col <= 0;
        uut.cntr.addrB_col <= 0;
        uut.cntr.addrA_row <= 1;
        uut.cntr.addrB_row <= 1;
        uut.cntr.dataA <= 'd6;  
        uut.cntr.dataB <= 'd10;
        #10
        uut.cntr.addrA_col <= 1;
        uut.cntr.addrB_col <= 1;
        uut.cntr.dataA <= 'd6;
        uut.cntr.dataB <= 'd13;
        #10
        uut.cntr.addrA_col <= 2;
        uut.cntr.addrB_col <= 2;
        uut.cntr.dataA <= 'd15;
        uut.cntr.dataB <= 'd15;
        #10
        uut.cntr.addrA_col <= 3;
        uut.cntr.addrB_col <= 3;
        uut.cntr.dataA <= 'd7;
        uut.cntr.dataB <= 'd11;
        #10
        uut.cntr.addrA_col <= 0;
        uut.cntr.addrB_col <= 0;
        uut.cntr.addrA_row <= 2;
        uut.cntr.addrB_row <= 2;
        uut.cntr.dataA <= 'd12;
        uut.cntr.dataB <= 'd14;
        #10
        uut.cntr.addrA_col <= 1;
        uut.cntr.addrB_col <= 1;
        uut.cntr.dataA <= 'd13;
        uut.cntr.dataB <= 'd4;
        #10
        uut.cntr.addrA_col <= 2;
        uut.cntr.addrB_col <= 2;
        uut.cntr.dataA <= 'd11;
        uut.cntr.dataB <= 'd13;
        #10
        uut.cntr.addrA_col <= 3;
        uut.cntr.addrB_col <= 3;
        uut.cntr.dataA <= 'd9;
        uut.cntr.dataB <= 'd5;
        #10
        uut.cntr.addrA_col <= 0;
        uut.cntr.addrB_col <= 0;
        uut.cntr.addrA_row <= 3;
        uut.cntr.addrB_row <= 3;
        uut.cntr.dataA <= 'd14;
        uut.cntr.dataB <= 'd2;
        #10
        uut.cntr.addrA_col <= 1;
        uut.cntr.addrB_col <= 1;
        uut.cntr.dataA <= 'd2;
        uut.cntr.dataB <= 'd4;
        #10
        uut.cntr.addrA_col <= 2;
        uut.cntr.addrB_col <= 2;
        uut.cntr.dataA <= 'd6;
        uut.cntr.dataB <= 'd15;
        #10
        uut.cntr.addrA_col <= 3;
        uut.cntr.addrB_col <= 3;
        uut.cntr.dataA <= 'd7;
        uut.cntr.dataB <= 'd14;

        #10
        uut.cntr.enA <= 0;
        uut.cntr.enB <= 0;
        uut.cntr.addrA_row <= 0;
        uut.cntr.addrA_col <= 0;
        uut.cntr.addrB_row <= 0;
        uut.cntr.addrB_col <= 0;
        ap_start <= 1;
        #10
        ap_start <= 0;

        #SIM_TIME $finish;

    end


    integer file;

    initial begin
        file = $fopen("output.txt", "w");
    end    

    // When ap_done is asserted, check the result
    always @(posedge clk) begin
        if (ap_done) begin
            uut.cntr.enO <= 0;
            $fdisplay(file, "%d %d %d %d", uut.memO.mem[0][0], uut.memO.mem[0][1], uut.memO.mem[0][2], uut.memO.mem[0][3]);
            $fdisplay(file, "%d %d %d %d", uut.memO.mem[1][0], uut.memO.mem[1][1], uut.memO.mem[1][2], uut.memO.mem[1][3]);
            $fdisplay(file, "%d %d %d %d", uut.memO.mem[2][0], uut.memO.mem[2][1], uut.memO.mem[2][2], uut.memO.mem[2][3]);
            $fdisplay(file, "%d %d %d %d", uut.memO.mem[3][0], uut.memO.mem[3][1], uut.memO.mem[3][2], uut.memO.mem[3][3]);
            $fclose(file);
            $finish;
        end
    end



endmodule