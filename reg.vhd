library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	generic(N:integer :=9);
	port(
		load : in std_logic;
		clk : in std_logic;
		clr : in std_logic;
		d : in std_logic_vector(N-1 downto 0);
		q : out std_logic_vector(N-1 downto 0));
end reg;

architecture reg of reg is
begin
	process(clk,clr)
	begin
		if clr = '1' then 
			q<=(others => '0');
		elsif clk'event and clk ='1' then	
			if load = '1' then
				q<=D;
			end if;
		end if;
	end process;
end reg;
