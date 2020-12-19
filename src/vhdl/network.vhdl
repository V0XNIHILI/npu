-- Import libraries for use in the code
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.float_pkg.ALL;

ENTITY network IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        value_in_1 : IN FLOAT32;
        value_in_2 : IN FLOAT32;

        value_out : OUT FLOAT32;

        done : OUT STD_LOGIC
    );

    SUBTYPE FLOAT32 IS float (8 DOWNTO -23);

END ENTITY network;

ARCHITECTURE structural OF network IS
    -- Amount of layers, each layer has a predefined amount of neurons
    COMPONENT layer IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            value_in_1 : IN FLOAT32;
            value_in_2 : IN FLOAT32;

            value_out_1 : OUT FLOAT32
        );
    END COMPONENT layer;

    COMPONENT cortex IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            value_in : IN FLOAT32;

            done : OUT STD_LOGIC
        );
    END COMPONENT cortex;

BEGIN
    -- Amount of layers, each layer has a predefined amount of neurons
    layer_1 : layer PORT MAP(
        clk => clk,
        reset => reset,

        value_in_1 => value_in_1,
        value_in_2 => value_in_2,

        value_out_1 => value_out
    );

    -- Only one cortex is needed per network
    network_cortex : cortex PORT MAP(
        clk => clk,
        reset => reset,

        value_in => value_out,
        done => done
    );

    -- Need to add check to make sure that output doesnt change anymore

END ARCHITECTURE structural;