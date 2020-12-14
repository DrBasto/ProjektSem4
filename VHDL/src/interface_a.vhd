ARCHITECTURE ar1 OF top IS

  SIGNAL send_s : std_logic;
  SIGNAL finish_so : std_logic;


BEGIN

  If1 : operator_fsm PORT MAP (cp_i, rb_i,detect_s, finish_so, send_s);
  If2 : sender_fsm PORT MAP 

  
  txd_o <= txd_s;     -- data transmission
  tled_o <= tled_s;    -- data transmission indication
  
  sec_o <= sec_s;      -- device alive

  sdo_o <= sdo_s;     -- ic3 interface
  sdv_o <= sdv_s;     -- ic3 interface
  stx_o <= stx_s;     -- ic3 interface

  red_o <= red_s;     -- red LED
  grn_o <= grn_s; -- green LED  
  rb_o <= rb_i;       -- reset indication

END ar1;
