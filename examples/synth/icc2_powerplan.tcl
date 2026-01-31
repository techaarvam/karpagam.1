create_net -power VDD
create_net -ground GND

connect_pg_net -net VDD [get_pins -hierarchical "*/VDD"]
connect_pg_net -net GND [get_pins -hierarchical "*/GND"]

set_attribute [get_lib_cells */*TIE*] dont_touch false
set_lib_cell_purpose -include optimization [get_lib_cells */*TIE*]

#create PG Rails

create_pg_mesh_pattern P_top_two -layers { \
     {{horizontal_layer: M9}  {width: 0.12} {spacing: interleaving} {pitch: 1} {offset: 1} {trim: false}}   \
     {{vertical_layer: M8} {width: 0.12} {spacing: interleaving} {pitch: 1} {offset: 1} {trim: false}} \
    } 

set_pg_strategy S_mesh_vddgnd -core \
   -pattern { {name: P_top_two} {nets: {VDD GND}} } \
   -extension { {stop: design_boundary_and_generate_pin} }

compile_pg -strategies {S_mesh_vddgnd}


create_pg_std_cell_conn_pattern std_rail_conn_gnd -rail_width 0.090 -layers M1

set_pg_strategy std_rail_gnd -pattern {{name: std_rail_conn_gnd} {nets: "VDD GND"}} -core

compile_pg -strategies {std_rail_gnd S_mesh_vddgnd}

create_pg_vias -nets {VDD GND} -from_layers M1 -to_layers M8 -drc no_check

check_pg_connectivity

check_pg_drc

save_block -as powerplan_done
