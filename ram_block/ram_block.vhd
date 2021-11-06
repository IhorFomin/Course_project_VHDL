library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_block is
	generic (
		address_width: integer:= 8;
		data_width: integer:= 32
	);
	port (
		clk: in std_logic;
		y: in std_logic_vector(data_width - 1 downto 0);
		address: in std_logic_vector(address_width - 1 downto 0);
		write: in std_logic;
		cs: in std_logic;
		--ram_w: out std_logic;
		--ram_r: out std_logic;
		dout: out std_logic_vector(data_width - 1 downto 0)
	);
end ram_block;

architecture arch of ram_block is
	
	type ram_block is array(0 to 2 ** address_width - 1) of std_logic_vector(data_width - 1 downto 0);
	signal ram_blck:ram_block;
	--signal ram_write: std_logic;
	--signal ram_read: std_logic;
	
begin
	
	process (write, clk, cs)
	variable data: std_logic_vector(31 downto 0);
	begin
		
		--if read = '1' then
			--ram_write <= '1';
			--ram_read <= '0';
		--else
			--ram_write <= '0';
			--ram_read <= '1';
		--end if;
		
		--ram_w <= ram_write;
		--ram_r <= ram_read;
		
		if (clk'event and clk = '1') then
			if (write = '0') then
				ram_blck(to_integer(unsigned(address))) <= y;
			elsif (cs = '0') then
				data:= ram_blck(to_integer(unsigned(address)));
			else data:= (others => '0');
			end if;
		end if;
		
		dout <= data;
		
	end process;
end arch;
	
	
	
	
	
	