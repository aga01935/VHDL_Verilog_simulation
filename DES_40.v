//begining the module for 40 MHZ  deserializer -->which will take 8 bit data and deserialize it with 40 MHZ sampling
// reg --> register used to hold data
module ds_40 (
//inputs and out put are defined here
input reset       , //reset signal
input clock_40    , // clock signal
input [7:0] data_in  , //data in 8 bit
input enable   , // flag to enable the data taking 
output reg data_out  // 1 bit
 
); //end module DES_40


reg [7:0] shifter; // 8 bit shifter to shift the bits as they are de-serialized

always @ (posedge clock_40) begin //only take data at rising edge of the clock
	if(reset) begin 
		shifter <= 8'b00000000; //if reset then shifter is set to 0000000 
	end
	else begin 
		if(enable) begin
			shifter <= data_in;
		end
		else begin
			data_out <= shifter[0];
			shifter <= {1'b0,shifter[7:1]};
		end
	end
end
endmodule // end of module 