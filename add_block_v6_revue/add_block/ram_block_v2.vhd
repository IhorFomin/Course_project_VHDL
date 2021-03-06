library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ram_block_v2 is

port (
	clk: in std_logic;
	y:in std_logic_vector (31 downto 0); 
	adress:in std_logic_vector (4 downto 0);
	write_signal:in std_logic;
	cs:in std_logic;
	date_out:out std_logic_vector (31 downto 0));
end ram_block_v2;

architecture ram_block_v2 of ram_block_v2 is type ram_block_v2 is array (0 to 2**4) of
	std_logic_vector (31 downto 0);
	
	signal ram_block: ram_block_v2;

begin

process (clk)

	variable data:std_logic_vector (31 downto 0);

		begin
		if (clk'event and clk='1') then
			if(write_signal = '0') then
				ram_block (to_integer (unsigned (adress))) <=y;
			elsif (cs='0') then
				data:=ram_block (to_integer (unsigned (adress)));
			else data:= (others => '0');
			end if;
		end if;
	date_out<=data;
	
end process;

end ram_block_v2;