LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY cu1 IS
PORT(
  cp_i : IN std_logic;
  rb_i : IN std_logic;
  cl_i : IN std_logic;
  cup_i : IN std_logic;
  cdown_i : IN std_logic;
  headcount_o : OUT std_logic_vector(5 DOWNTO 0);
  maxr_s : OUT std_logic
  );
END cu1;