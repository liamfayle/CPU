LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CPU_Test IS
END ENTITY CPU_Test;

ARCHITECTURE mixed OF CPU_Test IS
    CONSTANT  tick          : TIME := 100 ns;
    SIGNAL    reset, clock  : STD_LOGIC;
    SIGNAL    instruction   : STD_LOGIC_VECTOR(0 TO 15);

BEGIN
    CPU_Sim : ENTITY work.CPU
        port map(
            clk		      => clock,
            clear	      => reset,
            instruction => instruction
        );

    driver : PROCESS IS
    BEGIN
        -- reset the system
        reset <= '0'; instruction <= x"0000"; WAIT FOR 50 ns;
        reset <= '1';

        -- ADD r2, r1, r1
        instruction <= x"0211"; WAIT FOR tick; --value in r2 = 2
        
        --SUB r3, r2, r1
        instruction <= x"1321"; WAIT FOR tick; --value in r3 = 1
        
        --AND r4, r3, r1
        instruction <= x"2431"; WAIT FOR tick; --value in r4 = 1
        
        --OR r5, r3, r2
        instruction <= x"3532"; WAIT FOR tick; --value in r5 = 3
        
        --ADDI r6, r0, 15
        instruction <= x"460f"; WAIT FOR tick; --value in r6 = f (15)
        
        --SUBI r7, r6, 10
        instruction <= x"576a"; WAIT FOR tick; --value in r7 = 5
        
        --LW r8, offset?
        --instruction <= x"8800"; WAIT FOR tick; --value in r8 = ?
        
        --SW r9, offset?
        --instruction <= x"c900"; WAIT FOR tick; --value in r9 = ?
        
        --SLT r8, r7, r6
        --instruction <= x"7a76"; WAIT FOR tick; --value in r8 = 1

        
        WAIT;
    END PROCESS driver;

    clock_p : PROCESS IS
    BEGIN
        FOR i IN 0 TO 19 LOOP
            clock <= '1'; WAIT FOR  tick/2;
            clock <= '0'; WAIT FOR  tick/2;
        END LOOP;
        WAIT;
    END PROCESS clock_p;
END ARCHITECTURE mixed;
