library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity shift_register_tb is
	-- Generic declarations of the tested unit
		generic(
		n : NATURAL := 4 );
end shift_register_tb;

architecture TB_ARCHITECTURE of shift_register_tb is
	-- Component declaration of the tested unit
	component shift_register
		generic(
		n : NATURAL := 4 );
	port(
		p_in : in STD_LOGIC_VECTOR(n-1 downto 0);
		p_out : out STD_LOGIC_VECTOR(n-1 downto 0);
		reset : in STD_LOGIC;
		clock : in STD_LOGIC;
		shift : in STD_LOGIC;
		load : in STD_LOGIC;
		s_in : in STD_LOGIC );
	end component;
	
	component clk_gen IS
		GENERIC(t_high: TIME:=30ns; t_period: TIME:=50ns; t_reset: TIME:=10ns);
		PORT(clock: OUT std_logic:='1'; reset : OUT std_logic);
	end component ;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal p_in : STD_LOGIC_VECTOR(n-1 downto 0);
	signal reset : STD_LOGIC;
	signal clock : STD_LOGIC;
	signal shift : STD_LOGIC;
	signal load : STD_LOGIC;
	signal s_in : STD_LOGIC; 	
	-- Observed signals - signals mapped to the output ports of tested entity
	signal p_out : STD_LOGIC_VECTOR(n-1 downto 0);

	-- Add your code here ...
	signal step_no: natural;

begin

	-- Unit Under Test port map
	UUT : shift_register
		generic map (
			n => n
		)

		port map (
			p_in => p_in,
			p_out => p_out,
			reset => reset,
			clock => clock,
			shift => shift,
			load => load,
			s_in => s_in
		);
		
	-- Add your stimulus here ...
	
	st: clk_gen PORT MAP(clock => clock);
	
	process(clock)
	begin			
		if clock = '0' then
			load <= '0';	
			reset <= '0';
			shift <= '0';
			s_in <= '0';
			
			
			-- test load
			if step_no = 0 then
				p_in <= ('1','0','1','0');
				load <= '1';
			end if;	  
			if step_no = 1 or step_no = 2 then
				assert p_out = ('1','0','1','0') report "Load doesn't work";
			end if;
			
			
			-- test reset
			if step_no = 10 then
				reset <= '1';
			end if;	
			if step_no = 11 or step_no = 12 then
				assert p_out = ('0','0','0','0') report "Reset doesn't work";
			end if;	
			
			-- test shift with in 0 
			if step_no = 19 then
				load <= '1';
				p_in <= ('1','1','1','1');
			end if;
			if step_no = 20 then
				shift <= '1';
			end if;
			if step_no = 21 then
				assert p_out = ('0','1','1','1') report "Shift with in 0 doesn't work";
			end if;		
			
			-- test shift with in 1
			if step_no = 29 then
				load <= '1';
				p_in <= ('0','0','0','0');
			end if;
			if step_no = 30 then
				shift <= '1';
				s_in <= '1';
			end if;
			if step_no = 31 then
				assert p_out = ('1','0','0','0') report "Shift with in 1 doesn't work";
			end if;		   
			
			-- test shift with in 1 and std_logic more complex
			if step_no = 39 then
				load <= '1';
				p_in <= ('0','1','0','1');
			end if;
			if step_no = 40 then
				shift <= '1';
				s_in <= '1';
			end if;
			if step_no = 41 then
				assert p_out = ('1','0','1','0') report "Shift with in 1 doesn't work";
			end if;		
			
			
			step_no <= step_no + 1;
		end if;		
	end process;	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_shift_register of shift_register_tb is
	for TB_ARCHITECTURE
		for UUT : shift_register
			use entity work.shift_register(schift_register_arch);
		end for;
	end for;
end TESTBENCH_FOR_shift_register;

