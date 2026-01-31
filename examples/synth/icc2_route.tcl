############################################
# Minimal routing flow (ICC2) - learning
############################################

# 0) Open the design checkpoint you want to route
#    (skip if you're already in that block)
# open_block top_lib:cts_done.design
# current_block top

# 1) Routing layer limits
# For learning: allow M1 for pin access, start signal routing from M2A
set_ignored_layers -min_routing_layer M2
set_ignored_layers -max_routing_layer M10
report_ignored_layers

# 2) Enable SI-aware timing analysis (optional but useful)
set_app_options -name time.si_enable_analysis        -value true
set_app_options -name time.enable_si_timing_windows  -value true

# 3) Route (one command does global+track+detail in most ICC2 flows)
route_auto

# 4) Post-route sanity
check_routes
check_lvs                          ;# quick structural sanity (not signoff LVS)
report_timing -delay_type max -max_paths 10
report_timing -delay_type min -max_paths 10

# 5) Save checkpoint
save_block -as route_done
