// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

interface master_intf;
    
    logic clk;

    logic nrst;
    logic valid;
    logic ready;
    logic [3:0] length;
    logic [7:0] source;
    logic [7:0] destination;
    
    modport drv (
        output valid, length, source, destination,
        input nrst, clk, ready
       );
    modport mon (
        input nrst, clk, valid, length, source, destination,
        input ready
       );


endinterface
