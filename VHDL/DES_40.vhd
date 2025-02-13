library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity des_40 is

	Port ( 
		-- all input and output port are defined here
		data_check:in std_logic_vector (7 downto 0):=(others => '0');  -- check_data to align
    clk : in std_logic :='0';
		rst : in std_logic :='0';
		enable : in std_logic:='0';
		data_in : in std_logic; -- 1 bit data in
    valid : out std_logic:='0'; --1 flag  to indicate the data sent is valid. 
    data_out: out std_logic_vector (7 downto 0) --8 bit data out
		); -- end of port

end des_40;

architecture Behavioral of des_40 is


SIGNAL shifter : std_logic_vector (7 downto 0) :=(others => '0'); -- 8 bit  shift register to shift the bits one at a time and 8 bit loader to load and unload data

begin


-- *** process to  shift the bits one by one

process (rst,clk) -- process start when clock or rst change state

-- ** some variables to count and flags
variable count : integer :=0; -- count to 8 cycles 
variable bit: integer:=7;     -- this is shift normaly it should be 7 but shifts by 1 until it finds the correct 8 bit data
variable  load : integer:=0;  -- flag to trigger load of data if zero bit is added 1

begin 
if rst = '1' then
  shifter <=(others=>'0');
  -- count <= (others=>'0');
  --start <= '0';
else

    if rising_edge(clk) and enable = '1' then
     
      --report "checking thd check data_in: " & to_string(data_check);
       -- report "***************************checking shift  : " & to_string(bit) & "count" & to_string(count);
       if count = bit  then
         count := bit -1 -7;
        
        if load = 1  then 
        
          data_out <= shifter;
        
        else
       
         bit := bit+1;
         --report "########################### shifting bit now **** " & to_string(bit); 
        
        end if; -- load
        
        
      end if;
      
     
        
      
        
         
        shifter (7) <= data_in; -- load the data
        shifter(6 downto 0) <= shifter (7 downto 1); -- shift the data by one bit 
        if  data_check = shifter then
            valid <= '1';
            load := 1;
        
            
        end if;    
       count := count + 1;
       
       
      end if; 
      
     
end if;

end process;




end Behavioral;
