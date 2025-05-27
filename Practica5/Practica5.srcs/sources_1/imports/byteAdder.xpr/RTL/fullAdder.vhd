library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fullAdder is
	port ( 	A		: in 	std_logic;
			B		: in    std_logic;
			C_in 	: in 	std_logic;	
			S		: out   std_logic;
			C_out	: out	std_logic
	);
end fullAdder; 

architecture Behavioural of fullAdder is
	signal S_halfAdder1 : std_logic;
	signal C_halfAdder1 : std_logic;
	signal C_halfAdder2 : std_logic;
	
	component halfAdder is
		port ( 	A		: in 	std_logic;
				B		: in    std_logic;
				S		: out   std_logic;
				C_out	: out	std_logic
			);
	end component;
	
begin
	HALFADDER1 : halfAdder port map(
			A		=>	A,
			B	    =>	B,
			S	    =>	S_halfAdder1,
			C_out   =>	C_halfAdder1
	);
	
	HALFADDER2 : halfAdder port map(
			A		=>	C_in,
			B	    =>	S_halfAdder1,
			S	    =>	S,
			C_out   =>	C_halfAdder2
	);
	
	C_out <= C_halfAdder1 or C_halfAdder2;
	
end Behavioural;