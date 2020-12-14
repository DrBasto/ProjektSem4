
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
    --USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY sender_fsm is
PORT(
  cp_i   : IN  std_logic;
  rb_i   : IN  std_logic;
  br_s : IN std_logic;
  send_s  : IN std_logic;
  event_s : IN std_logic_vector(1 DOWNTO 0);
  headcount_s : IN std_logic_vector(5 DOWNTO 0);
  sdo_o  : OUT std_logic;
  sdv_o  : OUT std_logic;
  stx_o  : OUT std_logic;
  finish_s : OUT std_logic
  );
END sender_fsm;