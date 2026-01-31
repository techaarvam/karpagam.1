// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

/* Make it parametrized later on */


module apb_master(
      nrst, clk, //clocks and resets
      valid, ready, source, destination, length,  // upstream interface
      //target0
      psel0, pready0, penable0, pwrite0, pwdata0, prdata0, perr0, paddr0,
      //target1
      psel1, pready1, penable1, pwrite1, pwdata1, prdata1, perr1, paddr1
        );
    // clocks and resets
    input logic nrst;
    input logic clk;

    // upstream interfaces
    input logic valid;
    output logic ready;
    input [7:0] source;
    input [7:0] destination;
    input [3:0] length;

    //target0
    output logic psel0;
    input logic pready0;
    output logic penable0;
    output logic pwrite0;
    output logic [7:0] pwdata0;
    input logic [7:0] prdata0;
    input logic perr0;
    output logic [7:0] paddr0;

    //target1
    output logic psel1;
    input logic pready1;
    output logic penable1;
    output logic pwrite1;
    output logic [7:0] pwdata1;
    input logic [7:0] prdata1;
    input logic perr1;
    output logic [7:0] paddr1;


    logic pready; 
    logic [7:0] prdata; 
    logic pwrite;
    logic [7:0]pwdata;
    logic penable;
    logic [7:0] paddr;
    

    //mux
    assign pready = psel0? pready0:pready1;
    assign prdata = psel0? prdata0:prdata1;
  
    // direct assignments 
    assign pwrite0 = pwrite; 
    assign pwrite1 = pwrite; 
    assign pwdata0 = pwdata;
    assign pwdata1 = pwdata;
    assign paddr0 = paddr;
    assign paddr1 = paddr;
    assign penable0 = penable;
    assign penable1 = penable;

    apb_master_fsm mfsm0 (
         .*
                 );

endmodule

// step-1 (assume same-bus, read and write to different devices): 
//     one read, one write -> sequenctial implementation
//     The APB bus is shared
// Step-2: separate APB busses. continuous read/write. 
// step-2: shared or separate APB busses. 
//      if read/write to the same device also continuous read/write possible

// States:
//  IDLE
//  dma_rd_setup
//  dma_rd_access
//  dma_wr_setup
//  dma_wr_access

// DMA states:
//   IDLE:
//      if (upstream_state == DMA) next_state= DMA_RD_SETUP;
//   DMA_RD_SETUP:
//      next_state = DMA_RD_ACCESS;
//   DMA_RD_ACCESS:
//      if (pready) next_state = DMA_WR_SETUP
//   DMA_WR_SETUP:
//      next_state = DMA_WR_ACCESS;
//   DMA_WR_ACCESS:
//      if (pready and wr_count == length) next_state = IDLE
//      if (pready and wr_count != length) next_state = DMA_RD_SETUP
//       


module apb_master_fsm (
      nrst, clk, //clocks and resets
      valid, ready, source, destination, length,  // upstream interface
      psel0, psel1, pready, penable, pwrite, prdata, pwdata, paddr 
                  );
    /* initiator */
    input nrst, clk;
    input valid;
    input logic [7:0] source, destination; 
    input logic [3:0] length ;
    output ready; //ready is okay to be a net

    /* target */
    output logic penable, pwrite;
    output logic [7:0] pwdata;
    input pready;
    input logic [7:0] prdata;
    output logic psel0, psel1;
    output logic [7:0] paddr;
    
    typedef enum logic [2:0] { 
             IDLE, 
             DMA_RD_SETUP, 
             DMA_RD_ACCESS,
             DMA_WR_SETUP,
             DMA_WR_ACCESS,
             FINISH_TXN

                       } states_t;
    logic [3:0] wr_count;
    logic [7:0] captured_data;
    states_t state, next_state;

    
    assign ready = (state == FINISH_TXN) ;

    // Only change next_state in alway_comb.
    // avoid any other writes to regs
    // Notice the = sign, its combo assign
    
    always_comb 
    begin
        next_state = state;
        case (state)
            IDLE:
                if (valid==1 && length != 4'b0)
                    next_state = DMA_RD_SETUP;
            DMA_RD_SETUP:
                next_state = DMA_RD_ACCESS;
            DMA_RD_ACCESS:
                if (pready) next_state = DMA_WR_SETUP;
            DMA_WR_SETUP:
                next_state = DMA_WR_ACCESS;
            DMA_WR_ACCESS:
                /* wr_count must be incremented at wr_setup for this to work */
                if (pready)
                begin
                    if (length == wr_count) next_state = FINISH_TXN;
                    else next_state = DMA_RD_SETUP;
                end
                
            FINISH_TXN:
                next_state = IDLE;
        endcase
    end

    always @(posedge clk)
    begin
        if (!nrst) 
        begin
            state <= IDLE;
            wr_count <= 0;
            penable <= 0;
        end
        else
        begin
            state <= next_state;
            case (state)
                IDLE: 
                    ;
                DMA_RD_SETUP:
                    begin
                        if (source[7] == 0)
                        begin
                            psel0 <= 1;
                            psel1 <= 0;
                        end
                        else
                        begin
                            psel0 <= 0;
                            psel1 <= 1;
                        end
                        paddr <= source + wr_count;
                        pwrite <= 0; // read txn
                        penable <= 0; 
                     end
                DMA_RD_ACCESS:
                    begin
                        penable <= 1;
                        //paddr <=0; //INJECT ERROR
                        if (pready == 1)
                        begin
                            captured_data <= prdata;
                        end
                    end 
                DMA_WR_SETUP:
                    begin
                        penable<=0;
                        wr_count <= wr_count + 1'b1;
                        paddr <= 128 ^ destination + wr_count;
                        if (destination[7] == 0)
                        begin
                            psel0 <= 1;
                            psel1 <= 0;
                        end
                        else
                        begin
                            psel0 <= 0;
                            psel1 <= 1;
                        end
                        pwrite <= 1;
                        pwdata <= captured_data;
                    end 
                DMA_WR_ACCESS:
                    begin
                        penable <= 1;
                    end 
                FINISH_TXN:
                    begin
                        penable <=0;
                        psel0<=0; psel1<=0; 
                        wr_count <= 0;
                    end
                default:
                    ;
            endcase
                           
        end

 
    end
    
endmodule

