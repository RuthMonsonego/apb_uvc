class apb_master_driver extends apb_driver;

  // component macro
  `uvm_component_utils(apb_master_driver)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Implementation of send_to_dut for master
  virtual task send_to_dut(apb_transaction_item transaction);
      `uvm_info(get_type_name(), {"Sending transaction to DUT: PADDR=", transaction.PADDR, ", PWRITE=", transaction.PWRITE, ", PDATA=", transaction.PDATA}, UVM_LOW)

      // Assert the select signal and set the address
      vif.PSEL    <= 1'b1;
      vif.PADDR   <= transaction.PADDR;
      vif.PWRITE  <= transaction.PWRITE;
      vif.PREADY <= 1'b0;

      // If it's a write operation, drive the data onto PDATA
      if (transaction.PWRITE) begin
          vif.PDATA <= transaction.PDATA;
      end

      // Drive PENABLE to high (Enable phase)
      vif.PENABLE <= 1'b1;

      // Wait for PREADY again (Slave ready for data or response) - REMOVE THIS LINE
      wait (transaction.PREADY == 1'b1);

      // If it's a read operation, capture the data
      if (!transaction.PWRITE) begin
          @(posedge vif.PCLK); // Ensure synchronization with clock
          transaction.PDATA <= vif.PDATA;
          `uvm_info(get_type_name(), {"Read Data from DUT: PDATA=", transaction.PDATA}, UVM_LOW)
      end

      // Complete the transaction by deasserting the signals
      vif.PSEL    <= 1'b0;
      vif.PENABLE <= 1'b0;

      `uvm_info(get_type_name(), "Transaction completed.", UVM_LOW)
  endtask : send_to_dut

endclass : apb_master_driver
