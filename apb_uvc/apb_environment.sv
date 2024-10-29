class apb_environment extends uvm_env;

  apb_agent agent;
  // virtual interface apb_interface vif;

  // Component macro
  `uvm_component_utils(apb_environment)

  // Constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // if (!apb_vif_config::get(this, "*", "vif", vif))
    //   `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
    agent = apb_agent::type_id::create("agent", this);
    // assign_vi(vif);
  endfunction

  // // Assign the virtual interface to the agent
  // function void assign_vi(virtual interface apb_interface vif);
  //   agent.assign_vi(vif);
  // endfunction

endclass
