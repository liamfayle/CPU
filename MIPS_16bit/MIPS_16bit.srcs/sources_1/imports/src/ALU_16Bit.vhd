Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity ALU_16Bit is
    generic (Dwidth : integer := 16);
    port(	
		IN1, IN2 : in std_logic_vector (Dwidth - 1 downto 0);
		ALU_OUT : out std_logic_vector (Dwidth - 1 downto 0);
		SEL	: in std_logic_vector (1 downto 0);
		Cin	: in std_logic;
		Zero, OVF :	out	std_logic
);
End ALU_16Bit;

Architecture behavior of ALU_16Bit is
	COMPONENT ALU
	port(	
		A : in std_logic;
		B :	in std_logic;
		Cin	: in std_logic;
		S :	in std_logic_vector (1 downto 0);
		ALU_OUT : out std_logic;
		Cout : out std_logic;
		Zero : out std_logic;
		Zi : in std_logic
	);
	END COMPONENT;
	
	signal Carry : std_logic_vector (14 downto 0);
	signal sZ : std_logic_vector (14 downto 0);

Begin
		
	alu00 :	ALU	port map(
        A => IN1(0),
        B => IN2(0),
        Cin => SEL(0),
        S => SEL,
        ALU_OUT => ALU_OUT(0),
        Cout => Carry(0),
        Zero => sZ(0),
        Zi => '1'
	);
	alu01 :	ALU	port map(
        A => IN1(1),
        B => IN2(1),
        Cin => Carry(0),
        S => SEL,
        ALU_OUT => ALU_OUT(1),
        Cout => Carry(1),
        Zero => sZ(1),
        Zi => sZ(0)
	);
	alu02 :	ALU	port map(
	    A => IN1(2),
        B => IN2(2),
        Cin => Carry(1),
        S => SEL,
        ALU_OUT => ALU_OUT(2),
        Cout => Carry(2),
        Zero => sZ(2),
        Zi => sZ(1)
    );
	alu03 :	ALU	port map(
	    A => IN1(3),
        B => IN2(3),
        Cin => Carry(2),
        S => SEL,
        ALU_OUT => ALU_OUT(3),
        Cout => Carry(3),
        Zero => sZ(3),
        Zi => sZ(2)
	);
	
	alu04 :	ALU	port map(
	    A => IN1(4),
        B => IN2(4),
        Cin => Carry(3),
        S => SEL,
        ALU_OUT => ALU_OUT(4),
        Cout => Carry(4),
        Zero => sZ(4),
        Zi => sZ(3)
	);
	alu05 :	ALU	port map(
	    A => IN1(5),
        B => IN2(5),
        Cin => Carry(4),
        S => SEL,
        ALU_OUT => ALU_OUT(5),
        Cout => Carry(5),
        Zero => sZ(5),
        Zi => sZ(4)
	);
	alu06 :	ALU	port map(
	    A => IN1(6),
        B => IN2(6),
        Cin => Carry(5),
        S => SEL,
        ALU_OUT => ALU_OUT(6),
        Cout => Carry(6),
        Zero => sZ(6),
        Zi => sZ(5)
	);
	alu07 :	ALU	port map(
	    A => IN1(7),
        B => IN2(7),
        Cin => Carry(6),
        S => SEL,
        ALU_OUT => ALU_OUT(7),
        Cout => Carry(7),
        Zero => sZ(7),
        Zi => sZ(6)
	);
	
	--16 bit extension
	alu08 :	ALU	port map(
        A => IN1(8),
        B => IN2(8),
        Cin => Carry(7),
        S => SEL,
        ALU_OUT => ALU_OUT(8),
        Cout => Carry(8),
        Zero => sZ(8),
        Zi => sZ(7)
	);
	alu09 :	ALU	port map(
        A => IN1(9),
        B => IN2(9),
        Cin => Carry(8),
        S => SEL,
        ALU_OUT => ALU_OUT(9),
        Cout => Carry(9),
        Zero => sZ(9),
        Zi => sZ(8)
	);
	alu10 :	ALU	port map(
	    A => IN1(10),
        B => IN2(10),
        Cin => Carry(9),
        S => SEL,
        ALU_OUT => ALU_OUT(10),
        Cout => Carry(10),
        Zero => sZ(10),
        Zi => sZ(9)
    );
	alu11 :	ALU	port map(
	    A => IN1(11),
        B => IN2(11),
        Cin => Carry(10),
        S => SEL,
        ALU_OUT => ALU_OUT(11),
        Cout => Carry(11),
        Zero => sZ(11),
        Zi => sZ(10)
	);
	
	alu12 :	ALU	port map(
	    A => IN1(12),
        B => IN2(12),
        Cin => Carry(11),
        S => SEL,
        ALU_OUT => ALU_OUT(12),
        Cout => Carry(12),
        Zero => sZ(12),
        Zi => sZ(11)
	);
	alu13 :	ALU	port map(
	    A => IN1(13),
        B => IN2(13),
        Cin => Carry(12),
        S => SEL,
        ALU_OUT => ALU_OUT(13),
        Cout => Carry(13),
        Zero => sZ(13),
        Zi => sZ(12)
	);
	alu14 :	ALU	port map(
	    A => IN1(14),
        B => IN2(14),
        Cin => Carry(13),
        S => SEL,
        ALU_OUT => ALU_OUT(14),
        Cout => Carry(14),
        Zero => sZ(14),
        Zi => sZ(13)
	);
	alu15 :	ALU	port map(
	    A => IN1(15),
        B => IN2(15),
        Cin => Carry(14),
        S => SEL,
        ALU_OUT => ALU_OUT(15),
        Cout => OVF,
        Zero => Zero,
        Zi => sZ(14)
	);
	
End;