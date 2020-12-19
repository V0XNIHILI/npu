-- Import Libraries
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.float_pkg.ALL;

-- Entity declaration of controller
ENTITY neuron IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        value_in_1 : IN FLOAT32;
        value_in_2 : IN FLOAT32;

        error_in : IN FLOAT32;

        value_out : OUT FLOAT32
    );

    SUBTYPE FLOAT32 IS float (8 DOWNTO -23);

END ENTITY neuron;

ARCHITECTURE behavioral OF neuron IS
    CONSTANT weight1 : FLOAT32 := 3.07;
    CONSTANT weight2 : FLOAT32 := - 1.02;
    CONSTANT biass : FLOAT32 := 0.5;

    SIGNAL weight_1 : FLOAT32;
    SIGNAL weight_2 : FLOAT32;

    SIGNAL learning_rate : FLOAT32;

    SIGNAL bias : FLOAT32;

BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF (rising_edge (clk)) THEN
            IF (reset = '1') THEN
                weight_1 <= (OTHERS => '0');
                weight_2 <= (OTHERS => '0');

                value_out <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;

    -- Need to make sure that this only runs once and that 
    PROCESS (error_in)
    BEGIN
        weight_1 <= weight_1 - error_in * learning_rate * value_in_1;
        weight_2 <= weight_1 - error_in * learning_rate * value_in_1;

        bias <= bias - error_in * learning_rate;
    END PROCESS;

    PROCESS (value_in_1, value_in_2)
    BEGIN
        value_out <= value_in_1 * weight1 + value_in_2 * weight2 + biass;
    END PROCESS;

END behavioral;