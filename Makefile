# Makefile for compiling Verilog files using Icarus Verilog

# Compiler options
VLOG = iverilog
VLOG_OPTS = -Wall

# Simulation options
VVP = vvp

# Source files
SRC_FILES = systolic_array.v block.v memory.v controller.v top_module.v testbench/top_level_tb.v

# Output directory
OUTPUT_DIR = output

# Testbench
TB = top_level

# Compilation target
all: compile simulate

compile:
	mkdir -p $(OUTPUT_DIR)
	$(VLOG) $(VLOG_OPTS) -o $(OUTPUT_DIR)/$(TB) $(SRC_FILES)

simulate:
	cd $(OUTPUT_DIR) && $(VVP) $(TB)

clean:
	rm -rf $(OUTPUT_DIR)
	rm -f transcript

.PHONY: all compile simulate clean

