-- ----------------------------------------------------------------------------
-- top_a.vhd
-- ENTITIE for the TOP
-- 
-- Author:	Sebastian Romero ID:32303
-- 			Bahadir Ülkü
-- Last edited: 2020-11-13
ARCHITECTURE ar1 OF top IS

  SIGNAL br_s : std_logic;
  SIGNAL sec_s : std_logic;

  SIGNAL headcount_s : std_logic_vector(5 DOWNTO 0);
  SIGNAL maxr_s : std_logic;

  SIGNAL cup_s : std_logic;	-- increment counter
  SIGNAL cdown_s : std_logic;	-- decrement counter
  SIGNAL event_s : std_logic_vector(1 DOWNTO 0);
  SIGNAL detect_s : std_logic;	-- submit serial (data valid)
  SIGNAL red_s: std_logic;
  SIGNAL grn_s: std_logic;
  SIGNAL sound_s: std_logic;
  
  SIGNAL txd_s : std_logic;
  SIGNAL tled_s : std_logic;

  SIGNAL sdo_s : std_logic;
  SIGNAL sdv_s : std_logic;
  SIGNAL stx_s : std_logic;


BEGIN

  cldv : clock_divider PORT MAP (rb_i,cp_i,br_s,sec_s);
  cou: cu1 PORT MAP (rb_i, cp_i, cl_i, cup_i,cdown_i, headcount_s, maxr_s); -- Counting Unit
  event_logger : evtlog PORT MAP (rb_i, cp_i, s1_i, s2_i, s3_i, maxr_s, cup_s, cdown_s, detect_s, red_s, grn_s, sound_s); 
  uar : uart PORT MAP (rb_i, cp_i, br_s, detect_s, headcount_s, event_s, txd_s, tled_s); -- UART
  int : interface PORT MAP (rb_i, cp_i, br_i,  event_s, headcount_s, detect_s,  sdo_s, sdv_s, stx_s); -- 3WireInterface

  
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
