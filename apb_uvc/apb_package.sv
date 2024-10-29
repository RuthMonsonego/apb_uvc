package apb_package;

  // Include UVM package and macros
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  typedef uvm_config_db#(virtual apb_interface) apb_vif_config;

  // Include all files from apb_uvc in correct order
  `include "apb_transaction_item.sv"  // The transaction item class, used in sequencer, driver, monitor
  // `include "apb_interface.sv"         // APB interface definition
  `include "apb_monitor.sv"           // Monitor to observe transactions
  `include "apb_sequence.sv"          // Sequence for transaction generation
  `include "apb_sequencer.sv"         // Sequencer that controls the sequences
  `include "apb_driver.sv"            // Base driver class
  `include "apb_master_driver.sv"     // Master-specific driver
  `include "apb_slave_driver.sv"         // APB slave driver
  `include "apb_agent.sv"             // APB agent definition
  `include "apb_environment.sv"       // APB environment definition
  // `include "apb_dut.sv"               // Design Under Test (DUT)

endpackage : apb_package
