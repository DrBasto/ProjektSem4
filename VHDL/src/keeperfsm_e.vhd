LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
    --USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY keeper_fsm is
PORT(
    enter_s : IN std_logic;
    exit_s : IN std_logic;
    maxr_s : IN std_logic;
    detect_s : OUT std_logic;
    event_s : OUT std_logic;
    red_o : OUT std_logic;
    grn_o : OUT std_logic;
    sound_o : OUT std_logic
  );
END keeper_fsm;