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
    USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY top is
PORT(
  cp_i   : IN  std_logic;   --- clock
  rb_i   : IN  std_logic;   --- reset
  cl_i   : IN  std_logic;   --- clear number of people
  s1_i   : IN  std_logic;   --- gates
  s2_i   : IN  std_logic;
  s3_i   : IN  std_logic;
  txd_o  : OUT std_logic;   --- uart output
  tled_o : OUT std_logic;   --- LED
  sec_o : OUT std_logic;    
  sdo_o  : OUT std_logic;
  sdv_o  : OUT std_logic;
  stx_o  : OUT std_logic;
  red_o  : OUT std_logic;
  grn_o  : OUT std_logic;
  sound_o  : OUT std_logic
  );
END top;