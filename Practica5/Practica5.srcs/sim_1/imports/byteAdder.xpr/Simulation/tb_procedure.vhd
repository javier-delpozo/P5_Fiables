library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_procedure_adder is 
end tb_procedure_adder;

architecture test of tb_procedure_adder is
	-- Delay between results
	constant c_delay : time := 10ns;

	-- ports for the adder
	signal A 	: std_logic_vector(7 downto 0); -- First operand
	signal B 	: std_logic_vector(7 downto 0); -- Second operand
	signal S 	: std_logic_vector(7 downto 0);	-- Sum out
	signal C_out: std_logic;	-- Carry out
    component  byteAdder is 
    port( 	A		: in 	std_logic_vector (7 downto 0);
            B		: in 	std_logic_vector (7 downto 0);
            S		: out 	std_logic_vector (7 downto 0);
            C_out	: out 	std_logic
	);
	end  component;
begin
	-- Instantiate the adder
	DUT: component byteAdder 
	port map(
		A 		=> A,
		B  		=> B,
		S 		=> S,
		C_out	=> C_out
	);
	
	simulation: process
	
		procedure check_add(
			constant in1 	: in natural;
			constant in2	: in natural
		)is
		  variable expected_S		: natural;
		  variable expected_C_out	: std_logic;
		  variable actual_S 		: natural;
		  variable actual_C_out	    : std_logic;
		begin
			A  	<= std_logic_vector(to_unsigned(in1, A'length));
			B	<= std_logic_vector(to_unsigned(in2, B'length));
			wait for c_delay;
			actual_S := to_integer(unsigned(S));
			actual_C_out := C_out;
			-- Calculate the expected value of the addition
			expected_S := to_integer(to_unsigned((in1 + in2), S'length));
			-- Calculate the expected value of the carry
			if (in1 + in2) > 255 then
				expected_C_out := '1';
			else
				expected_C_out := '0';
			end if;
			-- Verify the sum is correct
			assert actual_S = expected_S
			report 	"Unexpected result: " &
					"A = "& integer'image(in1) & "; "&
					"B = "& integer'image(in2) & "; "&
					"SUM = "& integer'image(actual_S) & "; "&
					"SUM_expected = " & integer'image(expected_S)
			severity error;
			-- Verify the carry is correct
			assert actual_C_out = expected_C_out 
			report 	"Unexpected result: " &
					"A = "& integer'image(in1) & "; "&
					"B = "& integer'image(in2) & "; "&
					"C = "& std_logic'image(actual_C_out ) & "; "&
					"C_expected = " & std_logic'image(expected_C_out )
			severity error;
		end procedure check_add;
  begin  
  for i in 0 to 254 loop
    for j in 0 to 254 loop
		check_add(i,j);
	end loop;
  end loop;
  report "Finished" severity FAILURE;  
  end process;
end test;