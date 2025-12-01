# SYSC4001_A3_P1 - CPU Scheduling Simulator

## Overview
This project implements three CPU scheduling algorithms for a simulated operating system environment:

### 1. External Priority (EP) Scheduler
- **File**: `interrupts_101246652_101299749_EP.cpp`
- **Algorithm**: Non-preemptive priority scheduling
- **Priority**: Lower PID = Higher priority 
- **Characteristics**: Minimal context switching, potential starvation

### 2. Round Robin (RR) Scheduler
- **File**: `interrupts_101246652_101299749_RR.cpp`
- **Algorithm**: Preemptive time-sharing
- **Time Quantum**: 100 milliseconds
- **Characteristics**: Fair CPU allocation, good response time

### 3. Combined EP+RR Scheduler
- **File**: `interrupts_101246652_101299749_EP_RR.cpp`
- **Algorithm**: Preemptive priority with time quantum
- **Priority**: Lower PID = Higher priority with preemption
- **Time Quantum**: 100 milliseconds
- **Characteristics**: Balanced performance
### System Requirements
### Software Requirements

- **Compiler:** g++ 7.0 or higher (C++17 support)
- **Operating System:** Linux (Ubuntu 20.04+ recommended)
- **Python:** 3.6+ (for metrics calculation)
- **Make:** GNU Make 4.0+

### Hardware Requirements

- **Processor:** Any modern x86-64 CPU
- **RAM:** Minimum 1 GB
- **Disk Space:** 50 MB for source and outputs

## Dependencies
```bash
# Ubuntu
sudo apt-get update
sudo apt-get install build-essential g++ python3

### Project Structure 
```
SYSC4001_A3_P1/
│


├── interrupts_101246652_101299749.hpp        # Header file (provided)

├── interrupts_101246652_101299749_EP.cpp     # External Priority scheduler

├── interrupts_101246652_101299749_RR.cpp     # Round Robin scheduler

├── interrupts_101246652_101299749_EP_RR.cpp  # Combined scheduler
│
├── build.sh                                   # Build script
├── Makefile                                   # Automated build system

├── calculate_metrics.py                       # Performance analysis tool

├── generate_all_tests.sh                     # Test file generator

│

├── input_files/                               # Test input files

│   ├── test1.txt                             # Single process, no I/O

│   ├── test2.txt                             # Single process with I/O

│   ├── test3.txt                             # Priority test

│   ├── test4.txt                             # I/O with priority

│   ├── test5.txt to test22.txt               # Additional scenarios

│   └── README.md                             # Test descriptions

│

├── output_files/                              # Generated outputs

│   ├── execution_EP_test1.txt

│   ├── execution_RR_test1.txt

│   ├── execution_EP_RR_test1.txt

│   └── ... (all test outputs)

│

├── bin/                                       # Compiled binaries

│   ├── interrupts_EP

│   ├── interrupts_RR

│   └── interrupts_EP_RR

│

├── report.pdf                                 # Analysis report 

└── README.md                                  # This file
```


## Installation

### Clone the Repository
```bash
git clone 
cd SYSC4001_A3_P1
```

### Create Required Directories
```bash
mkdir -p bin input_files output_files
```

### Make Scripts Executable
```bash
chmod +x build.sh generate_all_tests.sh
```

## Compilation

### Option 1: Using Makefile (Recommended)
```bash
# Compile all schedulers
make all

# Compile individual schedulers
make part1
```

### Option 2: Using build.sh
```bash
./build.sh
```

### Option 3: Manual Compilation
```bash
# External Priority Scheduler
g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_EP \
    interrupts_101246652_101299749_EP.cpp

# Round Robin Scheduler
g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_RR \
    interrupts_101246652_101299749_RR.cpp

# Combined Scheduler
g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_EP_RR \
    interrupts_101246652_101299749_EP_RR.cpp
