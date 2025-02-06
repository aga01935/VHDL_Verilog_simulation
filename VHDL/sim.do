## compiling code

vcom DES_40.vhd testbench.vhd deser_id_v_2_2.vhd


vsim tb_des

add wave *


view wave 

run 500 ns
