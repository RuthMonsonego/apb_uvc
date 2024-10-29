class apb_slave_driver extends apb_driver;

  // component macro
  `uvm_component_utils(apb_slave_driver)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Implementation of send_to_dut for slave
  virtual task send_to_dut(apb_transaction_item transaction);
    // Wait until the master selects the slave (PSEL) and enables the transaction
    wait (vif.PSEL == 1'b1);
    
    `uvm_info(get_type_name(), "Slave selected, awaiting PENABLE", UVM_LOW);
    
    // Slave needs to respond to the master's request
    if (vif.PWRITE) begin
      // Write operation: slave receives data from master
      transaction.PDATA <= vif.PDATA;
      `uvm_info(get_type_name(), {"Writing Data: PDATA=", transaction.PDATA}, UVM_LOW);
    end else begin
      // Read operation: slave places data on the PDATA bus
      vif.PDATA <= transaction.PDATA;
      `uvm_info(get_type_name(), {"Reading Data: PDATA=", vif.PDATA}, UVM_LOW);
    end
    
    // Assert PREADY to indicate slave is ready to complete the transaction
    vif.PREADY <= 1'b1;
    
    // Wait for the PENABLE signal to go high (indicating master is enabling the transaction)
    wait (vif.PENABLE == 1'b1);
    
    // After a cycle, complete the transaction by deasserting PREADY
    @(posedge vif.PCLK);
    vif.PREADY <= 1'b0;

    `uvm_info(get_type_name(), "Transaction completed.", UVM_LOW);
  endtask : send_to_dut

endclass : apb_slave_driver
