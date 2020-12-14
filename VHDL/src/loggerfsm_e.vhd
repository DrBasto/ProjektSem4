-- ----------------------------------------------------------------------------
-- top_e.vhd
-- ENTITIE for the TOP
-- 
-- Author:	Sebastian Romero ID:32303
-- 			Bahadir Ülkü
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------

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
    cup_s  : OUT std_logic;
    cdown_s: OUT std_logic;
    enter_s: OUT std_logic;
    exit_s : OUT std_logic
  );
END logger_fsm;