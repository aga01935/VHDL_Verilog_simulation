//testbench for the Des_40 --> 40 MHZ clock and DES_160 for 160 MHZ clock
`timescale 1ns/1ps
module tb; //module for testbench is here 

   reg clk_40; 
   reg clk_160;

   reg rst; 
   reg en; // reg --> storage of the data or value
  
   reg [7:0] dt_in ;
   
   wire  dt_out_40; //wire means transporation of data
   wire  dt_out_160; // data out for 160 MHZ deserializer 
   
  // Device under  test is initialized here from DES_40.v 

  ds_40 uut (
  
      //all the ports are called as .<port_name>(port_name_to_map)
      .reset(rst),
      .clock_40(clk_40),
      .data_in(dt_in),
      .enable(en),
      .data_out(dt_out_40)
  
  );
 ds_160 uut2 (
	.reset(rst),
	.clock_160(clk_160),
	.data_in(dt_in),
	.enable(en),
	.data_out(dt_out_160)

  );

  // Time is on ns precition hence 40 MHZ => 25 ns period so changes state at every 12.5 ns
  always #12.5 clk_40 = ~clk_40; //changing state at every 12.5 ns gap
  always #3.125 clk_160 = ~clk_160;
  //test is started with initial begin <test  steps > end
  
  initial begin 
    //start clock at 0 and reset the signal
    rst   =  1 ;
    clk_40 = 1 ;
    clk_160 =1;
    en =   0 ;
    dt_in =  8'b00000000; //data in will be 8 bit binary 00000000
    //dt_out = 1'b0;        //dataout is 1 bit binary --> 0 initially 
    rst = 0   ; // wait for 50 ns
   
     //disable the reset
    
    #25  en =1; // then wait for 50 ns for data
    $display("this is enable %b",en);
    // enable the data taking 
    //repat(10)
    dt_in = 8'b10111011 ; //sample data sent in the future it will be provided by some generator
    //#50 en = 1;
     $display("data_in %b",dt_in);		
    //end
   // #50 en = 1;
    #50 en = 0;
		
    $display("data_out %b", dt_out_160) ;

    #100000 ; // wait for 100 ns
    
 // end simulation

   
    
  end

endmodule : tb
