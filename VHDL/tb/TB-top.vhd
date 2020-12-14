-- ----------------------------------------------------------------------------

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.all;
  USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB1_top IS END TB1_top;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB1_top IS

  -- input
  SIGNAL rb_s,cp_s,s1_s,s2_s,s3_s,br_s : std_logic;
  -- internal
  SIGNAL entr_s,leav_s,min_s,max_s,inc_s,dec_s,dv_s : std_logic;
  SIGNAL evt_s,num_s : std_logic_vector(7 DOWNTO 0);
  -- output
  SIGNAL grn_s,red_s,txd_s,sdi_s,sdv_s,stx_s : std_logic;

BEGIN
  
  --rat : rate PORT MAP (rb_s,cp_i,br_s,hz_s); -- Boad Rate
  cou1 : count PORT MAP (rb_s, cp_s, inc_s, dec_s, min_s, max_s, num_s); -- HeadCount
  tri : trigger PORT MAP (rb_s, cp_s, s1_s, s2_s, s3_s, entr_s, leav_s); -- EventHandler
  con : control PORT MAP (rb_s, cp_s, entr_s, leav_s, min_s, max_s, inc_s, dec_s, evt_s, dv_s); -- UniqueTime
  uar1 : uat PORT MAP (rb_s, cp_s, br_s, dv_s, num_s, txd_s); -- UART
  int1 : interface PORT MAP (rb_s, cp_s, dv_s, evt_s, num_s, sdi_s, sdv_s, stx_s); -- 3WireInterface
  
  grn_s <= NOT max_s; -- green LED
  red_s <= max_s; -- red LED

  runTB : PROCESS
    VARIABLE dotimes  : integer :=   0;
    VARIABLE so_long  : integer := 20;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rb_s  <= '1';
    cp_s  <= '0';
    s1_s <= '0';
    s2_s <= '0';
    s3_s <= '0';
    br_s <= '0'; WAIT FOR 100 NS;
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
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;	
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Some baud_rate signals
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
      cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- The next rising slope of cp_i triggeres the increment
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
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;	
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Some baud_rate signals
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
      cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- Some SYScp-cycles:
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- The next rising slope of cp_i triggeres the increment
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
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;	
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- Some baud_rate signals
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
      cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
      cp_s  <= '1'; WAIT FOR 100 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- ---------------------------------------------------------------------------- 	  
    cp_s  <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------
    WAIT;
  END PROCESS runTB;
END ar1;