library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity math_block is
	Port ( num_N2 : in integer;
		   num_X2 : in integer;
		   res_sum: out integer;
		   contr_sign_x_out: out std_logic);
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

process(num_N2, num_X2)
		variable temp, temp_r : integer;
		variable a1, a2, a3, a4 : integer;
begin

	a1 := ( exp(3,num_X2)*Fakt(1) ) / exp(1,2);
	a2 := ( exp(5,num_X2)*Fakt(3) ) / exp(2,2);
	a3 := ( exp(7,num_X2)*Fakt(5) ) / exp(3,2);
	a4 := ( exp(9,num_X2)*Fakt(7) ) / exp(4,2);

case num_N2 is
	when 1 => temp:= a1;
	when 2 => temp:= a1 + a2;
	when 3 => temp:= a1 + a2 + a3;
	when others => temp:= a1 + a2 + a3 + a4;
end case;

temp_r := num_X2 + temp;

if temp_r < 0 then temp_r:= temp_r * (-1);
	contr_sign_x_out <= '1';
else
	contr_sign_x_out <= '0';
end if;

res_sum <= temp_r;

end process;

end arch;
