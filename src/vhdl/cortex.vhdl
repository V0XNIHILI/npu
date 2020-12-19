-- Import libraries for use in the code
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.float_pkg.ALL;

-- The cortex is the mananger of the whole neural network. It checks if the 
ENTITY cortex IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        -- Amount of neurons in previous layer
        value_in : IN FLOAT32;

        -- Amount of neurons in next layer
        done : OUT STD_LOGIC
    );

    SUBTYPE FLOAT32 IS float (8 DOWNTO -23);
END ENTITY cortex;

ARCHITECTURE behavioral OF cortex IS
    SIGNAL previous_value : FLOAT32;

BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF (rising_edge (clk)) THEN
            IF (reset = '1') THEN
                done <= '0';
            ELSE
                IF (value_in = previous_value) THEN
                    done <= '1';
                ELSE
                    done <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;