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
reg [7:0] temp_load; // 8 bit loader temporarily load the data
reg [2:0] count; // count when bit shift is completed

always @ (posedge clock_ser) begin
	if(enable)
		temp_load  <=data_in; // load data in memory first before dumping 
	
end
always @ (posedge clock_ser) begin //only take data at rising edge of the clock
	if(reset) begin 
		shifter <= 8'b00000000; //if reset then shifter is set to 0000000  /******/to do change it to standard no signal bits
	        count <=   3'b000;
	end
	else begin
		shifter <= {1'b0,shifter[7:1]};
		data_out <= shifter[0];
		count <= count +1; 	
		//if(enable) begin
		        if(count ==3'b111) begin
				shifter <= temp_load; //oly dump when last data is completed
				count= 3'b000;

		        end //load data
		//else begin	
			
		end// dump
	end //reset = 0
endmodule // end of module