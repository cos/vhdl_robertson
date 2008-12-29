ENTITY shift_register IS
	GENERIC (n: NATURAL :=4);
	PORT( p_in: IN BIT_VECTOR(n-1 DOWNTO 0);
	      p_out: OUT BIT_VECTOR(n-1 DOWNTO 0);
	      reset, clock, shift, load : IN BIT;
	      s_in: IN BIT);
END;

architecture schift_register_arch of shift_register is
begin
	process(clock)
	variable reg:bit_vector (n-1 downto 0);
	begin		 				 
		if clock = '1'	then
			-- Everything here			
			if load = '1' then
				reg := p_in;
			end if;				
			
			if reset = '1' then
				reg := (others => '0');
			end if;			
			
			if shift = '1' then
				for i in 0 to n-2 loop
					reg(i) := reg(i+1);
				end loop;
				reg(n-1) := s_in;
			end if;			
			
			p_out <= reg;
			-- everything here
		end if;								
	end process;
end;
