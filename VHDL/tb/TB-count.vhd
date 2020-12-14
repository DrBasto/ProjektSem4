-- ----------------------------------------------------------------------------

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.all;
  USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB1_count IS END TB1_count;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB1_count IS

  -- input
  SIGNAL rb_s,cp_s,inc_s,dec_s : std_logic;
  -- output
  SIGNAL min_s,max_s : std_logic;
  SIGNAL num_s : std_logic_vector(7 DOWNTO 0);

BEGIN
  
  uux : count PORT MAP (rb_s,cp_s,inc_s,dec_s,min_s,max_s,num_s);
  
  runTB : PROCESS
    VARIABLE dotimes  : integer :=   0;
    VARIABLE so_long  : integer := 1000; -- 12000000;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rb_s  <= '1';
    cp_s  <= '0';
    inc_s <= '0';
    dec_s <= '0'; WAIT FOR 100 NS;
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
-- The next rising slope of cp_i triggeres the increment
    cp_s  <= '1'; WAIT FOR  10 NS; inc_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; inc_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;	
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- The next rising slope of cp_i triggeres the decrement
    cp_s  <= '1'; WAIT FOR  10 NS; dec_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; dec_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;	
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;

-- ---------------------------------------------------------------------------- 	  
    cp_s  <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------
    WAIT;
  END PROCESS runTB;
END ar1;