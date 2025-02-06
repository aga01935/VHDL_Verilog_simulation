library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity des_40 is

	Port ( 
		-- all input and output port are defined here
		clk : in std_logic;
		rst : in std_logic;
		data_in : in std_logic; -- 1 bit data in 
	        data_out: out std_logic_vector (7 downto 0) --8 bit data out
		); -- end of port

end des_40;


architecture Behavioral of des_40 is


SIGNAL loader, shifter : std_logic_vector (7 downto 0) :=(others => '0'); -- 8 bit  shift register to shift the bits one at a time and 8 bit loader to load and unload data

SIGNAL count : std_logic_vector (2 downto 0) := (others =>'0'); -- 3 bit counter initialized to be zero


begin



-- process to  shift the bits one by one
process (rst,clk) -- process start when clock or rst change state

begin 
	if rst ='1' then 
		shifter <= (others =>'0');
	
	elsif clk='1' and clk'event then --rising edge of the clock;
		shifter (7) <= data_in; -- add data to the last the position of 8 bit
		shifter ( 6 downto 0) <= shifter( 7 downto 1); -- shift bit by one position
	end if;
end process;


-- process to load the bits once the count is 8 
process (rst, clk)
begin
	if rst ='1' then
		loader <= (others=> '0');
	elsif clk='1' and clk'event and count=b"111" then
		loader <= shifter; -- load the data when shifting complete 
	end if;
end process;

-- process to run the counter
process(rst,clk)
begin
	if RST ='1' then
		count <= (others =>'0');
	elsif clk='1' and clk'event then
		if count =b"111" then
			count <= b"000"; --if counts upt 8 then reset to zero
		else
			count <=count+'1'; --otherwise count 
		end if; -- end if count 
	end if; --end if reset
end process;


data_out <= loader; -- loding the data to output

end Behavioral;
