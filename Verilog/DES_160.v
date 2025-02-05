//begining the module for 160 MHZ  deserializer -->which will take 8 bit data and deserialize it with 60 MHZ sampling
// reg --> register used to hold data
module ds_160 (
//inputs and out put are defined here
input reset       , //reset signal
input enable ,// enable data taking for 160 MHZ
input clock_160    , // clock signal
input data_in  , //data in 1 bit
output reg [7:0]  data_out  // 8 bit
 
); //end module DES_160


reg [7:0] shifter; // 8 bit shifter to shift the bits as they are de-serializer
reg [4:0]  count= 5'b00000 ; // this is 5 bit counter to track completion of deserialization  5'b00000  means 0 and  5'b11111 means 32

always @ (posedge clock_160 ) begin //only take data at rising edge of the clock
	if(reset) begin   
		//shifter <= 8'b00000000;
		count   <= 5'b00000;
		//data_out <=shifter;
		
	end
	else begin //when reset is 0
			if(enable) begin
				
				
				//if(count == 5'b00011) begin 	//save every 3rd element
				if(count === 5'b00000+3) begin 
					shifter = {data_in,shifter[7:1]};
					
				        end
					
				if(count === 5'b00000+4+3)begin 
					shifter <= {data_in,shifter[7:1]};
			              //  $display(" data_in  %b, count %b is count",data_in,count);			
					end
				if(count === 5'b00000+4+4+3)
					shifter <= {data_in,shifter[7:1]};
			
				if(count == 5'b00000+4+4+4+3)
					shifter <= {data_in,shifter[7:1]};
				if(count == 5'b00000+4+4+4+4+3)
					shifter <= {data_in,shifter[7:1] };	
				if(count == 5'b00000+4+4+4+4+4+3)
					shifter <= {data_in,shifter[7:1]};
				if(count == 5'b00000+4+4+4+4+4+4+3)
					shifter <= {data_in,shifter[7:1] };
				if(count == 5'b00000+4+4+4+4+4+4+4+3)
					shifter <= {data_in,shifter[7:1] };			
			
				if(count== 5'b11111) begin
					shifter = {data_in,shifter[7:1]};
					data_out = shifter ;
					count = 5'b0000;
					
				end
				//else
				count <= count +1;
		                //$display("data shifter %b ,  count %b,input %b",shifter,count,data_in); 			
				
			end //end enable

	end //end reset = 0

end //end pos edge of clock
endmodule // end of module 