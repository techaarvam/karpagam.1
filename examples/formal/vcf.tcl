# --------------------------------------------------
# Copyright
# --------------------------------------------------
#
# Tech Aarvam
# Copyright (c) 2026 Tech Aarvam.
# Author: Ram (Ramasubramanian B)


set_fml_appmode FPV;
analyze -format sverilog -vcs "-assert svaext -f files.lst";

elaborate -sva counter -cov all -vcs "-sverilog";

create_clock -period 100 clk -initial 1
create_reset rst -high;

sim_run -stable
sim_save_reset
check_fv -block
report_fv
