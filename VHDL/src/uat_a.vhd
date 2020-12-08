
ARCHITECTURE uat_a OF uat is

    SIGNAL txd_s : std_logic;
  
  BEGIN
  
    ufsm : uat_fsm PORT MAP (rb_i,cp_i,dv_i,br_i,dne_s,ld_s,clr_s,nxt_s);
    
    reg01: reg24e  PORT MAP (rb_i,cp_i,ld_s,d_i,qr_s);          -- 6x4 Bit Register
  
    txd_o <= txd_s;
  
  END uat_a;