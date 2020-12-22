-- ----------------------------------------------------------------------------

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.all;
  USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB2_top IS 
END TB2_top;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB2_top IS

  --constant
  CONSTANT cf_in_t : time := 83.3333333333333333333333 ns;
  -- input
  SIGNAL cp_s : std_logic := '0'; 
  SIGNAL rb_s,cl_s,s1_s,s2_s,s3_s: std_logic;
  -- output
  SIGNAL txd_s,tled_s,sec_s,sdo_s,sdv_s,stx_s,red_s,grn_s,sound_s : std_logic;

  -- internal
  SIGNAL br_s : std_logic;

  SIGNAL headcount_s : std_logic_vector(5 DOWNTO 0);
  SIGNAL maxr_s : std_logic;

  SIGNAL cup_s : std_logic;	-- increment counter
  SIGNAL cdown_s : std_logic;	-- decrement counter
  SIGNAL event_s : std_logic_vector(1 DOWNTO 0);
  SIGNAL detect_s : std_logic;	-- submit serial (data valid)
  
  SIGNAL done_s : std_logic;

  SIGNAL finish_s : std_logic;


BEGIN

  top_clock_divider : clock_divider PORT MAP (cp_s,rb_s,br_s,sec_s);
  counting_unit: cu1 PORT MAP (cp_s, rb_s, cl_s, cup_s,cdown_s, headcount_s, maxr_s); -- Counting Unit
  top_event_logger : event_logger PORT MAP (cp_s, rb_s, s1_s, s2_s, s3_s, done_s, finish_s,maxr_s, cup_s, cdown_s, event_s,detect_s, red_s, grn_s, sound_s); 
  uart : uat PORT MAP (cp_s, rb_s, detect_s, br_s, headcount_s, event_s, txd_s, tled_s,done_s); -- UART
  int : interface PORT MAP (cp_s, rb_s, br_s,  event_s, headcount_s, detect_s,  sdo_s, sdv_s, stx_s,finish_s); -- 3WireInterface


  
  -------------------------------------------------------------------------------
  -- simulation of a clock
  -------------------------------------------------------------------------------

  takt : PROCESS(cp_s)
  BEGIN
    cp_s <= NOT cp_s AFTER cf_in_t; --12MHz
  END PROCESS;

  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  -- simulation of a clock
  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  -----------------------------------------------------------
  -------------------------------------------------------------------------------
  -- generate and compare data
  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  daten : PROCESS

  BEGIN
  -------------------------------------------------------------------------------
  -- initial state
  -------------------------------------------------------------------------------
  rb_s  <= '0';
  s1_s <='0';
  s2_s <='0';
  s3_s <='0';
  cl_s <='0';
  WAIT FOR 5000*cf_in_t;

      rb_s  <= '1';
      WAIT FOR 100000*cf_in_t;
  -------------------------------------------------------------------------------
  -- let some people enter
  -------------------------------------------------------------------------------
  enter: FOR i IN 0 to (max_people-1) LOOP
  s1_s <='1';
  WAIT FOR 5000*cf_in_t;
  s1_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_in_t;
  s2_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s3_s <='1';
  WAIT FOR 5000*cf_in_t;
  s3_s <='0';
  ASSERT (false) REPORT "Someone entered."   SEVERITY note;
  WAIT FOR 100000*cf_in_t;
      ------------------------------------------------------------------------
  END LOOP;

  s1_s <='1';
  WAIT FOR 5000*cf_in_t;
  s1_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_in_t;
  s2_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s3_s <='1';
  WAIT FOR 5000*cf_in_t;
  s3_s <='0';
  ASSERT (false) REPORT "Someone entered. - The room is full."   SEVERITY note;
  WAIT FOR 100000*cf_in_t;

  -------------------------------------------------------------------------------
  -- let some people leave
  -------------------------------------------------------------------------------
  leave: FOR i IN 0 to 3 LOOP
  s3_s <='1';
  WAIT FOR 5000*cf_in_t;
  s3_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_in_t;
  s2_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s1_s <='1';
  WAIT FOR 5000*cf_in_t;
  s1_s <='0';
  ASSERT (false) REPORT "Someone left."   SEVERITY note;
  WAIT FOR 100000*cf_in_t;
      ------------------------------------------------------------------------
  END LOOP;

  -------------------------------------------------------------------------------
  -- initial state
  -------------------------------------------------------------------------------
  rb_s  <= '0';
  s1_s <='0';
  s2_s <='0';
  s3_s <='0';
  cl_s <='0';
  WAIT FOR 5000*cf_in_t;

      rb_s  <= '1';
      WAIT FOR 5000*cf_in_t;

  -------------------------------------------------------------------------------
  -- let some people enter
  -------------------------------------------------------------------------------
  enter_more: FOR i IN 0 to (2) LOOP
  s1_s <='1';
  WAIT FOR 5000*cf_in_t;
  s1_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_in_t;
  s2_s <='0';
  WAIT FOR 5000*cf_in_t;
  ------------------------------------------------------------------------
  s3_s <='1';
  WAIT FOR 5000*cf_in_t;
  s3_s <='0';
  ASSERT (false) REPORT "Someone entered."   SEVERITY note;
  WAIT FOR 100000*cf_in_t;
      ------------------------------------------------------------------------
  END LOOP;

  -------------------------------------------------------------------------------
  -- clear counter
  -------------------------------------------------------------------------------
  cl_s  <= '1';
  s1_s <='0';
  s2_s <='0';
  s3_s <='0';
  WAIT FOR 5000*cf_in_t;

      cl_s  <= '0';
      WAIT FOR 5000*cf_in_t;


  WAIT FOR 200000*cf_in_t;
    ASSERT (false) REPORT "Test ok!" SEVERITY failure;    
  END PROCESS;

END ar1;