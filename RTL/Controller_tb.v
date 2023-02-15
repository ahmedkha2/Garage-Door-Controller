`timescale 1ns/1ps
module Controller_tb;
  reg         Activate;
  reg         UP_Max, DN_Max;
  reg         CLK,RST;
  wire        UP_M,DN_M;

  parameter  CLK_PERIOD  = 20;
  
////////////////////////////////INITIAL//////////////////////// 
initial
  begin
  // Save Waveform
   $dumpfile("Controller_tb.vcd") ;       
   $dumpvars;
   
  //initial values
    initialize();
    
  //reset
    reset();
    
  //test cases
    test();
    $stop;
  end

///////////////////////////TASKS/////////////////////////
task initialize;
  begin
  Activate = 1'b0;
  UP_Max = 1'b0;
  DN_Max = 1'b0;
  CLK = 1'b0;
  end
endtask

task reset;
  begin
    RST = 1'b1;
    #1
    RST = 1'b0;
    #1
    RST = 1'b1;
  end
endtask

task test;
begin
  $display ("*** TEST CASE UP ***");
  Activate = 1'b1;
  UP_Max = 1'b0;
  DN_Max = 1'b1;
  #CLK_PERIOD
  if(UP_M)
    $display ("PASS");
  else
    $display ("FAIL");
/////////////
  $display ("*** TEST CASE IDLE ***");
  Activate = 1'b0;
  UP_Max = 1'b1;
  DN_Max = 1'b0;
  #CLK_PERIOD
  if(DN_M | UP_M)
    $display ("FAIL");
  else
    $display ("PASS");
////////////
  $display ("*** TEST CASE DOWN ***");
  Activate = 1'b1;
  UP_Max = 1'b1;
  DN_Max = 1'b0;
  #CLK_PERIOD
  if(DN_M)
    $display ("PASS");
  else
    $display ("FAIL");
  
end
endtask

//clock generator///////////////////////////////////////
always #10 CLK = ~CLK;

//instantiation//////////////////////////////////////////
Controller DUT(.Activate(Activate),
               .UP_Max(UP_Max),.DN_Max(DN_Max),
               .CLK(CLK),.RST(RST),
               .UP_M(UP_M),.DN_M(DN_M));
               
endmodule