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

ENTITY control_fsm is
PORT(
  cp_i   : IN  std_logic;
  rb_i   : IN  std_logic;
  detect_s : IN std_logic;
  done_s : IN std_logic;
  start_s : OUT std_logic
  );
END control_fsm;