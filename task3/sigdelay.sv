module sigdelay # (
    parameter  ADDRESS_WIDTH = 9,
    parameter   DATA_WIDTH = 8
) (
    input   logic                       clk,
    input   logic                       rst,
    input   logic                       wr,
    input   logic                       rd,
    input   logic   [ADDRESS_WIDTH-1:0] offset,
    input   logic   [DATA_WIDTH-1:0]    mic_signal,
    output  logic   [DATA_WIDTH-1:0]    delayed_signal
);

    logic           [ADDRESS_WIDTH-1:0] addr;

    counter signalCounter(
        .clk(clk),
        .rst(rst),
        .en(1),
        .incr(offset),
        .count(addr)

    );

    ram2ports signalRAM (
        .clk(clk),
        .wr_en(wr),
        .rd_en(rd),
        .wr_addr(addr),
        .rd_addr(addr - offset),
        .din(mic_signal),
        .dout(delayed_signal)
    );

endmodule
    