
group_path -name MACRO2REG \
  -from [get_cells -physical_context -filter design_type==macro] \
  -to   [all_registers]

group_path -name REG2MACRO \
  -from [all_registers] \
  -to   [get_cells -physical_context -filter design_type==macro]

group_path -name INPUTS2REG \
  -from [all_inputs] \
  -to   [all_registers]

group_path -name OUTPUTS2REG \
  -from [all_outputs] \
  -to   [all_registers]

group_path -name REG2REG \
  -from [all_registers] \
  -to   [all_registers]



check_design -checks pre_placement_stage



set_parasitic_parameters \
  -corner default \
  -early_spec TYP_RC \
  -late_spec  TYP_RC

check_legality -verbose
legalize_placement

report_qor -summary

analyze_design_violations


place_opt -to final_opto

report_qor -summary
report_timing

connect_pg_net -net VDD [get_pins -hier * -filter "name==VDD"]
connect_pg_net -net VSS [get_pins -hier * -filter "name==VSS"]

save_block -as placement_done
