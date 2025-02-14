library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity des_160 is
  
  
	Port ( 
		-- all input and output port are defined here
		data_check:in std_logic_vector (7 downto 0):=(others => '0');  -- check_data to align
    clk : in std_logic :='0';
		rst : in std_logic :='0';
		enable : in std_logic:='0';
		data_in : in std_logic; -- 1 bit data in
    valid : out std_logic:='0'; --1 flag  to indicate the data sent is valid. 
    --data_out_full: out std_logic_vector (31 downto 0) --32 bit data out for debug
    data_out : out std_logic_vector(7 downto 0) -- 8 bit selected out
    
		); -- end of port

end des_160;

architecture Behavioral of des_160 is


SIGNAL shifter : std_logic_vector (7 downto 0) :=(others => '0'); -- 8 bit  shift register to shift the bits one at a time and 8 bit loader to load and unload data

begin


-- *** process to  shift the bits one by one

process (rst,clk) -- process start when clock or rst change state

-- ** some variables to count and flags
variable count, samp_count : integer :=0; -- count to 8 cycles --samp_count count 4 cycles and then take one of the sample
variable bit: integer:=7;     -- this is shift normaly it should be 7 but shifts by 1 until it finds the correct 8 bit data
variable  shift, load : integer:=0;  -- flag to trigger load of data if zero bit is added 1

begin 
if rst = '1' then
  shifter <=(others=>'0');
  -- count <= (others=>'0');
  --start <= '0';
else

    if rising_edge(clk) and enable = '1' then
     
      --report "checking thd check data_in: " & to_string(data_check);
       --report "***************************checking shift  : " & to_string(bit) & "count" & to_string(count);        
       if count = bit  then
         count := bit -1 -7;
         shift := 0;
         samp_count :=0;
        
        if valid = '1'  then 
          if  data_check = shifter then 
            data_out <= shifter;
            
          end if;
          
        
        else

           bit := bit+1;
             count := bit -1 -7;
          -- report "$$$$$$$$$$$$$$$$$$$$$$$ shifting bit now **** " & to_string(bit); 
        
        end if; -- load
        
        
      end if;
      
     
        
      
        --report "***************************count : " & to_string(count) & " sampling_count: " & to_string(samp_count)& " shifted_data_in: " & to_string(shifter) & "data_in " & to_string(data_in);
        if samp_count = 3 then
          samp_count := 0;
          shift:=1; 
        end if ;
        samp_count := samp_count +1;
        if samp_count = 2 then
          shifter (7) <= data_in; -- load the data  
          shifter(6 downto 0) <= shifter (7 downto 1); -- shift the data by one bit
          
        end if;  
        
        
        if  data_check = shifter then
            valid <= '1';
            load := 1;
        
            
        end if;    
        if shift = 1  then
         --  report "###################################### count: " & to_string(count) & " sampling_count: " & to_string(samp_count)& " shifted_data_in: " & to_string(shifter) & "data_in " & to_string(data_check);
          count := count + 1;
          shift :=0;
          
      
        end if; -- end shift;
        
      end if; 
      
     
end if;

end process;




end Behavioral;
