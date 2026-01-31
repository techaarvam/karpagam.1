# --------------------------------------------------
# Copyright
# --------------------------------------------------
#
# Tech Aarvam
# Copyright (c) 2026 Tech Aarvam.
# Author: Ram (Ramasubramanian B)

clear -all;
analyze -sv09 -f files.lst;

elaborate -top {counter};
reset "rst";

clock clk;

set_engine_mode {Hp Ht L B I N AM}

prove -bg -all

