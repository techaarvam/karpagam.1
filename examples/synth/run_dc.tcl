set TOP top

set_app_var search_path [list <library_search_path>]

set_app_var target_library [list <target_library_path.db>]
set_app_var link_library   [concat "*" $target_library dw_foundation.sldb]

set_app_var verilogout_no_tri true
set_app_var verilogout_show_unconnected_pins true
set_app_var write_name_nets_same_as_ports true
set_app_var verilogout_single_bit true

# if we plan LEC later.
set_svf ../output/ddc/top.svf

read_file -format sverilog ../rtl/counter.v

current_design $TOP
link
read_sdc ../sdc/common.sdc
check_design

compile_ultra

check_design
report_design
report_reference

report_timing > ../reports/dc/timing.rpt
report_area > ../reports/dc/area.rpt


write -format ddc     -hierarchy -output ../output/ddc/top.ddc
write -format verilog -hierarchy -output ../output/netlist/top_syn.v
write_sdc ../output/sdc/top.sdc
