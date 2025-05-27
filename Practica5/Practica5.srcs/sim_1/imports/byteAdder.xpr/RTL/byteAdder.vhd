library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity byteAdder is
	port ( 	A		: in 	std_logic_vector (7 downto 0);
			B		: in 	std_logic_vector (7 downto 0);
			S		: out 	std_logic_vector (7 downto 0);
			C_out	: out 	std_logic
	);
end byteAdder;

architecture Behavioural of byteAdder is
	signal C_internal : std_logic_vector (6 downto 0);

	component fullAdder is 
		port( 	A		: in 	std_logic;
				B		: in    std_logic;
				C_in 	: in 	std_logic;	
				S		: out   std_logic;
				C_out	: out	std_logic
		);
	end component;
	
begin
	FULLADDER1 : fullAdder port map(
		A		=> A(0), 
	    B		=> B(0),
	    C_in 	=> '0',
	    S		=> S(0),
	    C_out	=> C_internal(0)
	);
	
	FULLADDER2 : fullAdder port map(
		A		=> A(1), 
	    B		=> B(1),
	    C_in 	=> C_internal(0),
	    S		=> S(1),
	    C_out	=> C_internal(1)
	);
	
	FULLADDER3 : fullAdder port map(
		A		=> A(2), 
	    B		=> B(2),
	    C_in 	=> C_internal(1),
	    S		=> S(2),
	    C_out	=> C_internal(2)
	);
	
	FULLADDER4 : fullAdder port map(
		A		=> A(3), 
	    B		=> B(3),
	    C_in 	=> C_internal(2),
	    S		=> S(3),
	    C_out	=> C_internal(3)
	);
	
	FULLADDER5 : fullAdder port map(
		A		=> A(4), 
	    B		=> B(4),
	    C_in 	=> C_internal(3),
	    S		=> S(4),
	    C_out	=> C_internal(4)
	);
	
	FULLADDER6 : fullAdder port map(
		A		=> A(5), 
	    B		=> B(5),
	    C_in 	=> C_internal(4),
	    S		=> S(5),
	    C_out	=> C_internal(5)
	);
	
	FULLADDER7 : fullAdder port map(
		A		=> A(6), 
	    B		=> B(6),
	    C_in 	=> C_internal(5),
	    S		=> S(6),
	    C_out	=> C_internal(6)
	);
	
	FULLADDER8 : fullAdder port map(
		A		=> A(7), 
	    B		=> B(7),
	    C_in 	=> C_internal(6),
	    S		=> S(7),
	    C_out	=> C_out
	);
end	Behavioural;
	