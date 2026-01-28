VERILATOR ?= verilator
TOP ?= top
SRC ?= *.sv
OBJ_DIR ?= obj_dir
BIN := $(OBJ_DIR)/V$(TOP)
JOBS ?= 16

LANG_FLAGS := +1800-2023ext+sv
BASE_FLAGS := --binary $(LANG_FLAGS) $(SRC) -Wno-fatal -j $(JOBS) -top-module $(TOP)

ifeq ($(WAVE),1)
TRACE_FLAGS := --trace --trace-vcd
else
TRACE_FLAGS :=
endif

ifeq ($(COV),1)
COV_FLAGS := --coverage
else
COV_FLAGS :=
endif

VCD_FILE ?= dump.vcd
COV_FILE ?= coverage.dat
COV_OUT ?= coverage_out

.PHONY: all compile run gtkwave coverage clean

all: compile

compile:
	$(VERILATOR) $(BASE_FLAGS) $(TRACE_FLAGS) $(COV_FLAGS)

run: compile
	$(BIN)

gtkwave:
	gtkwave $(VCD_FILE)

coverage:
	$(MAKE) COV=1 compile
	$(BIN) +verilator+coverage+file+$(COV_FILE)
	verilator_coverage --annotate $(COV_OUT) $(COV_FILE)

clean:
	rm -rf $(OBJ_DIR)
