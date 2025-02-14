library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- *** uvvm library 
library uvvm_util;
context uvvm_util.uvvm_util_context;
-- library uvvm_vvc_framework;
-- use uvvm_vvc_framework.ti_vvc_framework_support_pkg.all;
-- library bitvis_vip_sbi;
-- context bitvis_vip_sbi.vvc_context;


entity tb_des is


end tb_des;

	
architecture behavior of tb_des is

	--component from deserializer
	component des_40 
		port( 
    data_check:in std_logic_vector (7 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		data_in: in std_logic;
    enable: in std_logic;
		valid: out std_logic;
		data_out: out std_logic_vector( 7 downto 0) ); 
	end component; -- end component of deserializer	


	component des_160
		port( 
    data_check:in std_logic_vector (7 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		data_in: in std_logic;
    enable: in std_logic;
		valid: out std_logic;
		data_out: out std_logic_vector( 7 downto 0) ); 
	end component; -- end component of deserializer	





-- Definging signal to connect to test bench and deserializer ports 

signal dt_chk : std_logic_vector(7 downto 0):=(others=>'0'); -- siganal to check data


signal rst_tb, en_des_40,en_des_160, en_des_simp, valid_tb_40 , valid_tb_160: std_logic := '0'; --flags 

signal clk_160, clk_40: std_logic := '1'; --clocks

signal  data_ser , dt_in: std_logic :='0'; -- data in signal
signal data_ser_check,dt_out, dt_out_2 , dt_out_160: std_logic_vector (7 downto 0)  := "00000000";       --data outputs 





begin
	
   -- *** enable the log messaged
  --enable_log_msg(ALL_MESSAGES);

   disable_log_msg(ALL_MESSAGES);  

  -- ** setting log file name 
  set_log_file_name("log_test.txt");		



   -- *** setting period of clocks ***  
	 clk_40 <= not clk_40 after 12.5 ns; -- 40 MHZ clock
   clk_160 <=not clk_160 after 3.125 ns; --160 MHZ clock
	 
  
   -- *** mapping ports and signal of testbench to DUTs ***
  
   maps: des_40 port map(data_check=>dt_chk, 
                         enable=>en_des_40, 
                         data_in =>dt_in, 
                         data_out=>dt_out , 
                         clk =>clk_40 , 
                         rst =>rst_tb,
                         valid =>valid_tb_40); -- end first device under test


   maps_160: des_160 port map(data_check=>dt_chk, 
                         enable=>en_des_160, 
                         data_in =>dt_in, 
                         data_out=>dt_out_160 , 
                         clk =>clk_160 , 
                         rst =>rst_tb,
                         valid =>valid_tb_160); -- end first device under test
	 
   
 

-- ** process to reset and enable the deserialization  and serialization  operation 
process 
begin
  
  rst_tb <='1';
  
  en_des_40 <='0';
  en_des_160 <='0';
  --en_des_simp <='0'; 
  wait for 100 ns;
  en_des_40 <='1';
  en_des_160 <='1';
  --en_des_simp <='1'; 
  
  wait for 100 ns;
  rst_tb<='0';
  
wait;
end process;
  
--** process to give deserialize data at the clock rising edge ** to do separate deserializer***





process(clk_40) -- now deserializing at 40 MHz clock

variable i : integer :=0;
variable j : integer :=0;
type vect_array is array (0 to 9) of std_logic_vector (7 downto 0);
  	
constant  k : vect_array := ("11101111", "01001100", "11110101", "10011010", "11100011", "00110011", "11010101","00110011","01010101", "00011011");


begin

  if rising_edge(clk_40) then
    
  
  	if j = 9 then -- currently 10 samples so count upto 9
             j := 0;
             
    			end if;
  			
  		  
  				data_ser_check<=k(j); -- input the check data  
          
          
     	if i = 8 then 
    				i:=0;
            if valid_tb_40 ='1' and valid_tb_160 ='1' then
    				  j := j+1;             -- adding j after only after 7 cycles 
            end if;      
		  end if; -- end i counting 
      
      data_ser <= k(j)(i);  --<= not dt_in;
      
     	i :=i+1;
  
  end if; -- end of rising edge for the serializer testbench
   


end process; -- end of deserialization


	-- *** stimulus process *** 

	stim_proc : process(clk_40)

	
   
  
  -- *** begin the stim_proc ***
  begin 
       
      
      if rising_edge(clk_40) then   -- only at rising edge of the clock
       --en_des<= '1';  
		
  		
        log (ID_SEQUENCER, "Data sample value " & to_string(dt_chk) & "valid is : " & to_string(valid_tb_160) & "data out is " & to_string(dt_out) );
         
        
				
	     dt_chk<= data_ser_check;        	
			 
			 dt_in <= data_ser;  --<= not dt_in;
			-- log (ID_SEQUENCER, "checking loop ide i, k =  " & to_string(i) & ", " & to_string(j)  & "data_in  : " & to_string(dt_in));	
				
				
		
			
      end if; -- end rising edge of the clock
			
		
	end process stim_proc;
  -- ** end stim_proc
  
    






end behavior;
