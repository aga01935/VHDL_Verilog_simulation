//testbench for the Des_40 --> 40 MHZ clock and DES_160 for 160 MHZ clock
`timescale 1ns/1ps
module tb; //module for testbench is here 

   reg clk_40; 
   reg clk_160;

   reg rst; 
  // reg en; // reg --> storage of the data or value
   //reg en_160; //
   //reg en_40; // 
   reg [7:0] dt_in ;
   

   wire dt_ser; // 1 bit data that need to connect to deserializer 	 
   wire [7:0] dt_out_40; //wire means transporation of data 
   wire [7:0] dt_out_160; // data out for 160 MHZ deserializer 
   
   
   //wire dt_160_hold ;    // hold the data till counter condition is passed // may be sample 3rd element
   
	

  //Initialize Serrializer 
  Ser uut_s(
  .reset(rst),
  .clock_ser(clk_40),
  .data_in(dt_in),
  //.enable(en),
  .data_out(dt_ser)
  





 ); 


 // Device under  test is initialized here from DES_40.v 

  ds_40 uut (
  
      //all the ports are called as .<port_name>(port_name_to_map)
      .reset(rst),
      .clock_40(clk_40),
      .data_in(dt_ser),
     // .enable(en_40),
      .data_out(dt_out_40)
  
  );
 ds_160 uut2 (
	.reset(rst),
	.clock_160(clk_160),
	.data_in(dt_ser),
	//.enable(en_160),
	.data_out(dt_out_160)

  );

  // Time is on ns precition hence 40 MHZ => 25 ns period so changes state at every 12.5 ns
  always #12.5 clk_40 = ~clk_40; //changing state at every 12.5 ns gap
  always #3.125 clk_160 = ~clk_160;
  //test is started with initial begin <test  steps > end
   reg [7:0]  input_list [3:0]; // list of input to provide   
  integer i;

//	end
  initial begin 
    //start clock at 0 and reset the signal
    rst   =  1 ;
    clk_40 = 1 ;
    clk_160 =1;
   // en =   0 ;
    //en_160 =0; 
    //dt_in =  8'b000000; //data in will be 8 bit binary 00000000
   
    
		
   
    //input_list[2] = 8'b11011011;
    //input_list[1] = 8'b10001100;  
    input_list[0] = 8'b10110110;  

	
	//input_list[0] = {8'b11011011,8'b10001101,8'b10000110};
   // for(i =0; i<1 ; i =i+1) begin
	
    //disable the reset	
    rst = 0   ; // wait for 50 ns
    //reg [2:0] counter  = 3b'000 
   // 	#10  en =1; // then wait for 100 ns for data
    //$display("this is enable %b",en);
    // enable the data taking 
    //repat(10)
     
    	 dt_in <= input_list[0];//8'b10111011 ; //sample data sent in the future it will be provided by some generator
    //#50 en = 1;
        
     	
	 				
    	//#100; //wait  
  
       // en_160=1;  //enablieng the 160 MHZ sampling
     //   en_40 =1; //enabling 40 MHZ sampling
  //  	#50//#18; // this number was picked so that deserializer is  enabled after we get serialized signal  		
      //  en = 0; //enabling the deserializeation
    //    #52
    
     
     
	
   
     //step 1 enabling both at same time 
     //en_160 =0; // disabling after data have been recovered 
     //en_40 =0;	
	
		
    

      //#100 ; // wait for 100 ns
    		
     $display("data_in %b",dt_in);		
    //end
   // #50 en = 1;

    $display("data_out 160 MHz%b  and data out at 40 MHz %b", dt_out_160, dt_out_40) ; 
   	
      if( dt_out_160 == dt_out_40) begin
	$display("160 MHz and 40 MHz sampling are same");
	end
	else 
		$display("160 MHz and 40 MHz sampling not same   #####");
     // dt_in <= 8'bxxxxxxxx;
   //  end
// end simulation

end   

endmodule : tb
