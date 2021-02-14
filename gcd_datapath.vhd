library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gcd_datapath is
	port(
		clk: in std_logic;
		clr: in std_logic;
		xmsel: in std_logic;
		ymsel: in std_logic;
		xld: in std_logic;
		yld: in std_logic;
		gld: in std_logic;
		xin: in std_logic_vector(3 downto 0);
		yin: in std_logic_vector(3 downto 0);
		gcd: out std_logic_vector(3 downto 0);
		eqflg: out std_logic;
		ltflg: out std_logic);
end gcd_datapath;

architecture gcd_datapath of gcd_datapath is
	component mux2g
	generic( N: integer);
	port(
		a: in std_logic_vector(N-1 downto 0);
		b: in std_logic_vector(N-1 downto 0);
		s: in std_logic;
		y: out std_logic_vector(N-1 downto 0));
	end component;
	
	component reg
	generic( N: integer:=8);
	port(
		load : in std_logic;
		d: in std_logic_vector(N-1 downto 0);
		clk: in std_logic;
		clr: in std_logic;
		q: out std_logic_vector(N-1 downto 0));
	end component;
	
signal	x,y,x1,y1,xmy,ymx: std_logic_vector(3 downto 0);

begin
	xmy <= x-y;
	ymx <= y-x;
	
	EQ: process (x,y)
	begin
		if x=y then	
			eqflg <='1';
		else
			eqflg <='0';
		end if;
	end process EQ;
	
	LT: process(x,y)
	begin
		if x<y then	
			ltflg <='1';
		else
			ltflg <='0';
		end if ;
	end process LT;
	
M1: mux2g
	generic map( N=>4)
	port map ( a=>xmy, b=>xin, s=> xmsel, y=> x1);
	
M2: mux2g
	generic map( N=>4)
	port map ( a=>ymx, b=>yin, s=> ymsel, y=> y1);

R1: reg
	generic map( N=>4 )
	port map( load => xld, d=>x1, clk =>clk, clr=>clr, q=>x);

R2: reg
	generic map( N=>4 )
	port map( load => yld, d=>y1, clk =>clk, clr=>clr, q=>y);

R3: reg
	generic map( N=>4 )
	port map( load => gld, d=>x, clk =>clk, clr=>clr, q=>gcd);
	
end gcd_datapath;

	
	

	