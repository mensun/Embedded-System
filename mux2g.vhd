library ieee;
use ieee.std_logic_1164.all;

entity mux2g is 
	generic(N:integer  :=4);
	port(
		a: in std_logic_vector(N-1 downto 0);
		b: in std_logic_vector(N-1 downto 0);
		s: in std_logic;
		y: out std_logic_vector(N-1 downto 0));
end mux2g;

architecture mux2g of mux2g is
begin
	p1: process (a,b,s)
	begin
		if s='0' then
			y<=a;
		else
			y<=b;
		end if;
	end process;
end mux2g;
		