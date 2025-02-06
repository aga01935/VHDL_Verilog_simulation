library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--library uvvm_util;


entity tb_des is
	port (
		dt_chk : out std_logic_vector(7 downto 0)
	);

end tb_des;

	
architecture behavior of tb_des is

	--component from deserializer
	component des_40 
		port( 
		clk: in std_logic;
		rst: in std_logic;
		data_in: in std_logic;
		data_out: out std_logic_vector( 7 downto 0) ); 
	end component; -- end component of deserializer	


	--- component deserializer from NDRU xapp1240
	component deser_id_v_2_2 
		port(
		CLK : in  STD_LOGIC;
    	        RST : in std_logic;
      --  	     CLK_OUT : OUT std_logic:='0';
                DT_IN : in  STD_LOGIC:= '0';
                DT_OUT : out  STD_LOGIC_VECTOR (7 downto 0):= (others => '0')
	

	);
	end component;

--signal to connect to test bench and deserializer ports 


--constant input_array is array( 0 to 4) of std_logic_vector(7 downto 0); 
signal clk_40,rst_tb,dt_in : std_logic := '0';
signal dt_out, dt_out_2: std_logic_vector (7 downto 0)  := "00000000";

-- signal clk_40 : std_logic := '0';

begin
	clk_proc: process
	begin
		while true loop
		clk_40 <= '0';
			wait for 12.5 ns;
			clk_40 <='1';
			wait for 12.5 ns;
			end loop;
	end process;

	--clk_40 <= not clk_40 after 12.5 ns; -- 40 MHZ clock
	--clk_160 <=not clock after 3.125 ns; --160 MHZ clock
	maps: des_40 port map( data_in =>dt_in , data_out=>dt_out , clk =>clk_40 , rst =>rst_tb); -- device under test
	maps2: deser_id_v_2_2 port map(DT_IN =>dt_in , DT_OUT=>dt_out_2 , CLK =>clk_40 , RST =>rst_tb); --second device  
	

	--stimulus process
	stim_proc : process
	variable i : integer :=0;
	variable j : integer :=0;
	type vect_array is array (0 to 9) of std_logic_vector (7 downto 0);
	constant  k : vect_array := ("10101011", "11001100", "11110101", "10011010", "11100011", "00110011", "11010101","00110011","01010101", "00011011");
	begin 
		rst_tb <= '1';
		wait for 25 ns;
		rst_tb <='0';
	
		loop 
			--variable i : integer :=0
			if j = 10 then
				exit;
			end if;
			dt_chk <= k(j);
			loop 
				if i = 8 then 
				i:=0;
				exit;
			end if;
			--i :=i+1;
				
				
 				wait until rising_edge(clk_40);
		                report "Entity: data_in = " & std_logic'image(k(j)(i));			
				dt_in <= k(j)(i); --<= not dt_in;
				i :=i+1;
			end loop;
			j := j+1;
			
		end loop;
	wait for 100 ns;
	end process stim_proc;







end behavior;
