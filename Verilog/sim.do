##compiling code
vlog DES_40.v DES_160.v testbench.v 
## to make sure all ports are visible -voptargs=+acc does full visibility to all Modules
vsim tb -voptargs=+acc
## adding the waves

add wave *
## configureing the wave 

## show the wave window

view  wave 

##run the simulation

run 300 ns 
