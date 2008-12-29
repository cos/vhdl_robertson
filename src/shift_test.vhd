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
begin		
	st: clk_gen PORT MAP(clock => clock);
	test1: shift_register port map(p_in => p_in, p_out => p_out, reset => '0', clock => clock, shift => '0', load => load, s_in => '0');
	process(clock)
	begin			
		if clock = '1' then
			load <= '0';
			if step_no = 0 then
				p_in <= ('1','0','1','0');
				load <= '1';
			end if;						
		else   
			if step_no = 1 then
				assert p_out = ('1','0','1','0') report "Load doesn't work";
			end if;			
			step_no <= step_no + 1;
		end if;		
	end process;	
end;			

	