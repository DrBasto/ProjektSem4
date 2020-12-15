
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY interface is
PORT(
  cp_i   : IN  std_logic;
  rb_i   : IN  std_logic;
  br_s   : IN std_logic;
  event_s : IN std_logic_vector(1 DOWNTO 0);
  headcount_s : IN std_logic_vector(5 DOWNTO 0);
  detect_s : IN std_logic; 
  sdo_o  : OUT std_logic;
  sdv_o  : OUT std_logic;
  stx_o  : OUT std_logic;
  finish_o : OUT std_logic
  );
END interface;