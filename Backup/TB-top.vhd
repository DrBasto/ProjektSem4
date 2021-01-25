-- ----------------------------------------------------------------------------

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.all;
  USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB1_top IS 
END TB1_top;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB1_top IS

  --constant
  CONSTANT cf_to_t : time := 83.3333333333333333333333 ns;
  -- input
  SIGNAL cp_s : std_logic := '0'; 
  SIGNAL rb_s,cl_s,s1_s,s2_s,s3_s: std_logic;
  -- output
  SIGNAL txd_s,tled_s,sec_s,sdo_s,sdv_s,stx_s,red_s,grn_s,sound_s : std_logic;

  BEGIN
  

  ST : top PORT MAP(cp_s,rb_s,cl_s,s1_s,s2_s,s3_s,txd_s,tled_s,sec_s,sdo_s,sdv_s,stx_s,red_s,grn_s,sound_s);
  
  -------------------------------------------------------------------------------
  -- simulation of a clock
  -------------------------------------------------------------------------------

  clock_sim : PROCESS(cp_s)
  BEGIN
    cp_s <= NOT cp_s AFTER cf_to_t; --12MHz
  END PROCESS;

  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  -- simulation of a clock
  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  -----------------------------------------------------------
  -------------------------------------------------------------------------------
  -- generate some numbers for the test
  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  some_numbers : PROCESS

  BEGIN
  -------------------------------------------------------------------------------
  -- initial state
  -------------------------------------------------------------------------------
  rb_s  <= '0';
  s1_s <='0';
  s2_s <='0';
  s3_s <='0';
  cl_s <='0';
  WAIT FOR 5000*cf_to_t;

      rb_s  <= '1';
      WAIT FOR 100000*cf_to_t;
  -------------------------------------------------------------------------------
  -- let some people enter
  -------------------------------------------------------------------------------
  enter: FOR i IN 0 to (max_people-1) LOOP
  s1_s <='1';
  WAIT FOR 5000*cf_to_t;
  s1_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_to_t;
  s2_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s3_s <='1';
  WAIT FOR 5000*cf_to_t;
  s3_s <='0';
  ASSERT (false) REPORT "Person enters."   SEVERITY note;
  WAIT FOR 100000*cf_to_t;
      ------------------------------------------------------------------------
  END LOOP;

  s1_s <='1';
  WAIT FOR 5000*cf_to_t;
  s1_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_to_t;
  s2_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s3_s <='1';
  WAIT FOR 5000*cf_to_t;
  s3_s <='0';
  ASSERT (false) REPORT "Person enters. - The room is full."   SEVERITY note;
  WAIT FOR 100000*cf_to_t;

  -------------------------------------------------------------------------------
  -- let some people leave
  -------------------------------------------------------------------------------
  leave: FOR i IN 0 to 3 LOOP
  s3_s <='1';
  WAIT FOR 5000*cf_to_t;
  s3_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_to_t;
  s2_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s1_s <='1';
  WAIT FOR 5000*cf_to_t;
  s1_s <='0';
  ASSERT (false) REPORT "Person leaves."   SEVERITY note;
  WAIT FOR 100000*cf_to_t;
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
  WAIT FOR 5000*cf_to_t;

      rb_s  <= '1';
      WAIT FOR 5000*cf_to_t;

  -------------------------------------------------------------------------------
  -- let some people enter
  -------------------------------------------------------------------------------
  enter_more: FOR i IN 0 to (2) LOOP
  s1_s <='1';
  WAIT FOR 5000*cf_to_t;
  s1_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s2_s <='1';
  WAIT FOR 5000*cf_to_t;
  s2_s <='0';
  WAIT FOR 5000*cf_to_t;
  ------------------------------------------------------------------------
  s3_s <='1';
  WAIT FOR 5000*cf_to_t;
  s3_s <='0';
  ASSERT (false) REPORT "Person enters"   SEVERITY note;
  WAIT FOR 100000*cf_to_t;
      ------------------------------------------------------------------------
  END LOOP;

  -------------------------------------------------------------------------------
  -- clear counter
  -------------------------------------------------------------------------------
  cl_s  <= '1';
  s1_s <='0';
  s2_s <='0';
  s3_s <='0';
  WAIT FOR 5000*cf_to_t;

      cl_s  <= '0';
      WAIT FOR 5000*cf_to_t;


  WAIT FOR 200000*cf_to_t;
    ASSERT (false) REPORT "Test ended" SEVERITY failure;    
  END PROCESS;

END ar1;