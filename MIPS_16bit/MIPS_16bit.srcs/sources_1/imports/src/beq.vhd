Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity beq is
port(	
		In1	: in	std_logic;
		In2 : in std_logic;
		Zi : in std_logic;
		Sout : out std_logic
);
End;

Architecture behavior of beq is

Begin
-- In1  In2  Zi  Sout
--  0    0    0    0
--  0    0    1    1
--  0    1    0    0
--  0    1    1    0
--  1    0    0    0
--  1    0    1    0
--  1    1    0    0
--  1    1    1    1
	
-- beq logic
	Sout <= (In1 xnor In2) and Zi;

End;