interface apb_interface #(parameter DATA_WIDTH = 32) ();

    logic PCLK;         // Clock signal
    logic [31:0] PADDR; // Address bus (assuming 32-bit address)
    logic PWRITE;       // Write signal (1 for write, 0 for read)
    logic PSEL;         // Select signal
    logic PENABLE;      // Enable signal
    logic [DATA_WIDTH-1:0] PDATA; // Data bus (for both read and write)
    logic PREADY;       // Ready signal (indicates slave is ready)

    // Modport for monitor (observe signals, no driving)
    modport monitor_modport (
        input PCLK,
        input PADDR,
        input PWRITE,
        input PSEL,
        input PENABLE,
        input PREADY,
        input PDATA
    );

    // Modport for master driver (drives the APB bus for write and read)
    modport master_driver_modport (
        input PCLK,
        input PREADY,
        output PADDR,
        output PWRITE,
        output PSEL,
        output PENABLE,
        inout PDATA
    );

    // Modport for slave driver (responds to master's requests for write and read)
    modport slave_driver_modport (
        input PCLK,
        input PADDR,
        input PWRITE,
        input PSEL,
        input PENABLE,
        output PREADY,
        inout PDATA
    );

endinterface : apb_interface
