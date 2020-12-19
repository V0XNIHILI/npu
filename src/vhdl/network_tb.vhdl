-- Import libraries for use in the code
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.float_pkg.ALL;

ENTITY network_tb IS
    SUBTYPE FLOAT32 IS float (8 DOWNTO -23);
END network_tb;

ARCHITECTURE mixed OF network_tb IS

    -- Clock & reset signals
    SIGNAL CLK_100MHZ : STD_LOGIC;
    SIGNAL RESET : STD_LOGIC;

    SIGNAL VALUE_IN_1 : FLOAT32;
    SIGNAL VALUE_IN_2 : FLOAT32;

    SIGNAL VALUE_OUT : FLOAT32;

    SIGNAL DONE : STD_LOGIC;

    COMPONENT network IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            value_in_1 : IN FLOAT32;
            value_in_2 : IN FLOAT32;

            value_out : OUT FLOAT32;

            done : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    -- CLK signal
    CLK_100MHZ <= '1' AFTER 5 ns WHEN CLK_100MHZ /= '1' ELSE
        '0' AFTER 5 ns;

    RESET <= '0' AFTER 0 ns, '1' AFTER 100 ns, '0' AFTER 80 ms, '1' AFTER 100 ms;

    VALUE_IN_1 <= "0.15" AFTER 0 ns, "0.2" AFTER 5 ns;
    VALUE_IN_2 <= "0.4" AFTER 0 ns, "-0.7" AFTER 15 ns;

    lbl1 : network PORT MAP(clk => CLK_100MHZ, reset => RESET, value_in_1 => VALUE_IN_1, value_in_2 => VALUE_IN_2, value_out => VALUE_OUT, done => DONE);

END mixed;