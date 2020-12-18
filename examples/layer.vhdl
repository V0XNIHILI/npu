-- Import libraries for use in the code
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.float_pkg.ALL;

SUBTYPE float32 IS float (8 DOWNTO –23);

ENTITY layer IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        -- Amount of neurons in previous layer
        value_in_1 : IN float32
        value_in_2 : IN float32

        -- Amount of neurons in next layer
        value_out_1 : OUT float32
    );
END ENTITY layer;

ARCHITECTURE structural OF layer IS
    COMPONENT neuron IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            value_in_1 : IN float32
            value_in_2 : IN float32

            value_out : OUT float32

            error_in : IN float32
        );
    END COMPONENT neuron;

BEGIN
    -- Amount of neurons in current layer
    neuron_1 : neuron PORT MAP(
        clk => clk,
        reset => reset,

        value_in_1 => value_in_1,
        value_in_2 => value_in_2,

        error_in => (OTHERS => '0'),
        value_out => value_out_1
    );

END ARCHITECTURE structural;