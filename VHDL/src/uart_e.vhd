
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;
-- ----------------------------------------------------------------------------

ENTITY uat is
PORT(
cp_i : IN std_logic;
rb_i : IN std_logic;
detect_s : IN std_logic;
br_s : IN std_logic;
headcount_s :  IN std_logic_vector(5 DOWNTO 0);
event_s : IN std_logic_vector(1 DOWNTO 0);
txd_o : OUT std_logic;
tled_o : OUT std_logic;
done_o : OUT std_logic
);
END uat;

