library ieee;
use ieee.std_logic_1164.all;

entity gcd_control is 
	port(
		clk: in std_logic;
		clr: in std_logic;
		go: in std_logic;
		eqflg: in std_logic;
		ltflg: in std_logic;
		xmsel: out std_logic;
		ymsel: out std_logic;
		xld: out std_logic;
		yld: out std_logic;
		gld: out std_logic);
end gcd_control;

architecture gcd_control of gcd_control is
type state_type is ( start, input, test1, test2, update1, update2, done);
signal present_state, next_state : state_type;
begin

sreg: process (clk, clr)
begin
	if clr = '1' then
		present_state <= start;
	elsif clk'event and clk = '1' then	
		present_state <= next_state;
	end if;
end process;

c1:process(present_state,go,eqflg,ltflg)
begin
	case present_state is	
		when start =>
			if go = '1' then	
				next_state <= input;
			else	
				next_state<= start;
			end if;
			
		when input =>
			next_state<=test1;
		when test1 =>
			if eqflg ='1' then 
				next_state <=done;
			else 
				next_state <= test2;
			end if;
		
		when test2 =>
			if ltflg ='1' then
				next_state <= update1;
			else
				next_state <= update2;
			end if;
		when update1 => 
			next_state <=test1;
		when update2 =>
			next_state <= test1;
		when done =>
			next_state <= done;
		when others=>
			null;
	end case;
end process;

c2: process(present_state)
begin
	xld<='0'; yld<='0';gld<='0'; xmsel<='0'; ymsel<='0';
	case present_state is
		when start=>
		when input =>
			xld<='1'; yld<='1';xmsel<='1'; ymsel <='1';
		when update1 =>
			yld<='1';
		when update2=>
			xld<='1';
		when done =>
			gld<='1';
		when others => 
			null;
	end case;
end process;

end gcd_control;


	