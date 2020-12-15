
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
    --USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY transmit_fsm is
PORT(
  cp_i   : IN  std_logic;
  rb_i   : IN  std_logic;
  br_s : IN std_logic;
  start_s : IN std_logic;
  event_s : IN std_logic_vector(1 DOWNTO 0);
  headcount_s : IN std_logic_vector(5 DOWNTO 0);
  txd_s : OUT std_logic;
  tled_s : OUT std_logic;
  done_s : OUT std_logic
  );
END transmit_fsm;