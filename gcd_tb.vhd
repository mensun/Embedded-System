
library ieee;
use ieee.std_logic_1164.all;

entity tb_gcd is
end tb_gcd;

architecture tb_gcd of tb_gcd is
component gcd 
	port(
		clk: in std_logic;
		clr: in std_logic;
		go: in std_logic;
		xin: in std_logic_vector(3 downto 0);
		yin: in std_logic_vector(3 downto 0);
		gcd_out: out std_logic_vector(3 downto 0));
end component;

signal clk, clr, go: std_logic :='0';	
signal xin, yin,gcd_out :std_logic_vector(3 downto 0);

begin 
g1: gcd port map(clk=>clk, clr=>clr, go=>go,xin=>xin,yin=>yin, gcd_out=>gcd_out);

clock: process
begin
	clk<='0';
	wait for 10 ns;
	clk<='1';
	wait for 10 ns;
end process;

process
begin
	clr<='0';
	go<='0';
	wait for 20 ns;
	xin<="1100";
	yin<="1111";
	go<='1';
	wait for 200ns;


end process;

end tb_gcd;