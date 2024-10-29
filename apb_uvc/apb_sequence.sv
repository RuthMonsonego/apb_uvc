class apb_sequence extends uvm_sequence#(apb_transaction_item);
  
  `uvm_object_utils(apb_sequence)

  // Constructor
  function new(string name="apb_sequence");
    super.new(name);
  endfunction

  rand int transactions_number;

  // Constraint block for randomization
  constraint transactions_number_c {
    transactions_number >= 1;
    transactions_number <= 10;
  }

  // UVM phases: pre_body and post_body
  virtual task pre_body();
    `uvm_info(get_type_name(), "Raising objection before starting transaction", UVM_MEDIUM);
  endtask

  virtual task post_body();
    `uvm_info(get_type_name(), "Dropping objection after transaction is done", UVM_MEDIUM);
  endtask

  virtual task body();
    `uvm_info(get_type_name(), {"Executing ", transactions_number, " sequences"}, UVM_LOW);

    repeat(transactions_number) begin
        apb_transaction_item#(32) item = apb_transaction_item#(32)::type_id::create("item");
        
        // // randomize the transaction
        // if (!item.randomize()) begin
        //     `uvm_fatal("RND_FAIL", "Randomization failed for item!");
        // end

        start_item(item);

        if (!item.randomize()) begin
          `uvm_fatal("RND_FAIL", "Randomization failed for item!");
        end
        
        `uvm_info(get_type_name(), {"Injecting transaction: PADDR=", item.PADDR, ", PDATA=", item.PDATA, ", PWRITE=", item.PWRITE}, UVM_LOW);
        
        finish_item(item);

        // // send the transaction
        // `uvm_do(item);
        
        // // wait to PREADY to de 1
        // wait(item.PREADY == 1);
    end
  endtask

endclass : apb_sequence
