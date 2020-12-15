ARCHITECTURE ar1 OF interface IS

  SIGNAL send_s : std_logic;
  SIGNAL finish_s : std_logic;


BEGIN

  If1 : operator_fsm PORT MAP (cp_i, rb_i,detect_s, finish_s, send_s);
  If2 : sender_fsm PORT MAP (cp_i, rb_i, br_s, send_s,event_s,headcount_s,sdo_o,sdv_o,stx_o,finish_s);

  
   finish_o <= finish_s;     


END ar1;
