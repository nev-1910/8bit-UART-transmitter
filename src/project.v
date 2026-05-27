`default_nettype none

module tt_um_uart_tx (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // UART transmit output
    reg tx;

    // Shift register
    reg [7:0] shift_reg;

    // Bit counter
    reg [2:0] bit_index;

    // FSM states
    reg [1:0] state;

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    // UART FSM
    always @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin

            state <= IDLE;
            bit_index <= 3'b000;
            tx <= 1'b1;
            shift_reg <= 8'b00000000;

        end else begin

            case (state)

                IDLE: begin
                    shift_reg <= ui_in;
                    bit_index <= 0;
                    tx <= 1'b1;
                    state <= START;
                end

                START: begin
                    tx <= 1'b0;
                    state <= DATA;
                end

                DATA: begin

                    tx <= shift_reg[0];

                    shift_reg <= shift_reg >> 1;

                    if (bit_index == 3'd7) begin
                        bit_index <= 0;
                        state <= STOP;
                    end
                    else begin
                        bit_index <= bit_index + 1;
                    end
                end

                STOP: begin
                    tx <= 1'b1;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                end

            endcase

        end

    end

    // Output mapping
    assign uo_out = {7'b0000000, tx};

    // Unused IOs
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent warnings
    wire _unused = &{ena, uio_in, 1'b0};

endmodule
