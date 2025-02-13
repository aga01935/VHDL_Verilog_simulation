-- simple deserializer to test
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity des_simp is

	Port ( 
		-- all input and output port are defined here
		clk : in std_logic :='0';
		rst : in std_logic :='0';
		--enable : in std_logic:='0';
		data_in : in std_logic; -- 1 bit data in 
	        data_out: out std_logic_vector (7 downto 0) --8 bit data out
		); -- end of port

end des_simp;


architecture behavior of des_simp is
signal shifter: std_logic_vector ( 7 downto 0):= "00000000";

begin
process(clk,rst)
variable i: integer :=0;
variable shift: integer:=0 ;
begin
 if rst ='1' then 
	shifter<="00000000";
	i := 0;
	
else 
	  if rising_edge(clk) then
     --loop
		if i = 9 then
		 	i :=1;
      shift:=0;  
			data_out<=shifter;
   
		end if;
   
    if i>0 then
      shifter(i-1) <= data_in;
    end if;
    i := i+1;
    
	end if;
	--end loop; 
end if;
		



end  process;

end behavior;
