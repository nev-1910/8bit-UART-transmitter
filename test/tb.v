`timescale 1ns / 1ps

module tb;

    reg clk;
    reg rst_n;

    reg [7:0] ui_in;

    wire [7:0] uo_out;

    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    reg [7:0] uio_in;

    reg ena;

    // Instantiate DUT
    tt_um_uart_tx dut (
        .ui_in(ui_in),
        .uo_out(uo_out),

        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),

        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Dump waveform
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        // Initialize signals
        clk = 0;
        rst_n = 0;
        ena = 1;

        ui_in = 8'b10110011;

        uio_in = 8'b0;

        // Apply reset
        #20;
        rst_n = 1;

        // Run simulation
        #300;

        $finish;
    end

endmodule
