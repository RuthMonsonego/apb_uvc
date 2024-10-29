class apb_monitor extends uvm_monitor;

  // component macro
  `uvm_component_utils(apb_monitor)

  // Handle to the APB interface
  virtual interface apb_interface vif;

  // Analysis ports
  uvm_analysis_port #(apb_transaction_item) current_transaction_port;
  // uvm_seq_item_export seq_item_export; // seq_item_export for connecting to sequencer

  // component constructor - required syntax for UVM automation and utilities
  function new(string name, uvm_component parent);
    super.new(name, parent);
    current_transaction_port = new("current_transaction_port", this);
    // seq_item_export = new("seq_item_export", this); // Initialize seq_item_export
  endfunction : new

  function void connect_phase(uvm_phase phase);
    if (!apb_vif_config::get(this, "*", "vif", vif))
      `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction: connect_phase

// Main monitoring task
virtual task run_phase(uvm_phase phase);
    forever begin
        // Wait for a positive clock edge
        @(posedge vif.PCLK);

        // Check if PENABLE and PREADY are high
        if (vif.PENABLE && vif.PREADY) begin
            // Sample the transaction
            apb_transaction_item#(32) item = apb_transaction_item#(32)::type_id::create("item");
            
            // Capture values from the interface
            item.PADDR   = vif.PADDR;
            item.PWRITE  = vif.PWRITE;
            item.PDATA   = vif.PDATA;

            // Log transaction information
            `uvm_info("APB_MONITOR", {"Transaction Captured: PADDR=", item.PADDR, ", PWRITE=", item.PWRITE, ", PDATA=", item.PDATA}, UVM_LOW);
            
            // End collect the transaction
            current_transaction_port.write(item);
            // seq_item_export.write(item); // Send the transaction to sequencer if needed
        end
        else begin
            // Log a warning if PENABLE and PREADY are not high
            `uvm_warning("APB_MONITOR_WARNING", "PENABLE and/or PREADY not high; skipping transaction capture.");
        end
    end
endtask

endclass : apb_monitor
