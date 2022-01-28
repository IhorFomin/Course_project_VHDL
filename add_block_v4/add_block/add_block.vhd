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
--------------------------------
z_signal_2: out std_logic;
signal_2: out integer;
--------------------------------
clk_1, clk_2:out std_logic;
blk_3_a:out std_logic_vector(31 downto 0);
blk_3_b:out integer range 0 to 20;
blk_3_c, blk_3_d, blk_3_e, blk_3_f:out std_logic;
--------------------------------
adress: in std_logic_vector(4 downto 0);
blk_4_z: out std_logic_vector(31 downto 0);
--blk_4_out: out std_logic_vector(31 downto 0);
--------------------------------
--blk5_buff: out std_logic_vector(31 downto 0);
blk_5_signal: out std_logic
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

component int_to_read_block is
	Port (
	x: in integer;
	clk, start: in std_logic;
	sign: in std_logic;
	stb: in std_logic;
	clk_11, clk_22: out std_logic;
	x_real: out std_logic_vector(31 downto 0);
	count: out integer range 0 to 20;
	-- Eciaieou iacaaiey ia naie
	recording: out std_logic; -- caienu a iia?aoeaio? iaiyou (zap)
	reading: out std_logic; -- ?oaiea iia?aoeaiie iaiyoe (cht) 
	shift: out std_logic; -- oi?aaeaiea a aeieii (sdvig)
	shift_key: out std_logic -- 6 (sdvig_key)
	--count2: out integer
	);
end component;

component ram_block_v2 is
	Port (
	clk: in std_logic;
	y:in std_logic_vector (31 downto 0); adress:in std_logic_vector (4 downto 0);
	write:in std_logic;
	cs:in std_logic;
	dout:out std_logic_vector (31 downto 0)
	);
end component;

component converter_regstr is
	Port (
	clk: in std_logic;
	stb: in std_logic;		
	discharge_arr: in std_logic_vector(31 downto 0);
	signal_hex: out std_logic
	);
end component;

-----------------------
signal k1,v1 :integer;
signal k2,v2 :std_logic;
-----------------------
signal c, d, e, f: std_logic;
signal a, z: std_logic_vector(31 downto 0);
signal stb_n: std_logic;
-----------------------
signal blk5_1: std_logic;
---signal blk5_buff: std_logic_vector(31 downto 0);
-----------------------

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
strob<=k2;
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

t3: int_to_read_block
port map (
	x=>v1,
	clk=>clk,
	start=>start,
	sign=>v2,
	stb=>k2,
	clk_11=>clk_1,
	clk_22=>clk_2,
	x_real=>a,
	count=>blk_3_b,
	recording=>c,
	reading=>d,
	shift=>e,
	shift_key=>f
);
blk_3_a<=a;
blk_3_c<=c;
blk_3_d<=d;
blk_3_e<=e;
blk_3_f<=f;

t4: ram_block_v2
port map (
	adress=>adress,
	clk=>clk,
	y=>a,
	write=>c,
	cs=>d,
	dout=>z
);
blk_4_z<=z;
--blk5_buff<=z;

t5: converter_regstr
port map (
	clk=>clk,
	stb=>not f,
	discharge_arr=>z,
	signal_hex=>blk5_1
);
blk_5_signal<=blk5_1;

end arch;
