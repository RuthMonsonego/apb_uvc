module apb_sw_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import apb_package::*;
  // `include "./apb_test_bench.sv"
  `include "./apb_test.sv"

  // Create the APB virtual interface
  // virtual apb_interface vif;

  // Instantiate the UVM environment
  // apb_environment env;

  // Instantiate the hardware top module
  // apb_hw_top hw_top();

  // Connect the hardware signals to the virtual interface
  initial begin
    // vif = hw_top.vif; // Assuming 'vif' exists in hw_top (bind it manually if not)

    // // Bind the signals from the DUT to the virtual interface
    // assign vif.PSEL    = hw_top.PSEL;
    // assign vif.PENABLE = hw_top.PENABLE;
    // assign vif.PWRITE  = hw_top.PWRITE;
    // assign vif.PADDR   = hw_top.PADDR;
    // assign vif.PDATA   = hw_top.PDATA;
    // assign vif.PREADY  = hw_top.PREADY;

    // Set up the virtual interface for the UVM components
    apb_vif_config::set(null, "*", "vif", apb_hw_top.vif);
  // end

  // // Run the UVM testbench
  // initial begin
    run_test(); // Run the UVM test

    // make delay
    #100000ns;

    //finish the simulation
    $finish;
    
  end

endmodule : apb_sw_top
