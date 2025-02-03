//begining the module for 40 MHZ  deserializer -->which will take 8 bit data and deserialize it with 40 MHZ sampling
// reg --> register used to hold data
module ds_40 (
//inputs and out put are defined here
input reset       , //reset signal
input enable      , // enable _140 MHZ clocke 
input clock_40    , // clock signal
input data_in  , //data in 1 bit
output reg [7:0]  data_out  // 8 bit
 
); //end module DES_40


reg [7:0] shifter; // 8 bit shifter to shift the bits as they are de-serializer
reg [3:0]  count = 4'b000 ; // this is 4 bit counter to track completion of deserialization  4'b000  means 0 and  4'b1000 means 8

always @ (posedge clock_40) begin //only take data at rising edge of the clock
	if(reset) begin   
		shifter <= 8'b00000000;
		count   <= 4'b0000;
		data_out <=shifter;
		
	end
	else begin //when reset is 0
		if(enable) begin	
			//shifter <= {shifter[6:0], data_in };
			if(data_in == 1'b0 || data_in == 1'b1) begin	// preliminary to check if data is  either 0 or 1 it is x when no data
				count <= count +1;
				shifter <= {data_in,shifter[7:1] };	
				if(count == 4'b1000) begin
				//$display("shifter filled %b, count %b, data  input %b",shifter,count, data_in);			
				data_out = shifter ;
				end
				
			end
			//shifter <= data_in<< 1;
			
		        //$display("data shifer555 %b, count %b, in data %b",shifter,count, data_in);
			//if(shifter[7]===1'b0 || shifter[7] === 1'b1) begin
			//$display("data shifer filled %b, count %b, data  input %b",shifter,count, data_in);	
		        
		end //end enable
				
			

	end //end reset = 0

end //end pos edge of clock
endmodule // end of module