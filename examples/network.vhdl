-- Import libraries for use in the code
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY network IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        value_in_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        value_in_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

        value_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

        done : OUT STD_LOGIC
    );
END ENTITY network;

ARCHITECTURE structural OF network IS
    -- Amount of layers, each layer has a predefined amount of neurons
    COMPONENT layer IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            value_in_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            value_in_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

            value_out_1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT layer;

    COMPONENT cortex IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            value_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

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

        value_out => value_out_1
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