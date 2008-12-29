----------------------------------
--
-- fisier test
-- contine un banc de test
-- pentru entitatea circ_paritate
--
----------------------------------

ENTITY test IS
END;

ARCHITECTURE test OF test IS
	COMPONENT  circ_paritate IS
		PORT(v: IN BIT_VECTOR(3 DOWNTO 0);
			y: OUT BIT);
	END COMPONENT;
	
	SIGNAL vector: BIT_VECTOR(3 DOWNTO 0);
	SIGNAL paritate_para: BIT;

BEGIN

et: circ_paritate PORT MAP(vector, paritate_para);

vector <=   "0000", "0001" AFTER 20ns, "0010" after 40ns,"0011" AFTER 60ns,
		"0100" after 80ns,"0101" after 100ns, "0110" after 120ns, "0111" after 140ns,
		"1000" after 160ns, "1001" after 180ns, "1010" after 200ns, "1011" after 220ns,
		"1100" after 240ns, "1101" after 260ns, "1110" after 280ns, "1111" after 300ns;
END;

CONFIGURATION cfg_test OF test IS
	FOR test
		FOR all: circ_paritate
			--USE ENTITY WORK.circ_paritate(comport_secvential);
			USE ENTITY WORK.circ_paritate(comport_concurent1);
			--USE ENTITY WORK.circ_paritate(comport_concurent2);
			--USE CONFIGURATION WORK.cfg_circ_paritate;		 
		END FOR;
	END FOR;
END CONFIGURATION;