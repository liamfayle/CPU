Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity ALU is
port(	
		A : in std_logic;
		B : in std_logic;
		Cin	: in std_logic;
		S : in std_logic_vector (1 downto 0);
		ALU_OUT	: out std_logic;
		Cout : out std_logic;
		Zero : out std_logic;
		Zi : in std_logic
);
End ALU;

Architecture behavior of ALU is
	COMPONENT full_adder
	PORT(	
		A : in	std_logic;
		B : in std_logic;
		Cin	: in std_logic;
		Sout : out std_logic;
		Cout : out std_logic
	);
	END COMPONENT;
	
	COMPONENT Control
	PORT(	
		op			:	in	std_logic_vector( 3 downto 0);
		alu_op		:	out	std_logic_vector( 1 downto 0);
		alu_src		:	out	std_logic;
		reg_dest	:	out	std_logic;
		reg_load	:	out	std_logic;
		reg_src		:	out	std_logic_vector(1 downto 0);
		mem_read	:	out	std_logic;
		mem_write	:	out	std_logic
	);
	END COMPONENT;

	COMPONENT MUX31
	PORT(	
		Input1 : in	std_logic;
		Input2 : in	std_logic;
		Input3 : in	std_logic;
		S : in std_logic_vector (1 downto 0);
		Sout : out std_logic
	);
	END COMPONENT;

	COMPONENT and_gate
	PORT(	
		In1	: in std_logic;
		In2	: in std_logic;
		Sout : out std_logic
	);
	END COMPONENT;

	COMPONENT or_gate
	PORT(	
		In1	: in std_logic;
		In2	: in std_logic;
		Sout : out std_logic
	);
	END COMPONENT;
	
	COMPONENT xor_gate
	PORT(	
		In1	: in std_logic;
		In2	: in std_logic;
		Sout : out std_logic
	);
	END COMPONENT;
	
	COMPONENT slt
	PORT(	
		In1	: in std_logic;
		In2	: in std_logic;
		Sout : out std_logic
	);
	END COMPONENT;
	
	COMPONENT beq
	PORT(	
		In1	: in std_logic;
		In2	: in std_logic;
		Zi : in std_logic;
		Sout : out std_logic
	);
	END COMPONENT;
	
--Signals Definition
    signal BxS : std_logic := '0';
    
--Inner Signals
    signal Sag : std_logic := '0';
    signal Sog : std_logic := '0';
    signal Sua : std_logic := '0';
    signal Sxg : std_logic := '0';
    signal Ssa : std_logic := '0';
    signal Sss : std_logic := '0';
    signal Ssl : std_logic := '0';
    signal Sbe : std_logic := '0';
    
Begin
	-- signal assignments
	BxS <= (B xor S(0));
	
	-- port maps
	C1 : full_adder port map(
	    A => A,
		B => Bxs,
		Cin => Cin,
		Sout => Ssa,
		Cout => Cout
	);
	
	C2 : and_gate port map(
		In1	=> A,
		In2	=> B,
		Sout => Sag
	);
	
	C3 : or_gate port map(
		In1	=> A,
		In2	=> B,
		Sout => Sog 
	);
	
	C4 : full_adder port map(
		A => A,
		B => Bxs,
		Cin => Cin,
		Sout => Sua,
		Cout => Cout
	);
	
	C5 : xor_gate port map(
	    In1 => A,
	    In2 => B,
	    Sout => Sxg
	);
	
	
	C6 : full_adder port map(
	    A => A,
		B => Bxs,
		Cin => Cin,
		Sout => Sss,
		Cout => Cout
	);
	
	C7 : slt port map(
	    In1 => A,
	    In2 => B,
	    Sout => Ssl
	);
	
	C8 : beq port map(
	    In1 => A,
	    In2 => B,
	    Zi => Zi,
	    Sout => Zero
	);
	
	C9 : MUX31 port map(
	    Input1 => Ssa, --Signed add
		Input2 => Sag, --AND gate
		Input3 => Sog, --OR gate
		--Input4 => Sua, --Unsigned add
		--Input5 => Sxg, --XOR gate
		--Input6 => Sss, --Signed subtract
		--Input7 => Ssl, --Set if less than
		--Input8 => Sbe, --Branch if equal
				
		S => S,
		Sout => ALU_OUT
	);
	
End;
	