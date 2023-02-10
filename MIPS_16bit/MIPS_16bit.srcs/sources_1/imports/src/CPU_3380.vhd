LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CPU IS
	PORT(
		clk			: IN STD_LOGIC;
		clear 		: IN STD_LOGIC;
		instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
 	);
END CPU;

architecture Behavioral OF CPU IS
	COMPONENT ALU_16Bit
		PORT(
			IN1			:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
			IN2			:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
			SEL			:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALU_OUT	:	OUT 	STD_LOGIC_VECTOR(15 DOWNTO 0);
			Zero, OVF	:	OUT		STD_LOGIC;
			Cin	: in std_logic
		);
	END COMPONENT;

	COMPONENT RegisterFile
		PORT(
			clk			:	IN	 STD_LOGIC;													-- positive edge triggered clock
			clear		:	IN   STD_LOGIC;													-- asynchronous reset

			a_addr	:	IN	 STD_LOGIC_VECTOR( 3 DOWNTO 0);			-- register select for input a
			a_data	:	IN	 STD_LOGIC_VECTOR(15 DOWNTO 0);			-- input data port
			load		:	IN	 STD_LOGIC;													-- load enable/enable signal for "loading"

			b_addr	:	IN	 STD_LOGIC_VECTOR( 3 DOWNTO 0); 		-- register select for output b
			c_addr	:	IN	 STD_LOGIC_VECTOR( 3 DOWNTO 0); 		-- register select for output c

			b_data	:	OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);			-- first output data port
			c_data	:	OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)				-- second output data port
		);
	End COMPONENT;
	
	COMPONENT Control
		port(
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
	
	COMPONENT SignExtend
        port(
            immIn		:	in	std_logic_vector( 3 downto 0);
            immOut		:	out	std_logic_vector(15 downto 0)
		);
    END COMPONENT;
    
    component mux3_1
    generic (WIDTH : positive:=16);
	port(
		Input1		:	in		std_logic_vector(WIDTH-1 	downto 0);
		Input2		:	in		std_logic_vector(WIDTH-1 	downto 0);
		Input3		:	in		std_logic_vector(WIDTH-1 	downto 0);
		S				:	in		std_logic_vector(1 			downto 0);
		Sout			:	out	std_logic_vector(WIDTH-1 	downto 0));
	end component;

	component mux2_1
    generic (WIDTH : positive:=16);
	port(
		Input1		:	in std_logic_vector(WIDTH-1 downto 0);
		Input2		:	in std_logic_vector(WIDTH-1 downto 0);
		S			:	in std_logic;
		Sout		:	out	std_logic_vector(WIDTH-1 downto 0));
	end component;

	-- Signals
	SIGNAL cout	    : STD_LOGIC;
	SIGNAL op 	    : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rs	    : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rt		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rd		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Sout_ALU	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL rs_data	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL rt_data	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	signal	alu_src_mux_out	    : std_logic_vector(15 downto 0);
	signal 	sign_ex_out			: std_logic_vector(15 downto 0);
	signal	reg_dest_mux_out	: std_logic_vector( 3 downto 0);
	signal	reg_src_mux_out	    : std_logic_vector(15 downto 0);
	
	signal	ctrl_alu_src		: std_logic;
	signal	ctrl_alu_op			: std_logic_vector( 1 downto 0);
	signal	ctrl_reg_dest		: std_logic;
	signal	ctrl_reg_src		: std_logic_vector( 1 downto 0);
	signal	ctrl_reg_load		: std_logic;
	signal	ctrl_mem_read		: std_logic;
	signal	ctrl_mem_write		: std_logic;

BEGIN
	--------------------------------------------------------------------------
	-- Instruction Fetch
	--------------------------------------------------------------------------
	-- TODO: Map the following to their corresponding instruction bits: op, rd, rs, rt
    op <= instruction(15 downto 12);
    rd <= instruction(11 downto 8);
    rs <= instruction(7 downto 4);
    rt <= instruction(3 downto 0);

	--------------------------------------------------------------------------
	-- Instruction Decode
	--------------------------------------------------------------------------
	CTRL: Control port map(
        op          => op,
        alu_op		=> ctrl_alu_op,
		alu_src		=> ctrl_alu_src,
        reg_dest	=> ctrl_reg_dest,
        reg_load	=> ctrl_reg_load,
        reg_src     => ctrl_reg_src,
        mem_read    => ctrl_mem_read,
        mem_write   => ctrl_mem_write
    );
	
	CPU_Registers_0:	RegisterFile port map(
	-- TODO: Map the following register file signals to their corresponding ALU signals: clk, clear, rd, Sout_ALU,, rs, rt, rs_data, rt_data, '1'
        clk => clk,
        clear => clear,
        a_addr => rd,
        a_data => Sout_ALU,
        b_addr => rs,
        c_addr => rt,
        b_data => rs_data,
        c_data => rt_data,
        load => '1'
	);
	
	Sign_Ex: SignExtend port map (
        immIn   => rt,
        immOut  => sign_ex_out
    );
    
    CPU_reg_dest_mux: mux2_1 generic map(4) port map(
	   Input1	=>		rt,
	   Input2	=>		rd,
	   S		=>		ctrl_reg_dest,
	   Sout		=>		reg_dest_mux_out
    );
	--------------------------------------------------------------------------
	-- Execute
	--------------------------------------------------------------------------
	CPU_alu_src_mux: mux2_1 generic map(16) port map(
	   Input1	=> rt_data,
	   Input2	=> sign_ex_out,
	   S		=> ctrl_alu_src,
	   Sout		=> alu_src_mux_out
	);
	
	CPU_ALU_0:	ALU_16Bit port map(
	-- TODO: Map the following signals to the ALUs signals: rs_data, rt_data, op, Sout_ALU, cout
        IN1 => rs_data,
        IN2 => alu_src_mux_out,
        SEL => ctrl_alu_op,
        ALU_OUT => Sout_ALU,
        OVF => cout,
        Cin => '0'
	);

END Behavioral;
