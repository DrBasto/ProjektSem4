
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY uat is
PORT(
rb_i : IN std_logic;
cp_i : IN std_logic;
nm_i : IN std_logic;
eh_i : IN std_logic;
hc_i : IN std_logic;
txd_o : OUT std_logic
);
END uat;

