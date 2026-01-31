
set TOP top

set target_library <path_to_target_library_db>
set link_library <Path_to_link_library_db>

open_lib top_lib
# create_lib top_lib -ref_libs <path_to_reflib.ndb> -technology <path_to_icc_tech.tf>


read_verilog ../output/netlist/top_syn.v
read_sdc ../output/sdc/top.sdc


current_design $TOP

link

save_lib -as post_import_design

set_attribute -objects [get_layers {M1 M3 M5 M7 M9}] -name routing_direction -value horizontal
set_attribute -objects [get_layers {M2 M4 M6 M8 M10}] -name routing_direction -value vertical


#TLUPLUS is interconnect RC
read_parasitic_tech -layermap <path_to_tluplus.mapping> -tlup <path_to_tluplus>


save_block -as design_load_done

