verilator --binary +1800-2023ext+sv  +define+UVM_NO_DPI $UVM_HOME/src/uvm_pkg.sv ./apb_master.sv uvmtb/interface.sv uvmtb/top_env.sv tb.sv -I$UVM_HOME/src  --trace-vcd --trace -Wno-fatal -j 16 --top-module tb --timescale 1ns/1ps 
#!/usr/bin/env bash
# --------------------------------------------------
# Copyright
# --------------------------------------------------
#
# Tech Aarvam
# Copyright (c) 2026 Tech Aarvam.
# Author: Ram (Ramasubramanian B)
