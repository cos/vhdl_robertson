ENTITY clk_gen IS
	GENERIC(t_high: TIME:=30ns; t_period: TIME:=50ns; t_reset: TIME:=10ns);
	PORT(clock: OUT BIT:='1'; reset : OUT BIT);
END clk_gen;

ARCHITECTURE behave_clk_gen OF clk_gen IS
BEGIN
	reset<='0', '1' AFTER t_reset;
	
	PROCESS
	BEGIN
		clock<='1', '0' AFTER t_high;
		WAIT FOR t_period;
	END PROCESS;
END ARCHITECTURE;

entity shift_test is
end;

architecture shift_test_arch of shift_test is
component shift_register is  
		GENERIC (n: NATURAL :=4);
		PORT( p_in: IN BIT_VECTOR(n-1 DOWNTO 0);
	      p_out: OUT BIT_VECTOR(n-1 DOWNTO 0);
	      reset, clock, shift, LOAD : IN BIT;
	      s_in: IN BIT);
end component;	   

component clk_gen IS
	GENERIC(t_high: TIME:=30ns; t_period: TIME:=50ns; t_reset: TIME:=10ns);
	PORT(clock: OUT BIT:='1'; reset : OUT BIT);
end component ;

	signal clock: bit;
	signal p_out: bit_vector(3 downto 0);
	signal p_in: bit_vector(3 downto 0);
	signal start: bit;
	signal step_no: natural;
	signal load: bit;	
	signal reset: bit;	
	signal shift: bit;	   
	signal s_in: bit;
begin		
	st: clk_gen PORT MAP(clock => clock);
	test1: shift_register port map(p_in => p_in, p_out => p_out, reset => reset, clock => clock, shift => shift, load => load, s_in => s_in);
	process(clock)
	begin			
		if clock = '0' then
			load <= '0';	
			reset <= '0';
			shift <= '0';
			s_in <= '0';
			
			if step_no = 0 then
				p_in <= ('1','0','1','0');
				load <= '1';
			end if;	  
			if step_no = 1 or step_no = 2 then
				assert p_out = ('1','0','1','0') report "Load doesn't work";
			end if;
			
			if step_no = 10 then
				reset <= '1';
			end if;	
			if step_no = 11 or step_no = 12 then
				assert p_out = ('0','0','0','0') report "Reset doesn't work";
			end if;	
			
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
			
			
			step_no <= step_no + 1;
		end if;		
	end process;	
end;			

	