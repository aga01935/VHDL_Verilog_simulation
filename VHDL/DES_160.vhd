library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity des_160 is

	Port ( 
		-- all input and output port are defined here
		clk : in std_logic :='0';
		rst : in std_logic :='0';
		enable : in std_logic:='0';
		data_in : in std_logic; -- 1 bit data in 
    data_out: out std_logic_vector (7 downto 0) --8 bit data out
		); -- end of port

end des_160;

architecture Behavioral of des_160 is


SIGNAL shifter : std_logic_vector (7 downto 0) :=(others => '0'); -- 8 bit  shift register to shift the bits one at a time and 8 bit loader to load and unload data
SIGNAL start : std_logic :='0';
SIGNAL count : std_logic_vector (3 downto 0) := (others =>'0'); -- 4 bit counter initialized to be zero


begin



-- process to  shift the bits one by one
process (rst,clk) -- process start when clock or rst change state
variable x : integer :=0; 
begin 
if rst = '1' then
  shifter <=(others=>'0');
  count <= (others=>'0');
  start <= '0';
else
   
    if rising_edge(clk) then
     -- report "Entity: start is now = " & std_logic'image(start);
      
      --if count = "1001" then
        --count <= "0001";
       if x = 9 then
           X := 1;
        data_out <= shifter;
      end if;
      
     
        
      
      
     
         report "Entity: count is now = " & integer'image(x); 
         report "Entity: data_in = " & std_logic'image(data_in); 
        shifter (7) <= data_in; -- load the data
        shifter(6 downto 0) <= shifter (7 downto 1); -- shift the data by one bit 
    
       count <= count + 1;
       x :=x+1;
       
      end if; 
      
     
end if;

end process;




end Behavioral;
