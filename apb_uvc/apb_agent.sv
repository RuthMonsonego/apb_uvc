class apb_agent extends uvm_agent;

  apb_monitor monitor;
  apb_sequencer sequencer;
  apb_driver driver;

  // defined the agent always as active master
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  uvm_active_passive_enum is_master = UVM_ACTIVE;

  // component macro
  `uvm_component_utils_begin(apb_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_field_enum(uvm_active_passive_enum, is_master, UVM_ALL_ON)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor = apb_monitor::type_id::create("monitor", this);
    if (is_active == UVM_ACTIVE) begin
      sequencer = apb_sequencer::type_id::create("sequencer", this);
      if (is_master == UVM_ACTIVE)
        driver = apb_master_driver::type_id::create("driver", this);
      else
        driver = apb_slave_driver::type_id::create("driver", this);
    end
  endfunction : build_phase

  // UVM connect_phase - Connects monitor, sequencer, and driver
  function void connect_phase(uvm_phase phase);
    // Connect sequencer to driver
    if (is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export); // Connect the sequencer to the driver
      // Connect monitor to sequencer if needed
      // monitor.seq_item_export.connect(sequencer.analysis_export);
    end
  endfunction : connect_phase

  // // Assign the virtual interfaces of the agent's children
  // function void assign_vi(virtual interface apb_interface vif);
  //   monitor.vif = vif;
  //   // Ensure that the driver also receives the interface, even if not active
  //   if (driver != null)
  //     driver.vif = vif;
  // endfunction : assign_vi

endclass : apb_agent
