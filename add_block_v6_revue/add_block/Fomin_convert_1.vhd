library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Fomin_convert_1 is
	port (
		num_n: integer range 1 to 4;
		num_x: in std_logic_vector(31 downto 0);
		run: in std_logic;
		time_sig: in std_logic;
		--P_out: out integer;
		--M_out: out integer;
		--p_c1: out integer;
		--z_m: out std_logic;
		res_con_x: out integer;
		tr_signal: out std_logic
	);
end Fomin_convert_1;


architecture convert of Fomin_convert_1 is

function expon(x_in:integer; n_in:integer)
	return integer is
	variable tmp: integer:= 1;
	variable res: integer:= 0;
	begin
		if n_in=0 then
			return tmp;
		end if;
	F: for i in 1 to 8 Loop
	if i <= n_in then
		tmp:= tmp * x_in;
	end if;
	end Loop F;
	res:= tmp;
	return res;
end expon;


signal p1: integer range 1023 downto 0;
signal x1, z, m, pc_1: integer;
signal str, str2, str3: std_logic;
signal count: integer range 0 to 1040;


begin
-- ??????????????? ? int
process(run, num_x, num_n, time_sig)

	begin
	if run = '0' then
		p1 <= 0;
		x1 <= 0;
		z <= 0;
		m <= 0;
		pc_1 <= 0;
		str <= '0';
	elsif (time_sig = '1' and time_sig'event) then
		p1 <=conv_integer(std_logic_vector (num_x(9 downto 0)));
		m <=conv_integer(std_logic_vector (num_x(30 downto 11)));
		z <= expon(2, p1);
		str <= '1';
		if num_x(31)= '0' then
			x1 <= m * z;
		else
			x1 <= (m * z)*(-1);
		end if;
	end if;
	--P_out <= p1;
	--M_out <= m;
	--p_c1 <= z;
	res_con_x <= x1;
	--z_m <= num_x(31);
	
end process;

---
---

process(str, time_sig)

	begin
	if str= '0' then
		count <= 0;
	elsif (time_sig'event and time_sig='1') then
		count <= count + 1;
	end if;
	if count= num_n+p1 then
		str2 <= '1';
	else
		str2 <= '0';
	end if;
	
end process;

---
---

process(time_sig, str2, count)

	begin
	if count < num_n+p1+1 then
		str3 <= '0';
	else
		str3 <= '1';
	end if;
	tr_signal <= str3;

end process;

end convert;
