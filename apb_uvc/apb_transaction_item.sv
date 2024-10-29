
class apb_transaction_item #(parameter DATA_WIDTH = 32) extends uvm_sequence_item;     

  // Physical Data (randomized fields)
  rand bit [31:0] PADDR; 
  rand bit [DATA_WIDTH-1:0] PDATA;
  rand bit PWRITE;

  // Control Knobs (controlled by driver, not randomized)
  bit PSEL;
  bit PENABLE;
  bit PREADY;

  // UVM macros for built-in automation - These declarations enable automation
  `uvm_object_utils_begin(apb_transaction_item)
    `uvm_field_int(PADDR, UVM_ALL_ON) 
    `uvm_field_int(PDATA, UVM_ALL_ON) 
    `uvm_field_int(PWRITE, UVM_ALL_ON) 
    `uvm_field_int(PSEL, UVM_ALL_ON)
    `uvm_field_int(PENABLE, UVM_ALL_ON)
    `uvm_field_int(PREADY, UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name = "apb_transaction_item");
    super.new(name);
  endfunction : new

endclass : apb_transaction_item
