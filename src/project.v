`default_nettype none

module tt_um_uart_tx (
    input  wire [7:0] ui_in,     // 8-bit parallel data input
    output reg  [7:0] uo_out,    // outputs
    input  wire [7:0] uio_in,    // bidirectional inputs
    output wire [7:0] uio_out,   // bidirectional outputs
    output wire [7:0] uio_oe,    // bidirectional enables
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // UART signals
    reg [7:0] shift_reg;
    reg [3:0] bit_count;
    reg busy;
    reg tx;

    // UART transmitter logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 8'b0;
            bit_count <= 4'b0;
            busy      <= 1'b0;
            tx        <= 1'b1;   // idle state is HIGH
        end

        else begin

            // Start transmission
            if (uio_in[0] && !busy) begin
                shift_reg <= ui_in;
                bit_count <= 4'd0;
                busy      <= 1'b1;
                tx        <= 1'b0; // start bit
            end

            // Transmitting data bits
            else if (busy) begin

                if (bit_count < 8) begin
                    tx <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;
                    bit_count <= bit_count + 1;
                end

                else begin
                    tx   <= 1'b1; // stop bit
                    busy <= 1'b0;
                end
            end
        end
    end

    // Output mapping
    always @(*) begin
        uo_out = 8'b0;

        uo_out[0] = tx;      // UART TX output
        uo_out[1] = busy;    // busy flag
    end

    // Unused bidirectional pins
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Prevent unused warnings
    wire _unused = &{ena, uio_in[7:1], 1'b0};

endmodule
