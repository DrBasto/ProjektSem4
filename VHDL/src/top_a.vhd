-- ----------------------------------------------------------------------------
-- top_a.vhd
-- ENTITIE for the TOP
-- 
-- Author:	Sebastian Romero ID:32303
-- 			Bahadir Ülkü
-- Last edited: 2020-11-13
ARCHITECTURE top_a OF top IS

  SIGNAL br_s : std_logic;
  SIGNAL hz_s : std_logic;

  SIGNAL evt_s : std_logic;
  SIGNAL num_s : std_logic;
  SIGNAL tim_s : std_logic;

  SIGNAL grn_s : std_logic;
  SIGNAL red_s : std_logic;
  SIGNAL txd_s : std_logic;
  SIGNAL sdi_s : std_logic;
  SIGNAL sdv_s : std_logic;
  SIGNAL stx_s : std_logic;

BEGIN

  uu1 : rate PORT MAP (rb_i,cp_i,br_s,hz_s);
  : PORT MAP (rb_i, cp_i, evt_s, num_s); -- HeadCount
  : PORT MAP (rb_i, cp_i, s1_i, s2_i, s3_i, num_s, evt_s, grn_s, red_s, snd_s); -- EventHandler
  : PORT MAP (rb:i, cp_i, tim_s); -- UniqueTime
  : PORT MAP (rb:i, cp_i, evt_s, num_s, tim_s, -, txd_s); -- UART
  : PORT MAP (rb_i, cp_i, evt_s, num_s, -, sdi_s, sdv_s, stx_s); -- 3WireInterface

  rb_o <= rb_i;
  grn_o <= grn_s; -- green LED
  red_o <= red_s; -- red LED
  tled_o <= txd_s;
  txd_o <= txd_s; -- data transmission
  sdi_o <= sdi_s; -- ic3 interface
  sdv_o <= sdv_s; -- ic3 interface
  stx_o <= stx_s; -- ic3 interface
  sdn_o <= snd_s; -- sound
  sec_o <= hz_s;

END top_a;
