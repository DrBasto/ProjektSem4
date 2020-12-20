-- ----------------------------------------------------------------------------
-- top_a.vhd
-- ENTITIE for the TOP
-- 
-- Author:	Sebastian Romero ID:32303
-- 			Bahadir Ülkü
-- Last edited: 2020-11-13
ARCHITECTURE ar1 OF top IS

  ATTRIBUTE chip_pin : string;
  ATTRIBUTE chip_pin of rb_i : SIGNAL IS "E6"; -- S2_USR_BTN_akt_low
  ATTRIBUTE chip_pin of cp_i : SIGNAL IS "H6"; -- CLK_12MHz

  ATTRIBUTE chip_pin of cl_i : SIGNAL IS "H8"; -- Digital in (0)
  ATTRIBUTE chip_pin of s1_i : SIGNAL IS "K10"; -- Digital in (1)
  ATTRIBUTE chip_pin of s2_i : SIGNAL IS "H5"; -- Digital in (2)
  ATTRIBUTE chip_pin of s3_i : SIGNAL IS "H4"; -- Digital in (3)

  ATTRIBUTE chip_pin of rb_o : SIGNAL IS "A8"; -- Digital out (4)
  ATTRIBUTE chip_pin of sound_o : SIGNAL IS "A9"; -- Digital out (4)
  ATTRIBUTE chip_pin of sec_o : SIGNAL IS "D8"; -- Digital out (5)
  ATTRIBUTE chip_pin of grn_o : SIGNAL IS "L12"; -- Digital out
  ATTRIBUTE chip_pin of red_o : SIGNAL IS "J12"; -- Digital out
  ATTRIBUTE chip_pin of tled_o : SIGNAL IS "A11"; -- Digital out
  ATTRIBUTE chip_pin of txd_o : SIGNAL IS "K11"; -- Digital out
  ATTRIBUTE chip_pin of sdo_o : SIGNAL IS "K12"; -- Digital out
  ATTRIBUTE chip_pin of sdv_o : SIGNAL IS "J10"; -- Digital out
  ATTRIBUTE chip_pin of stx_o : SIGNAL IS "H10"; -- Digital out

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
  SIGNAL done_s : std_logic;

  SIGNAL sdo_s : std_logic;
  SIGNAL sdv_s : std_logic;
  SIGNAL stx_s : std_logic;
  SIGNAL finish_s : std_logic;


BEGIN

  top_clock_divider : clock_divider PORT MAP (cp_i,rb_i,br_s,sec_s);
  counting_unit: cu1 PORT MAP (cp_i, rb_i, cl_i, cup_s,cdown_s, headcount_s, maxr_s); -- Counting Unit
  top_event_logger : event_logger PORT MAP (cp_i, rb_i, s1_i, s2_i, s3_i, done_s, finish_s,maxr_s, cup_s, cdown_s, event_s,detect_s, red_s, grn_s, sound_s); 
  uart : uat PORT MAP (cp_i, rb_i, detect_s, br_s, headcount_s, event_s, txd_s, tled_s,done_s); -- UART
  int : interface PORT MAP (cp_i, rb_i, br_s,  event_s, headcount_s, detect_s,  sdo_s, sdv_s, stx_s,finish_s); -- 3WireInterface

  
  txd_o <= txd_s;     -- data transmission
  tled_o <= tled_s;    -- data transmission indication
  
  sec_o <= sec_s;      -- device alive

  sdo_o <= sdo_s;     -- ic3 interface
  sdv_o <= sdv_s;     -- ic3 interface
  stx_o <= stx_s;     -- ic3 interface

  red_o <= red_s;     -- red LED
  grn_o <= grn_s; -- green LED  
  sound_o <= sound_s; 
  rb_o <= rb_i;       -- reset indication

END ar1;
