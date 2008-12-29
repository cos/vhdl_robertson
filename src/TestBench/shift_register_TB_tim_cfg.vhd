configuration TIMING_FOR_shift_register of shift_register_tb is
	for TB_ARCHITECTURE
		for UUT : shift_register
--
-- The user should replace : 
-- ENTITY_NAME with an	entity name from a backannotated VHDL file,
-- ARCH_NAME   with an architecture name from a backannotated VHDL file,
-- and uncomment the line below
--			use entity work.ENTITY_NAME (ARCH_NAME);
		end for;
	end for;
end TIMING_FOR_shift_register;

