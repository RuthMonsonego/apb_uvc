# APB Protocol Universal Verification Component (UVC)

## Overview
This project implements a UVM-based Universal Verification Component (UVC) for the APB (Advanced Peripheral Bus) protocol. Designed for use in UVM test environments, this APB UVC supports both master and slave roles, providing a flexible and reusable solution for verifying APB-based designs.

## APB Protocol Summary
The APB protocol is a low-power, low-complexity bus interface, typically used for communication between a system's processor and its peripheral components. Key APB signals include:
- **PADDR**: Address bus for target peripherals.
- **PWRITE**: Indicates write (high) or read (low) operation.
- **PSEL**: Peripheral select line for activating target peripherals.
- **PENABLE**: Controls the timing of data transactions.
- **PREADY**: Indicates if the slave is ready for the transfer.
- **PRDATA / PWDATA**: Data buses for read and write operations.

## Features
- **Master-Slave Communication**: Supports both master and slave drivers for APB transactions.
- **Read and Write Transactions**: Verifies APB read and write operations with timing checks.
- **PREADY Signal Handling**: Ensures accurate timing and response management using the PREADY signal from the slave.
- **Configurable Transaction Delays**: Allows adjustable delays for protocol timing verification.
- **Error Injection**: Simulates protocol-level errors, such as misaligned data or incorrect timing, to validate design robustness.

## UVC Architecture

### Components
- **APB Master Driver**: Drives APB transactions to initiate read and write operations.
- **APB Slave Driver**: Responds to master commands, emulating slave behavior.
- **Monitor**: Observes and captures all APB transactions, including address, data, and control signals.
- **Sequencer**: Coordinates transaction sequences for various APB protocol scenarios.
- **Scoreboard**: Verifies transaction correctness and checks expected vs. observed data.

### Configurations
The APB UVC can be configured to simulate different scenarios:
- **Standard Read/Write Sequences**: Tests simple read and write operations with configurable address and data patterns.
- **Burst Transactions**: Supports burst transfers with specified start and end addresses.
- **Error Conditions**: Configurable to simulate PREADY delays, protocol violations, and invalid data/address inputs.

## Usage
To integrate the APB UVC in a UVM test environment:
1. Instantiate the APB UVC in the UVM testbench.
2. Configure the master/slave roles and initialize the sequencer and scoreboard.
3. Run sequences with varying addresses, data patterns, and delays to validate APB protocol compliance.

## Verification Scenarios
The APB UVC has been tested in multiple scenarios, including:
- **Basic Functionality**: Standard read/write transactions with valid PREADY timing.
- **Delayed PREADY**: Tests APB timing under various PREADY delays to verify the master's wait-state handling.
- **Error Injection**: Verifies system response to protocol errors and misalignments.
- **Boundary Conditions**: Tests edge cases, including maximum data width and address limits.

## Key Benefits
- **Reusable Component**: Modular UVC design for easy integration into any APB-based UVM environment.
- **Protocol Compliance**: Ensures all APB protocol requirements are met.
- **Error Coverage**: Validates design robustness under normal and error conditions.

---

This APB UVC project provides a reliable and comprehensive framework for APB protocol verification, ideal for both functional testing and stress testing of APB-based designs.
