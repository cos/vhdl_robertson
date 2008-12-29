ENTITY circ_paritate IS
	PORT(v: IN BIT_VECTOR(3 DOWNTO 0);
		y: OUT BIT);
END circ_paritate;

ARCHITECTURE struct OF circ_paritate IS
	COMPONENT xor_gate IS
		GENERIC(del: TIME:=3ns);
		PORT(x1,x2: IN BIT;
			y: OUT BIT);
	END COMPONENT;

	COMPONENT inv_gate IS 
		GENERIC(del: TIME:=4ns);
		PORT(x: IN BIT; y: OUT BIT);
	END COMPONENT;

	SIGNAL s1, s2, s3: BIT;

BEGIN
	xor1: xor_gate PORT MAP(y => s1, x2=> v(1), x1=> v(0));-- mapare dupa nume
	xor2: xor_gate PORT MAP(v(2), v(3), s2); --mapare pozitionala
	xor3: xor_gate GENERIC MAP(del => 4ns) PORT MAP(s1, s2, s3);
	inv1: inv_gate PORT MAP(x=>s3, y=>y);
END ARCHITECTURE struct;

CONFIGURATION cfg_circ_paritate OF circ_paritate IS
	FOR struct
		FOR ALL: xor_gate USE ENTITY WORK.poarta_xor(behave);
		END FOR;
		FOR inv1: inv_gate USE ENTITY WORK.inversor(behave);
		END FOR;
	END FOR;
END CONFIGURATION;
 
	
ARCHITECTURE comport_concurent1 OF circ_paritate IS
	SIGNAL t1, t2, t3: BIT;
BEGIN
	y<=NOT t3 AFTER 11ns; 
	t3<=t2 XOR t1;
	t2<=v(2) XOR v(3);
	t1<=v(0) XOR v(1);
END;

ARCHITECTURE comport_concurent2 OF circ_paritate IS

BEGIN
	y<= NOT(v(0) XOR v(1) XOR v(2) XOR v(3) ) AFTER 11ns;
END ARCHITECTURE;