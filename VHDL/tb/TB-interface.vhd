-- ----------------------------------------------------------------------------

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB1_interface IS END TB1_interface;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB1_interface IS

  -- input
  SIGNAL rb_s,cp_s,dv_s : std_logic;
  SIGNAL evt_s,num_s : std_logic_vector(7 DOWNTO 0);
  -- output
  SIGNAL sdi_s,sdv_s,stx_s : std_logic;

BEGIN
  
  int1 : interface PORT MAP (rb_s, cp_s, dv_s, evt_s, num_s, sdi_s, sdv_s, stx_s);
  
  runTB : PROCESS
    VARIABLE dotimes  : integer :=  0;
    VARIABLE so_long  : integer := 25;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rb_s  <= '1';
    cp_s  <= '0';
    dv_s  <= '0';
    evt_s <= B"0010_0001";
    num_s <= B"0101_0101"; WAIT FOR 100 NS;
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
-- The next rising slope of cp_i stores 6x4Bits into register
    cp_s  <= '1'; WAIT FOR  10 NS; dv_s  <= '1'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
    cp_s  <= '1'; WAIT FOR  10 NS; dv_s  <= '0'; WAIT FOR  90 NS; cp_s  <= '0'; WAIT FOR 100 NS;
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
  -- Some SYScp-cycles:
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