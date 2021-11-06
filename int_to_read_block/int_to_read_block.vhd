library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity int_to_read_block is
	port (
		x: in integer;
		clk, start: in std_logic;
		sign: in std_logic;
		stb: in std_logic;
		--clk_11, clk_22: out std_logic;
		x_real: out std_logic_vector(31 downto 0);
		count: out integer range 0 to 20;
		-- Eciaieou iacaaiey ia naie
		recording: out std_logic; -- caienu a iia?aoeaio? iaiyou (zap)
		reading: out std_logic; -- ?oaiea iia?aoeaiie iaiyoe (cht) 
		shift: out std_logic; -- oi?aaeaiea a aeieii (sdvig)
		shift_key: out std_logic -- 6 (sdvig_key)
		--count2: out integer
	);
end int_to_read_block;

architecture arch of int_to_read_block is
	
signal clk1, clk2: std_logic;
signal count_t: integer;

begin
	
clk1 <= stb and clk;

process (clk1, x, stb, start)

variable m1: std_logic_vector(19 downto 0);
variable p1: std_logic_vector(9 downto 0);
variable coun: integer range 0 to 20;

begin

	clk2 <= clk1 and not m1(19);
	
	if (start = '0') and (stb = '0') then
		m1:= conv_std_logic_vector(x, 20);
		coun:= 20;
		x_real <= (others => '0');
	elsif (clk2 = '1' and clk2'event) then
		m1:= m1(18 downto 0)& '0';
		coun:= coun - 1;
	end if;
	
	if m1(19) = '0' then
		count_t <= 0;
	elsif (clk1 = '1' and clk1'event) then
		count_t <= count_t + 1;
	end if;
	
	if (count_t = 2) then
		recording <= '0';
	else
		recording <= '1';
	end if;
	
	if (count_t > 2) then
		reading <= '0';
	else
		reading <= '1';
	end if;
	
	if count_t < 8 then
		shift <= '0';
	else
		shift <= '1';
	end if;
	
	if count_t <= 7 then
		shift_key <= '0';
	else
		shift_key <= '1';
	end if;
	
	--count2 <= count_t;
	
	x_real(31) <= sign;
	x_real(30 downto 11) <= m1;
	x_real(10) <= '0';
	p1:= conv_std_logic_vector(coun, 10);
	x_real(9 downto 0) <= p1;
	count <= coun;
	--clk_22 <= clk2;
	--clk_11 <= clk1;

end process;

end arch;


