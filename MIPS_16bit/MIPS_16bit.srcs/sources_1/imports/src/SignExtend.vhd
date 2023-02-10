library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity SignExtend is
	port(
		immIn		:	in	std_logic_vector( 3 downto 0);
		immOut		:	out	std_logic_vector(15 downto 0)
		);
End SignExtend;

architecture syn of SignExtend is

begin

	-- TODO 1: Implement the immOut(5) - immOut(15) (HINT: Look at the signal immOut(3))

    immOut(15)	<=	'0';
    immOut(14)	<=	'0';
    immOut(13)	<=	'0';
    immOut(12)	<=	'0';
    immOut(11)	<=	'0';
    immOut(10)	<=	'0';
    immOut(9)	<=	'0';
    immOut(8)	<=	'0';
    immOut(7)	<=	'0';
    immOut(6)	<=	'0';
    immOut(5)	<=	'0';
    immOut(4)	<=	'0';
	immOut(3)	<=	immIn(3);
	immOut(2)	<=	immIn(2);
	immOut(1)	<=	immIn(1);
	immOut(0)	<=	immIn(0);

end syn;