```

### Compilation Flags Explained

- `-Wall -Wextra`: Enable all warnings
- `-g`: Include debugging symbols
- `-std=c++17`: Use C++17 standard
- `-I.`: Include current directory for headers
- `-o bin/...`: Output binary to bin directory

## Usage

### Generate Test Input Files
```bash
# Generate all 22 test scenarios
./generate_all_tests.sh

# Or use Makefile
make generate_inputs
```

### Run Individual Scheduler
```bash
# External Priority
./bin/interrupts_EP input_files/test1.txt

# Round Robin
./bin/interrupts_RR input_files/test2.txt

# Combined
./bin/interrupts_EP_RR input_files/test3.txt
```

Output is written to `execution.txt` in the current directory.

### Run All Tests Automatically
```bash
# Run all test scenarios for all schedulers
make test

# Run specific scheduler tests
make test_ep      # External Priority only
make test_rr      # Round Robin only
make test_ep_rr   # Combined only
```

### Calculate Performance Metrics
```bash
# Single file
python3 calculate_metrics.py execution.txt

# Multiple files
python3 calculate_metrics.py output_files/execution_EP_test*.txt

# Compare schedulers for same test
python3 calculate_metrics.py \
    output_files/execution_EP_test1.txt \
    output_files/execution_RR_test1.txt \
    output_files/execution_EP_RR_test1.txt
```

## Input File Format

### Format Specification

Each line represents one process with comma-separated values:
```
PID, Memory_Size, Arrival_Time, Total_CPU_Time, IO_Frequency, IO_Duration
```

### Field Descriptions

| Field | Type | Unit | Description |
|-------|------|------|-------------|
| PID | Integer | - | Process identifier (unique, used for priority) |
| Memory_Size | Integer | MB | Memory required (must fit in partition) |
| Arrival_Time | Integer | ms | When process enters system |
| Total_CPU_Time | Integer | ms | Total CPU time needed |
| IO_Frequency | Integer | ms | How often I/O occurs (0 = no I/O) |
| IO_Duration | Integer | ms | How long each I/O takes |

### Example Input Files

**test1.txt** - Single process, no I/O:
```
10, 1, 0, 10, 0, 0
```

**test2.txt** - Single process with I/O:
```
10, 1, 0, 10, 5, 1
```

**test3.txt** - Multiple processes:
```
10, 1, 0, 10, 0, 0
1, 2, 3, 5, 0, 0
```

**test4.txt** - Processes with I/O:
```
10, 1, 0, 5, 2, 3
1, 2, 3, 5, 0, 0
```

### Input Validation

The simulator performs the following checks:

✅ Memory size must be ≤ 40 MB (largest partition)  
✅ All times must be non-negative  
✅ I/O frequency must be > 0 if I/O duration > 0  
⚠️ Invalid input will cause process to wait or be rejected

## Output Format

### Execution Log Format
```
+------------------------------------------------+
|Time of Transition |PID | Old State | New State |
+------------------------------------------------+
| 0                 | 10 | NEW       | READY     |
| 0                 | 10 | READY     | RUNNING   |
| 5                 | 10 | RUNNING   | WAITING   |
| 6                 | 10 | WAITING   | READY     |
| 6                 | 10 | READY     | RUNNING   |
| 11                | 10 | RUNNING   | TERMINATED|
+------------------------------------------------+
```

### State Descriptions

| State | Description |
|-------|-------------|
| NEW | Process created, waiting for memory |
| READY | In ready queue, waiting for CPU |
| RUNNING | Currently executing on CPU |
| WAITING | Blocked on I/O operation |
| TERMINATED | Completed execution |

### Transition Events

State changes occur when:

- Process arrives → NEW to READY
- Scheduler dispatches → READY to RUNNING
- I/O request → RUNNING to WAITING
- I/O completion → WAITING to READY
- Quantum expires (RR, EP+RR) → RUNNING to READY
- Process completes → RUNNING to TERMINATED


