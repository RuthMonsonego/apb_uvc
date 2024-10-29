module apb_hw_top;

  // Parameter
  parameter DATA_WIDTH = 32;

  // build interface instantiation
  apb_interface #(.DATA_WIDTH(DATA_WIDTH)) vif();

  // clock and reset signals
  logic PCLK;
  logic RST_N;

  // // APB interface signals
  // logic PCLK, PSEL, PENABLE, PWRITE, PREADY, RST_N;
  // logic [32:0] PADDR;
  // logic [DATA_WIDTH-1:0] PDATA;

  // Instantiate the APB slave DUT
  apb_dut #(
    .DATA_WIDTH(DATA_WIDTH)
  ) dut (
    .pclk(PCLK),
    .rst_n(RST_N),
    .psel(vif.PSEL),
    .penable(vif.PENABLE),
    .pwrite(vif.PWRITE),
    .paddr(vif.PADDR),
    .pdata(vif.PDATA),
    .pready(vif.PREADY)
  );

  // Clock generation
  initial begin
    RST_N = 1;
    PCLK = 0;
    forever #5 PCLK = ~PCLK; // 100MHz clock
  end

endmodule : apb_hw_top
