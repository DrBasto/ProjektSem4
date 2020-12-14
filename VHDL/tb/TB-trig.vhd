-- ----------------------------------------------------------------------------

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB1_trig IS END TB1_trig;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB1_trig IS

  -- input
  SIGNAL rb_s,cp_s,s1_s,s2_s,s3_s : std_logic;
  -- output
  SIGNAL enter_s,leave_s : std_logic;

BEGIN
  
  uux : trigger PORT MAP (rb_s,cp_s,s1_s,s2_s,s3_s,enter_s,leave_s);
  
  runTB : PROCESS
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rb_s  <= '1';
    cp_s  <= '0';
    s1_s  <= '0';
    s2_s  <= '0';
    s3_s  <= '0'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 2: Do a reset-cycle
-- ----------------------------------------------------------------------------
    rb_s  <= '0'; WAIT FOR 100 NS;
    rb_s  <= '1'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 3: Run Test-Patterns
-- ----------------------------------------------------------------------------
-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Send Enter Code
    cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Send Leave Code
    cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- ---------------------------------------------------------------------------- 	  
    cp_s  <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------
    WAIT;
  END PROCESS runTB;
END ar1;