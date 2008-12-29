													   ----------------
--
--fisier arhitectura 
--contine  arhitectura "comport_secvential" a entiatatii "circ_paritate"
--
----------------

ARCHITECTURE comport_secvential OF circ_paritate IS
BEGIN

	PROCESS(v) 
		-- semnalul v constituie LISTA DE SENZITIVITATE a procesului
		--parteade declaratii a procesului:
		-- se pot declara constante si variabile, 
		-- NU se pot declara semnale !

		variable nr_de_1 : INTEGER:=0;
	BEGIN
		nr_de_1:=0;
		FOR i IN 0 TO 3 LOOP
			IF v(i)='1' THEN
				nr_de_1 := nr_de_1 +1; -- nu exista operatori ++, +=, etc :)
			END IF;	
		END LOOP;

		IF nr_de_1 MOD 2=0 THEN
			y<= '1' AFTER 1 ns;
		ELSE
			y<='0' AFTER 1 ns;
		END IF;

		END PROCESS;
END;

		