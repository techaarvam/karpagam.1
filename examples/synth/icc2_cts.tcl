# Before performing CTS, execute the following command and analyze the report
check_design -checks pre_clock_tree_stage

# set NDR
create_routing_rule clk_rule \
  -widths   {M6 0.112 M7 0.112} \
  -spacings {M6 0.112 M7 0.112}

# specify clock tree cell list
# set_lib_cell_purpose -exclude cts [get_lib_cells]

set_lib_cell_purpose -include cts \
  [get_lib_cells *BUF* ]
set_lib_cell_purpose -include cts \
  [get_lib_cells *INV* ]


# Specify max fanout
set_app_options -name cts.common.max_fanout -value 30

# set clock target skew and latency
set_clock_tree_options \
  -clocks [all_clocks] \
  -target_latency 0.250 \
  -target_skew    0.030

set_clock_routing_rules \
  -clocks [all_clocks] \
  -net_type internal \
  -rules clk_rule \
  -min_routing_layer M6 \
  -max_routing_layer M7

set_clock_routing_rules \
  -clocks [all_clocks] \
  -net_type root \
  -rules clk_rule \
  -min_routing_layer M6 \
  -max_routing_layer M7

clock_opt

# Make the logical connection of PG nets for all the standard cells
connect_pg_net -net VDD [get_pins -hier * -filter "name == VDD"]
connect_pg_net -net GND [get_pins -hier * -filter "name == GND"]

report_constraints -all_violators
report_clock_tree_options
report_clock_qor
report_qor -summary
report_timing -delay_type min
report_timing -delay_type max

save_block -as cts_done

