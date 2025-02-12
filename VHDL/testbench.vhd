library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--library uvvm_util;


entity tb_des is
	port (
		dt_chk : out std_logic_vector(7 downto 0);
    clk_160_chk : out std_logic :='0'
	);

end tb_des;

	
architecture behavior of tb_des is

	--component from deserializer
	component des_40 
		port( 
		clk: in std_logic;
		rst: in std_logic;
		data_in: in std_logic;
		--enable: in std_logic;
		data_out: out std_logic_vector( 7 downto 0) ); 
	end component; -- end component of deserializer	


	--- component deserializer from NDRU xapp1240
	component des_simp 
		port(
		clk : in  STD_LOGIC;
    	        rst : in std_logic;
      --  	     CLK_OUT : OUT std_logic:='0';
                data_in : in  STD_LOGIC:= '0';
                data_out : out  STD_LOGIC_VECTOR (7 downto 0):= (others => '0')
	

	);
	end component;

--signal to connect to test bench and deserializer ports 


--constant input_array is array( 0 to 4) of std_logic_vector(7 downto 0); 
signal clk_160, clk_40,rst_tb,dt_in: std_logic := '0';
signal dt_out, dt_out_2: std_logic_vector (7 downto 0)  := "11111111";

-- signal clk_40 : std_logic := '0';

begin
	

	 clk_40 <= not clk_40 after 12.5 ns; -- 40 MHZ clock
   clk_160 <=not clk_160 after 3.125 ns; --160 MHZ clock
	 maps: des_40 port map( data_in =>dt_in , data_out=>dt_out , clk =>clk_40 , rst =>rst_tb); -- device under test
	 maps2: des_simp port map(data_in =>dt_in , data_out=>dt_out_2 , clk =>clk_40 , rst =>rst_tb); --second device  
	

	--stimulus process
	stim_proc : process(clk_40)
	variable i : integer :=0;
	variable j : integer :=0;
	type vect_array is array (0 to 9) of std_logic_vector (7 downto 0);
	constant  k : vect_array := ("11111111", "01001100", "11110101", "10011010", "11100011", "00110011", "11010101","00110011","01010101", "00011011");
	begin 
      		  
      
      if rising_edge(clk_40) then
        
		
  			if j = 9 then
           j := 0;
           
  			end if;
			
		    clk_160_chk<= clk_160; 
				dt_chk<=k(j);
				if i = 8 then 
  				i:=0;
  				j := j+1;
				end if;
	             	
			
			 dt_in <= k(j)(i); --<= not dt_in;
				
				
				
				i :=i+1;
			end if; -- end rising edge of the clock
			
		
	end process stim_proc;
  
    






end behavior;
