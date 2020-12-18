-- Import libraries for use in the code
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.float_pkg.ALL;

ENTITY layer IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        -- Amount of neurons in previous layer
        value_in_1 : IN FLOAT32;
        value_in_2 : IN FLOAT32;

        -- Amount of neurons in next layer
        value_out_1 : OUT FLOAT32
    );

    SUBTYPE FLOAT32 IS float (8 DOWNTO -23);

END ENTITY layer;

ARCHITECTURE structural OF layer IS
    COMPONENT neuron IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            value_in_1 : IN FLOAT32;
            value_in_2 : IN FLOAT32;

            value_out : OUT FLOAT32;

            error_in : IN FLOAT32
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