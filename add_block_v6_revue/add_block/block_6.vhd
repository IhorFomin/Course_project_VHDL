library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; use ieee.numeric_std.all;

entity block_6 is
	port (
		start:in std_logic; 
		load: in std_logic;
		clk:in std_logic;
		sequence: in std_logic;
		ask: in std_logic;
		shear_sig: in std_logic;
		key_sig: in std_logic_vector(31 downto 0); 
		count_key:out integer;
		out_kode: out std_logic);
end block_6;

architecture arch of block_6 is

	signal reg1: std_logic_vector (31 downto 0); signal reg2:std_logic;

begin

process (load, clk, key_sig, sequence, ask)

	variable count: integer range 0 to 31;
	variable tmp : std_logic;

	begin

		if (start='0') then 
			reg1<=(others=>'0');
			count:=0;
			out_kode<='0';
		else
			if (load='1') then
				reg1<=key_sig;
			elsif (clk'event and clk='1') and shear_sig='1' and (count < 31) then
				tmp:= (((reg1(0) xor reg1(8))xor reg1(18))xor sequence); 
				reg1<= tmp & reg1(31 downto 1);
				count:=count+1;
			end if;
			if (count>0) and (count < 31) then
				reg2<=tmp;
			else
				reg2<='0';
			end if;
			if ask='1' then
				out_kode<=reg2;
			else
				out_kode<= '0';
			end if;
		end if;
		count_key <= count;

	end process;

end arch;