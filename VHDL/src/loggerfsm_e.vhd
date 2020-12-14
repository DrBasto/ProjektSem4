
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
    --USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY logger_fsm is
PORT(
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
    s1_i   : IN  std_logic;
    s2_i   : IN  std_logic;
    s3_i   : IN  std_logic;
    done_s : IN std_logic;
    finish_s : IN std_logic;
    cup_s  : OUT std_logic;
    cdown_s: OUT std_logic;
    enter_s: OUT std_logic;
    exit_s : OUT std_logic
  );
END logger_fsm;