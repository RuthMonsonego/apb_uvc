// 64-bit option required for AWS labs
-64

// Set UVM home directory
-uvmhome $UVMHOME

// Runtime options
+UVM_VERBOSITY=UVM_LOW
+UVM_TESTNAME=apb_test

// Default timescale
-timescale 1ns/100ps 

// Include directories
-incdir ../apb_uvc
// -incdir ../apb_tb

// UVM source files (for macros and UVM infrastructure)
// Make sure this path is correct based on your system setup
/tools/cadence/XCELIUM/24.03.004/tools.lnx86/methodology/UVM/CDNS-1.1d/sv/src/uvm_pkg.sv

// Compile APB package
../apb_uvc/apb_package.sv
../apb_uvc/apb_interface.sv
../apb_uvc/apb_dut.sv

// Compile order for APB testbench
./apb_sw_top.sv
./apb_hw_top.sv

// // ./apb_test_bench.sv
// ./apb_test.sv

// UVM package
-uvm
