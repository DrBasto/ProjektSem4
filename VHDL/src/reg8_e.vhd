-- ----------------------------------------------------------------------------
-- uat_fsm_e.vhd
-- ENTITIE for the UAT_FSM
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY reg8 IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN std_logic;
  d_i  : IN std_logic_vector(7 DOWNTO 0);
  q_o  : OUT std_logic_vector(7 DOWNTO 0)
  );
END reg8;
