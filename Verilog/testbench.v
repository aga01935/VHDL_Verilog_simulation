//testbench for the Des_40 --> 40 MHZ clock and DES_160 for 160 MHZ clock
`timescale 1ns/1ps
module tb; //module for testbench is here 

   reg clk_40; 
   reg clk_160;

   reg rst; 
   reg rst_ser; //reset for serializer
   reg en; // reg --> storage of the data or value
   reg en_160; //
   reg en_40; // 
   reg [7:0] dt_in ;
   

   wire dt_ser; // 1 bit data that need to connect to deserializer 	 
   wire [7:0] dt_out_40; //wire means transporation of data 
   wire [7:0] dt_out_160; // data out for 160 MHZ deserializer 
   
   
   //wire dt_160_hold ;    // hold the data till counter condition is passed // may be sample 3rd element
   
	

  //Initialize Serrializer 
  Ser uut_s(
  .reset(rst_ser),
  .clock_ser(clk_40),
  .data_in(dt_in),
  .enable(en),
  .data_out(dt_ser)
  





 ); 


 // Device under  test is initialized here from DES_40.v 

  ds_40 uut (
  
      //all the ports are called as .<port_name>(port_name_to_map)
      .reset(rst),
      .clock_40(clk_40),
      .data_in(dt_ser),
      .enable(en_40),
      .data_out(dt_out_40)
  
  );
 ds_160 uut2 (
	.reset(rst),
	.clock_160(clk_160),
	.data_in(dt_ser),
	.enable(en_160),
	.data_out(dt_out_160)

  );

  // Time is on ns precition hence 40 MHZ => 25 ns period so changes state at every 12.5 ns
  always #12.5 clk_40 = ~clk_40; //changing state at every 12.5 ns gap
  always #3.125 clk_160 = ~clk_160;
  //test is started with initial begin <test  steps > end
  

//	end
  initial begin 
    rst <= 0;
    clk_40<=1;
    
    #2 clk_160<=1;
    en_160 <=0;
    en_40 <=0;
    rst_ser =1;	
    #10 rst <=1;
    #10 rst =0;
   
   //repeat (10) begin
    dt_in <= 8'b10101011; 
    //repeat(10) begin
    #2 en =1;
   
    rst_ser<=1;
    #4 en =0;
    rst_ser<=0;
  
    #25 en_40 =1;
    en_160 <=1;
	  	
    #198 en <=1 ;
    dt_in <=8'b11101011;
   
   // en_40 <=0;
   // en_160 <=0;		
	
    #25 en =0;
    
    //#6.25 en_160 =1;
   // #6.25 en_40 <=1;	
  //   end
    
    #225 en <=1 ;
    dt_in <=8'b11001111;
   
   // en_40 <=0;
//    en_160 <=0;		
	
    #25 en =0;
    
  //  #6.25 en_160 =1;
  //  #6.25 en_40 <=1;	
  //   end
     	
    
   // end

    	
     
      		
    

end   

endmodule : tb
