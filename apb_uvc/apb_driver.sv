class apb_driver extends uvm_driver #(apb_transaction_item);

  // Component macro
  `uvm_component_utils(apb_driver)

  virtual interface apb_interface vif;
  // uvm_seq_item_port seq_item_port; // Define the seq_item_port

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    // seq_item_port = new("seq_item_port", this); // Initialize seq_item_port
  endfunction : new

  // Connect phase
  function void connect_phase(uvm_phase phase);
    if (!apb_vif_config::get(this, "*", "vif", vif))
      `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction: connect_phase

  // Run phase
  task run_phase(uvm_phase phase);
    apb_transaction_item req; // Declare req here
    forever begin
      // Get new item from the sequencer
      seq_item_port.get_next_item(req);
      // Drive the item
      send_to_dut(req);
      // Communicate item done to the sequencer
      seq_item_port.done(req);
    end
  endtask : run_phase

  // Abstract task for sending the transaction to DUT
  virtual task send_to_dut(apb_transaction_item transaction);
    `uvm_fatal("ABSTRACT", "send_to_dut() must be implemented in a subclass.")
  endtask : send_to_dut

endclass : apb_driver
