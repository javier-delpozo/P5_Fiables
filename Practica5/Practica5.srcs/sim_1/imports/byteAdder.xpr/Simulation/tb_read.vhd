library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_read is 
end tb_read;

architecture test of tb_read is
	--File handler
	file file_input : text; 	

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
	proc_sequencer : process
	-- Process to read the data
		file text_file :text open read_mode is "inputs.csv";
		variable text_line : line; -- Current line
		variable ok: boolean; -- Saves the status of the operation of reading
		variable char : character; -- Read each character of the line(used when using comments)
		variable delay: time; -- Saves the desired delay time
		variable data: integer; --Generates a variable of the first operand (A) type
		variable expected_sum: S'subtype;
		variable expected_C: C_out'subtype;
	begin
		while not endfile(text_file) loop
			readline(text_file, text_line);
			-- Skip empty lines and commented lines
			if text_line.all'length = 0 or text_line.all(1) = '#' then
				next;
			end if;
			-- Read the delay time
			read(text_line, delay, ok);
			assert ok
				report "Read 'delay' failed for line: " & text_line.all
				severity failure;
			-- Read first operand (A)
			read(text_line, data, ok);
			assert ok
				report "Read 'A' failed for line: " & text_line.all
				severity failure;
			A <= std_logic_vector (to_unsigned(data,A'length));
			-- Read the second operand (B)
			read(text_line, data, ok);
			assert ok
				report "Read 'B' failed for line: " & text_line.all
				severity failure;
			B <= std_logic_vector (to_unsigned(data,B'length));
			
			-- Wait for the delay
			wait for delay;
			
			-- Print the comments(if any) to console
			-- Print trailing comment to console, if any
			read(text_line, char, ok); -- Skip expected newline
			read(text_line, char, ok);
			if char = '#' then
				read(text_line, char, ok); -- Skip expected newline
				report text_line.all;
			end if;
			
			--Verify the sum and carry is correct
			expected_sum := std_logic_vector(unsigned(A)+unsigned(B));
			if unsigned(expected_sum) > 255 then
				expected_C := '1';
			else
				expected_C := '0';
			end if;
			
			assert expected_sum = S
				report "Unexpected result: " &
					"A = "& integer'image(to_integer(unsigned(A))) & "; "&
					"B = "& integer'image(to_integer(unsigned(B))) & "; "&
					"SUM = "& integer'image(to_integer(unsigned(S))) & "; "&
					"SUM_expected = " & integer'image(to_integer(unsigned(expected_sum)))
				severity error;
			assert expected_C = C_out
				report "Unexpected result: " &
					"A = "& integer'image(to_integer(unsigned(A))) & "; "&
					"B = "& integer'image(to_integer(unsigned(B))) & "; "&
					"C = "& std_logic'image(C_out) & "; "&
					"C_expected = " & std_logic'image(expected_C )
				severity error;
				
		end loop;
		report "Finished" severity FAILURE; 
	
  end process;
end test;