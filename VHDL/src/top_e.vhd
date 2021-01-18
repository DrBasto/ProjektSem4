-- ----------------------------------------------------------------------------
-- top_e.vhd
-- ENTITIE for the TOP
-- 
-- Author:	Sebastian Romero ID:32303
-- 			Bahadir Ülkü
-- Last edited: 19.01.2021
-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY top is
PORT(
  cp_i   : IN  std_logic;   --- system clock
  rb_i   : IN  std_logic;   --- reset button
  cl_i   : IN  std_logic;   --- clear number of people
  s1_i   : IN  std_logic;   --- light sensor 1
  s2_i   : IN  std_logic;   --- "     "      2 
  s3_i   : IN  std_logic;   --- "     "      3
  txd_o  : OUT std_logic;   --- uart output
  tled_o : OUT std_logic;   --- LED validation UART
  sec_o : OUT std_logic;    --- 1 hz output LED
  sdo_o  : OUT std_logic;   --- Serial data out
  sdv_o  : OUT std_logic;   --- Serial data valid
  stx_o  : OUT std_logic;   --- Serial data transfer active
  red_o  : OUT std_logic;   --- Red LED
  grn_o  : OUT std_logic;   --- Green LED
  rb_o : OUT std_logic;     --- reset LED
  sound_o  : OUT std_logic  --- sound signal
  );
END top;