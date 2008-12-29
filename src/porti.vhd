ENTITY poarta_xor IS
	GENERIC(del: TIME:=3ns);
	PORT(x1,x2: IN BIT;
		y: OUT BIT);
END poarta_xor;

ARCHITECTURE behave OF poarta_xor IS
-- declaratii de semnale, etc, 
-- NU se potdeclara variabile in arhitectura

BEGIN
y <= x1 XOR x2 AFTER del;
END behave;

ENTITY inversor IS
	GENERIC(del: TIME:=4ns);
	PORT(x: IN BIT;
		y: OUT BIT);
END inversor;

ARCHITECTURE behave OF inversor IS
-- declaratii
BEGIN
y <= NOT x AFTER del;
END behave;