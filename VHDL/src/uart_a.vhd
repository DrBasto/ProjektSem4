
ARCHITECTURE ar1 OF uat is

  SIGNAL dat_s    : std_logic_vector(7 DOWNTO 0);   -- 8 BCD
  SIGNAL sel_s   : std_logic_vector(3 DOWNTO 0);

  SIGNAL hedcnt_evt_s : std_logic_vector(7 DOWNTO 0);
  SIGNAL ld_s : std_logic;  -- load in register
  SIGNAL nxt_s : std_logic;                       -- Next Bit
  SIGNAL clr_s : std_logic;                       -- Clear Counters
  SIGNAL dne_s : std_logic;                       -- Last Bit of 8x8
  SIGNAL d_s : std_logic;
  SIGNAL txd_s : std_logic;

BEGIN
  hedcnt_evt_s <= std_logic_vector(headcount_i) & std_logic_vector(event_i)

  ufsm: uat_fsm PORT MAP (rb_i,cp_i,dv_i,br_i,dne_s,ld_s,clr_s,nxt_s);
  
  reg: reg8 PORT MAP (rb_i,cp_i,ld_s,hedcnt_evt_s,dat_s);          -- 8 Bit Register

  cnt: c11bin PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,sel_s);

  mx: mx2tdo PORT MAP (sel_s,dat_s,txd_s);

  txd_o <= txd_s;
  tled_o <= txd_s; 

END ar1;