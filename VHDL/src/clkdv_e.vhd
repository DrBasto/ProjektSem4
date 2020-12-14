
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY clock_divider IS
PORT(
cp_i : IN std_logic;
rb_i : IN std_logic;
br_s : OUT std_logic;
sec_o : OUT std_logic
);
END clock_divider;
