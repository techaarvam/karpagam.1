check_netlist
check_timing
report_design_mismatch -verbose

initialize_floorplan   -core_utilization 0.60     -core_offset {5 5 5 5}

set_block_pin_constraints -self -allowed_layers {M3 M4} -sides 2


#set_ignored_layers -max_routing_layer M10
#set_ignored_layers -min_routing_layer M2

#report_ignored_layers

place_pins -self

set_attribute [get_ports *] physical_status fixed
get_attribute [get_ports *] is_fixed

save_block -as floorplan_done
