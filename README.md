# VHDL_Verilog_simulation
## This will contain some examples of VHDL and Verilog simulation created
### Verilog code V1 basic and old
<ul>
<li>Verilog/testbench.v contains the testbench framework for the simulation  
<li> Verilog/DES_40.v creates serializer block with 40 MHz sampling
<li> Verilog/DES_160.v is copy of DES_40.v for 160 MHz sampling 
<li> Verilog/sim.do is just a script to compile and run the simulation 
<li> Verilog/Ser.v serialize the 8 bit data into 1 bit signal at 40 MHz

</ul>

### VHDL code with some UVVM in testbench latest
<ul>
<li>VHDL/testbench.vhd contains the testbench framework for the simulation with UVVM log 
<li> VHDL/DES_40.vhd creates serializer block with 40 MHz sampling with dynamic phase 
<li> VHDL/DES_simp.vhd creates serializer block with 40 MHz sampling but with basic fixed phase 
<li> VHDL/DES_160.vhd is copy of DES_40.v for 160 MHz sampling --> to do 
<li> VHDL/sim.do is just a script to compile and run the simulation --> to do 
<li> VHDL/Ser.vhd serialize the 8 bit data into 1 bit signal at 40 MHz --> to do 


</ul>


[Example output of first version of testbench](images/phase_detect_v1.png)
<img src="images/phase_detect_v1.png" width="1000" />
