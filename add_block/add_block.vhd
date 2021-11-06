library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity add_block is

port (n: in integer range 1 to 4;
x: in std_logic_vector(31 downto 0);
start: in std_logic;
clk: in std_logic;
---выходы 1
signal_1: out integer;
strob: out std_logic;
----
z_signal_2: out std_logic;
signal_2: out integer
);
end;

architecture arch of add_block is

component Fomin_convert_1 is
	port (
		num_n: integer range 1 to 4;
		num_x: in std_logic_vector(31 downto 0);
		run: in std_logic;
		time_sig: in std_logic;
		res_con_x: out integer;
		tr_signal: out std_logic
	);
end component;

component math_block is
	Port ( num_N2 : in integer;
		   Num_X2 : in integer;
		   res_sum: out integer;
		   contr_sign_x_out: out std_logic);
end component;

signal k1,v1 :integer;
signal k2,v2 :std_logic;

begin
t1: Fomin_convert_1
port map (
	num_n=>n,
	num_x=>x,
	run=>Start,
	time_sig=>clk,
	res_con_x=>k1,
	tr_signal=>k2
);
Strob<=k2;
signal_1<=k1;

t2: math_block
port map (
	num_N2=>n,
	num_X2=>k1,
	res_sum=>v1,
	contr_sign_x_out=>v2
);
signal_2<=v1;
z_signal_2<=v2;

end arch;
