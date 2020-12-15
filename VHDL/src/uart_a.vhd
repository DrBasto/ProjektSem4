
ARCHITECTURE ar1 OF uat is

  SIGNAL start_s : std_logic;
  SIGNAL txd_s : std_logic;
  SIGNAL tled_s: std_logic;
  SIGNAL done_s: std_logic;

BEGIN

  ufsm1: control_fsm PORT MAP (cp_i,rb_i,detect_s,done_s,start_s);
  ufsm2: transmit_fsm PORT MAP (cp_i,rb_i,br_s,start_s, event_s,headcount_s,txd_s,tled_s,done_s);

  txd_o <= txd_s;
  tled_o <= tled_s;
  done_o <= done_s;

END ar1;