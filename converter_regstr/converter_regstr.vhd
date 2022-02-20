library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity converter_regstr is
	port (
		clk: in std_logic;
		stb: in std_logic;		
		discharge_arr: in std_logic_vector(31 downto 0);
		signal_hex: out std_logic
	);
end converter_regstr;

architecture arch of converter_regstr is

signal w1: std_logic_vector (31 downto 0);
signal ct1: std_logic;

begin

process (clk, stb, discharge_arr)
variable ct: integer;
begin
	if (stb='1') then
		w1 <= discharge_arr;
		ct := 0;
		signal_hex <= '0';
	elsif (clk'event and clk='1') then
		w1 <= '0' & w1(31 downto 1);
		-- w1 <= w1(30 downto 0) & '0';
		ct := ct + 1; 
		signal_hex <= w1(0);
		-- signalv <= w1(31);
	end if;
	if (ct > 0) and (ct <= 31) then
		ct1 <= clk;
	else
		ct1 <= '0';
	end if;
end process;
end arch;
	
	