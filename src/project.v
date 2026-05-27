`default_nettype none

module tt_um_uart_tx (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    // UART transmitter register
    reg tx;

    // Data register
    reg [7:0] data_reg;

    // Bit counter
    reg [3:0] bit_index;

    // FSM states
    reg [1:0] state;

    // State encoding
    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    // UART FSM
    always @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin
            state <= IDLE;
            tx <= 1'b1;
            data_reg <= 8'b0;
            bit_index <= 4'b0;
        end

        else begin

            case(state)

                // Waiting state
                IDLE: begin
                    data_reg <= ui_in;
                    tx <= 1'b1;
                    bit_index <= 0;
                    state <= START;
                end

                // Send start bit
                START: begin
                    tx <= 1'b0;
                    state <= DATA;
                end

                // Send 8 data bits
                DATA: begin
                    tx <= data_reg[bit_index];

                    if(bit_index == 7) begin
                        bit_index <= 0;
                        state <= STOP;
                    end
                    else begin
                        bit_index <= bit_index + 1;
                    end
                end

                // Send stop bit
                STOP: begin
                    tx <= 1'b1;
                    state <= IDLE;
                end

            endcase

        end

    end

    // Output mapping
    assign uo_out[0] = tx;

    // Unused outputs
    assign uo_out[7:1] = 7'b0;

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Prevent warnings
    wire _unused = &{ena, uio_in, 1'b0};

endmodule
