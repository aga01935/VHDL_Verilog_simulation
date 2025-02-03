//begining the module for X MHZ  serializer  -->which will take 8 bit data and serialize it as X MHz signal
// reg --> register used to hold data
module Ser (
//inputs and out put are defined here
input reset       , //reset signal
input clock_ser   , // clock signal
input [7:0] data_in  , //data in 8 bit
input enable   , // flag to enable the data taking 
output reg data_out  // 1 bit
 
); //end module Ser


reg [7:0] shifter; // 8 bit shifter to shift the bits as they are serialized

always @ (posedge clock_ser) begin //only take data at rising edge of the clock
	if(reset) begin 
		shifter <= 8'b00000000; //if reset then shifter is set to 0000000 
	end
	else if(enable) begin
		shifter <= data_in;
		end
	else begin	
		shifter <= {1'b0,shifter[7:1]};
		data_out <= shifter[0];
			
	end
end
endmodule // end of module