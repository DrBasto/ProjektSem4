-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY debnc IS
GENERIC (
  debounce_width : integer
  );
PORT (
  cp_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  rb_i : IN  std_logic;                      -- Reset, active low
  unb_i   : IN  std_logic;
  deb_o   : OUT std_logic
  );
END debnc;

-- ----------------------------------------------------------------------------