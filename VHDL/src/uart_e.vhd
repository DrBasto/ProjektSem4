
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY uat is
PORT(
rb_i : IN std_logic;
cp_i : IN std_logic;
br_i : IN std_logic;
event_s : IN std_logic_vector(1 DOWNTO 0);
headcount_s :  IN std_logic_vector(5 DOWNTO 0);
detect_s : IN std_logic;
txd_o : OUT std_logic;
tled_o : OUT std_logic
);
END uat;

