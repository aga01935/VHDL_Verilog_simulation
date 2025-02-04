//begining the module for X MHZ  serializer  -->which will take 8 bit data and serialize it as X MHz signal
// reg --> register used to hold data
module Ser (
//inputs and out put are defined here
input reset       , //reset signal
input clock_ser   , // clock signal
input [7:0] data_in  , //data in 8 bit
//input enable   , // flag to enable the data taking 
output reg data_out  // 1 bit
 
); //end module Ser


reg [7:0] shifter; // 8 bit shifter to shift the bits as they are serialized
reg[3:0] count =4'b0000; //counter
reg hold  ; //hold until the process is complete
reg[3:0] delay_count =4'b0000 ;



always @ (posedge clock_ser) begin //only take data at rising edge of the clock
	if(reset) begin 
		shifter <= 8'b00000000; //if reset then shifter is set to 0000000 
		count = 4'b0000; //reset the counter
		hold = 1'b0 ;
		
		
		
	end
	else begin
		 if(count == 4'b0000 &&!hold) begin
		 shifter <= data_in;
		//$display("counter %b, %b data_in", count,data_in);
		 data_out <=shifter[0];
		 $display("counter %b, %b data_in ", count,data_in);
		 hold = 1'b1;
		 
		end
		else  begin	
			shifter <= {1'b0,shifter[7:1]};
			data_out <= shifter[0];
			count <= count +1;
			if(count ==4'b1000) begin
				hold = 1'b0;
				count=4'b0000;
			end//complete count
			$display("data out %b , data_in   %b, count %b, shifter %b", data_out, data_in, count, shifter);
		end
	end
			
	
end
endmodule // end of module