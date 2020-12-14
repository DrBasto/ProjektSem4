
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
    --USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY operator_fsm is
PORT(
  cp_i   : IN  std_logic;
  rb_i   : IN  std_logic;
  detect_s : IN std_logic;
  finish_s : IN std_logic;
  send_s : OUT std_logic
  );
END operator_fsm;