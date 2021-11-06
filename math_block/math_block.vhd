library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity math_block is
	Port ( N : in integer;
		   X : in integer;
		   sum_out: out integer;
		   singX_out: out std_logic);
end math_block;

architecture arch of math_block is

function exp (A: integer; B: integer)
	return integer is
	variable result: integer := 0;
	variable tmp: integer := 1;
begin
	if B = 0 then
		return result;
	elsif A = 0 then
		return tmp;
	end if;
L1: for i in 1 to 16 loop
	if i <= A then
		result := B * tmp;
		tmp := result;
	end if;
end loop L1;
return result;
end;

function Fakt (A: integer)
	return integer is
	variable result: integer := 0;
	variable tmp: integer := 1;
begin
	if A = 0 then
		return result;
	elsif A = 1 then
		return tmp;
	end if;
	
L2: for i in 2 to 15 loop
		if i <= A then
			result := i * tmp;
			tmp := result;
		end if;
end loop L2;
return result;
end;

begin

process(n, X)
		variable temp, temp_r : integer;
		variable a1, a2, a3, a4 : integer;
begin

	a1 := ( exp(3,x)*Fakt(1) ) / exp(1,2);
	a2 := ( exp(5,x)*Fakt(3) ) / exp(2,2);
	a3 := ( exp(7,x)*Fakt(5) ) / exp(3,2);
	a4 := ( exp(9,x)*Fakt(7) ) / exp(4,2);

case n is
	when 1 => temp:= a1;
	when 2 => temp:= a1 + a2;
	when 3 => temp:= a1 + a2 + a3;
	when others => temp:= a1 + a2 + a3 + a4;
end case;

temp_r := x + temp;

if temp_r < 0 then temp_r:= temp_r * (-1);
	singX_out <= '1';
else
	singX_out <= '0';
end if;

sum_out <= temp_r;

end process;

end arch;
