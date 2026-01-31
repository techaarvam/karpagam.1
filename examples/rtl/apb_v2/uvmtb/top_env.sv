// --------------------------------------------------
// Copyright
// --------------------------------------------------
//
// Tech Aarvam
// Copyright (c) 2026 Tech Aarvam.
// Author: Ram (Ramasubramanian B)

package apb_tb_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

typedef class apb_master_tb_agent;
typedef class apb_master_tb_driver;
typedef class apb_master_tb_monitor;
typedef class apb_master_tb_env;

class apb_master_tb_env extends uvm_env;
    `uvm_component_utils(apb_master_tb_env);
    apb_master_tb_agent agent;
    function new(string name, uvm_component parent = null);
        super.new(name,parent);
        uvm_report_info(get_full_name(), "new", UVM_LOW);
    endfunction: new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_report_info(get_full_name(), "build_phase", UVM_LOW);
        agent = apb_master_tb_agent::type_id::create("apb_master_agent", this);
    endfunction
 
endclass

class apb_master_tb_agent extends uvm_agent;
    `uvm_component_utils(apb_master_tb_agent);
    apb_master_tb_driver driver;
    apb_master_tb_monitor monitor;
    function new(string name, uvm_component parent = null);
        super.new(name,parent);
        uvm_report_info(get_full_name(), "new", UVM_LOW);
    endfunction: new
    
    function void build_phase(uvm_phase phase);
        uvm_report_info(get_full_name(), "build_phase", UVM_LOW);
        super.build_phase(phase);
        driver = apb_master_tb_driver::type_id::create("apb_master_tb_driver", this);
        monitor = apb_master_tb_monitor::type_id::create("apb_master_tb_monitor", this);
    endfunction
 
    
endclass


class apb_master_tb_driver extends uvm_driver;
    `uvm_component_utils(apb_master_tb_driver);
    virtual master_intf intf;
    function new(string name, uvm_component parent = null);
        super.new(name,parent);
        uvm_report_info(get_full_name(), "new", UVM_LOW);
         assert(uvm_resource_db#(virtual master_intf)::read_by_name(
               "master_tb_env", "apb_master_intf", intf));
    endfunction: new
   
    task run_phase (uvm_phase phase);
        int count = 0;
        int txn_outstanding = 0;
        phase.raise_objection(this);
        
        
        uvm_report_info(get_full_name(), "run_phase ", UVM_LOW);
        uvm_report_info(get_full_name(), 
        $sformatf("intf clk is %0x", intf.clk), UVM_LOW);
    
        uvm_report_info(get_full_name(), 
        $sformatf("intf clk is %0x", intf.clk), UVM_LOW);

        forever @(posedge intf.clk)
        begin
            uvm_report_info(get_full_name(), 
              $sformatf("count is %0x", count), UVM_LOW);
            count = count + 1;
            if (count < 4) continue;


            if (!txn_outstanding) 
            begin
                intf.valid = 1;
                intf.source = 0;
                intf.destination = 132;
                intf.length = 10;
                txn_outstanding = 1;
            end
            else if (intf.ready == 1)
            begin
              uvm_report_info(get_full_name(), 
              $sformatf("Breaking... count is %0x", count), UVM_LOW);
                break; 
            end
          
        end
        uvm_report_info(get_full_name(), 
              $sformatf("ended... count is %0x", count), UVM_LOW);
        //phase.drop_objection(this);
    endtask 
 
    
endclass


class apb_master_tb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_master_tb_monitor);
    virtual master_intf intf;

    function new(string name, uvm_component parent = null);
        super.new(name,parent);
        uvm_report_info(get_full_name(), "new", UVM_LOW);
         assert(uvm_resource_db#(virtual master_intf)::read_by_name(
               "master_tb_env", "apb_master_intf", intf));
    endfunction: new
    
    task run_phase (uvm_phase phase);
        uvm_report_info(get_full_name(), "run_phase", UVM_LOW);
        phase.raise_objection(this);
    endtask 

endclass

class apb_master_tb_test extends uvm_test;
  `uvm_component_utils(apb_master_tb_test)

  apb_master_tb_env env;

  function new(string name="apb_master_tb_test", uvm_component parent=null);
    super.new(name, parent);
    uvm_report_info(get_full_name(), "new", UVM_LOW);
  endfunction

  function void build_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "build", UVM_LOW);
    super.build_phase(phase);
    env = apb_master_tb_env::type_id::create("env", this);
  endfunction
endclass
endpackage
