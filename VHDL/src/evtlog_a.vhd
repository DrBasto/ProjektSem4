ARCHITECTURE ar1 OF event_logger IS

  SIGNAL enter_s : std_logic;
  SIGNAL exit_s : std_logic;


BEGIN

  EL1 : logger_fsm PORT MAP (cp_i, rb_i,s1_i, s2_i, s3_i, done_s, finish_s,cup_s, cdown_s, enter_s, exit_s);
  EL2 : keeper_fsm PORT MAP (cp_i, rb_i, cl_i, enter_s, exit_s, maxr_s, done_s, finish_s,detect_s,event_s,red_o,grn_o,sound_o);
  
END ar1;
