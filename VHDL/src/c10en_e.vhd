-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY c10en IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  enable_i : IN STD_LOGIC;
  cout_o : OUT std_logic
  );
END c10en;
