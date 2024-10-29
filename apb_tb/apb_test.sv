class apb_test extends uvm_test;

  `uvm_component_utils(apb_test)

  // APB UVC environment
  apb_environment env;

  // Constructor
  function new(string name = "apb_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void end_of_elaboration_phase(uvm_phase phase);
      uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_environment::type_id::create("env", this); // Instantiate the environment
  endfunction : build_phase

  // Test logic (run sequences)
  task run_phase(uvm_phase phase);
    // Start the test
    apb_sequence seq;
    seq = apb_sequence::type_id::create("apb_seq"); // Create an instance of your sequence

    // Let the test run
    phase.raise_objection(this);
    seq.start(env.agent.sequencer); // Start the sequence on the sequencer
    // (Optionally add your timing or logic here)
    #10000; // Let the simulation run for 10,000 time units
    phase.drop_objection(this);
  endtask : run_phase

endclass : apb_test
