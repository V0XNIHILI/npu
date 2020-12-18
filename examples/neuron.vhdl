-- Import Libraries
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- Entity declaration of controller
ENTITY neuron IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        value_in_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        value_in_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

        error_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

        value_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END ENTITY neuron;

ARCHITECTURE behavioral OF neuron IS
    SIGNAL weight_1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL weight_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);

    SIGNAL learning_rate : STD_LOGIC_VECTOR (3 DOWNTO 0);

    SIGNAL bias : STD_LOGIC_VECTOR (3 DOWNTO 0);

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
        value_out <= value_in_1 * weight_1 + value_in_2 * weight_2 + bias;
    END PROCESS;

END behavioral;