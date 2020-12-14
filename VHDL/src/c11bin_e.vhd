-- ---------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- ---------------------------------------------------------------------------

ENTITY c11bin IS
PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
      cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
      en_i   :  IN STD_LOGIC;                     -- Enable Count
      cl_i   :  IN STD_LOGIC;                     -- Clear Counter
      co_o   : OUT STD_LOGIC;                     -- Carry Out
       q_o   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)   -- Counter Value
      );
END c11bin;

-- ----------------------------------------------------------------------------
