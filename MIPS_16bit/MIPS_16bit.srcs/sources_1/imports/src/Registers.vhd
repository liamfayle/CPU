LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RegisterFile IS
	PORT(
		clk			:	IN	STD_LOGIC;												-- positive edge triggered clock
		clear		:	IN  STD_LOGIC;												-- asynchronous, active low reset

		a_addr	:	IN	 STD_LOGIC_VECTOR(3 DOWNTO 0);		-- register select for input a
		a_data	:	IN	 STD_LOGIC_VECTOR(15 DOWNTO 0);		-- input data port
		load		:	IN	 STD_LOGIC;												-- load enable/enable signal for "loading"

		b_addr	:	IN	 STD_LOGIC_VECTOR(3 DOWNTO 0); 		-- register select for output b
		c_addr	:	IN	 STD_LOGIC_VECTOR(3 DOWNTO 0); 		-- register select for output c

		b_data	:	OUT STD_LOGIC_VECTOR(15 DOWNTO 0);		-- first output data port
		c_data	:	OUT STD_LOGIC_VECTOR(15 DOWNTO 0)			-- second output data port
	);
END RegisterFile;

ARCHITECTURE syn OF RegisterFile IS

-- Define Register File array here
TYPE ram_type IS ARRAY (15 DOWNTO 0) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL REG_FILE : ram_type;

BEGIN
	-- TODO: Populate the process block with the 3 requires arguments (HINT: They are all 1-bit)
	PROCESS(clk, clear, load)
	BEGIN
	  -- TODO: Define the Active Low clear signal here
		IF(clear = '0') THEN
		-- Clear (and reset) registers
		-- The first 4 Clear's for the registers are defined for you
		-- TODO: 7.	When the clear signal is 0, all registers (other than register 1) are reset to 0.
			REG_FILE(0)		<= x"0000";
			--REG_FILE(1)		<= x"0000";
			REG_FILE(2)		<= x"0000";
			REG_FILE(3)		<= x"0000";
			REG_FILE(4)		<= x"0000";
			REG_FILE(5)		<= x"0000";
			REG_FILE(6)		<= x"0000";
			REG_FILE(7)		<= x"0000";
			REG_FILE(8)		<= x"0000";
			REG_FILE(9)		<= x"0000";
			REG_FILE(10)	<= x"0000";
			REG_FILE(11)	<= x"0000";
			REG_FILE(12)	<= x"0000";
			REG_FILE(13)	<= x"0000";
			REG_FILE(14)	<= x"0000";
			REG_FILE(15)	<= x"0000";

		ELSIF(clk'EVENT AND clk='1') THEN

		  -- TODO: Define the Active High load signal here
			IF(load = '1') THEN
					-- Register Write using a_addr and a_data
					REG_FILE(conv_integer(a_addr)) <= a_data;
			END IF;
		END IF;

		-- TODO: Set R0 to '0' and R1 to '1' here
		REG_FILE(0)		<= x"0000";
		REG_FILE(1)		<= x"0001";

	END PROCESS;

	-- Register Read (B and C).
	b_data <= REG_FILE(conv_integer(b_addr));
	c_data <= REG_FILE(conv_integer(c_addr));
END syn;
