library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_byteAdder is 
end tb_byteAdder;

architecture Testbench of tb_byteAdder is
	--Inputs
	signal A 	: std_logic_vector (7 downto 0) := (others => '0'); 
	signal B 	: std_logic_vector (7 downto 0) := (others => '0');
	--Outputs
	signal S 	: std_logic_vector (7 downto 0) ;
	signal C_out: std_logic ;
	--Constants
	constant delay : time := 10 ns; 
	component byteAdder is
		port( 	A		: in 	std_logic_vector (7 downto 0);
				B		: in 	std_logic_vector (7 downto 0);
				S		: out 	std_logic_vector (7 downto 0);
				C_out	: out 	std_logic
	);
	end component;
begin
	UUT: component byteAdder
	port map(
		A		=> A,		
	    B		=> B,
	    S	    => S,
	    C_out   => C_out
	);
	
	stimulus: process
	begin
		wait for delay;
		A <= std_logic_vector(to_unsigned(0, A'length));
		B <= std_logic_vector(to_unsigned(0, B'length));
		assert (S = std_logic_vector(to_unsigned(0, S'length))) 
		  report "Sum not 0 for A = 0 B = 0" 
		  severity error;
		assert(C_out  = '0')
		  report "Carry Out not 0 for A = 0 B = 0" 
		  severity error;
		  
		wait for delay;  
		A <= std_logic_vector(to_unsigned(1, A'length));
		B <= std_logic_vector(to_unsigned(0, B'length));
		assert (S = std_logic_vector(to_unsigned(1, S'length))) 
		  report "Sum not 1 for A = 1 B = 0" 
		  severity error;
		assert(C_out  = '0')
		  report "Carry Out not 0 for A = 1 B = 0" 
		  severity error;
              
              
                  wait for delay;  
        A <= std_logic_vector(to_unsigned(7, A'length));
        B <= std_logic_vector(to_unsigned(5, B'length));
        assert (S = std_logic_vector(to_unsigned(12, S'length))) 
          report "Sum not 12 for A = 7 B = 5" 
          severity error;
        assert(C_out  = '0') 
          report "Carry Out not 0 for A = 7 B = 5" 
          severity error;
          
                  wait for delay;  
        A <= std_logic_vector(to_unsigned(50, A'length));
        B <= std_logic_vector(to_unsigned(25, B'length));
        assert (S = std_logic_vector(to_unsigned(75, S'length))) 
          report "Sum not 75 for A = 50 B = 25" 
          severity error;
        assert(C_out  = '0') 
          report "Carry Out not 0 for A = 50 B = 25" 
          severity error;
    
    
		  
        wait for delay;  
		A <= std_logic_vector(to_unsigned(255, A'length));
		B <= std_logic_vector(to_unsigned(100, B'length));
		-- El resultado esperado es 355 que cuando seleccionas solo 8 bits es:
		-- S = 355-256(es el 9 bit) = 99
		assert (S = std_logic_vector(to_unsigned(99, S'length))) 
		 report "Sum not 99 for A = 255 B = 100" 
		 severity error;
		assert (C_out = '1') 
		  report "C_out not 1 for A = 255 B = 100" 
		  severity error;
    end process;
end Testbench;
