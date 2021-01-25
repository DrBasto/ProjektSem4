
ARCHITECTURE ar1 OF top IS
  -- PIN ASSIGMENT
  ATTRIBUTE chip_pin : string;
  ATTRIBUTE chip_pin of rb_i : SIGNAL IS "E6"; -- S2_USR_BTN_akt_low
  ATTRIBUTE chip_pin of cp_i : SIGNAL IS "H6"; -- CLK_12MHz

  ATTRIBUTE chip_pin of cl_i : SIGNAL IS "G12"; -- Digital in -J2/9 
  ATTRIBUTE chip_pin of s1_i : SIGNAL IS "L12"; -- Digital in -J2/1
  ATTRIBUTE chip_pin of s2_i : SIGNAL IS "J12"; -- Digital in -J2/2
  ATTRIBUTE chip_pin of s3_i : SIGNAL IS "J13"; -- Digital in -J2/3

  ATTRIBUTE chip_pin of rb_o : SIGNAL IS "A8";  -- LED1
  ATTRIBUTE chip_pin of sound_o : SIGNAL IS "A9"; -- LED2
  ATTRIBUTE chip_pin of sec_o : SIGNAL IS "A11"; -- LED3
  ATTRIBUTE chip_pin of grn_o : SIGNAL IS "B10"; -- LED5
  ATTRIBUTE chip_pin of red_o : SIGNAL IS "C9"; -- LED6
  ATTRIBUTE chip_pin of tled_o : SIGNAL IS "C10"; -- LED7
  
  ATTRIBUTE chip_pin of txd_o : SIGNAL IS "K11"; -- Digital out -J2/4
  ATTRIBUTE chip_pin of sdo_o : SIGNAL IS "K12"; -- Digital out -J2/5
  ATTRIBUTE chip_pin of sdv_o : SIGNAL IS "J10"; -- Digital out -J2/6
  ATTRIBUTE chip_pin of stx_o : SIGNAL IS "H10"; -- Digital out -J2/7
  --------------------------------------------------------------------
  -- INTERNAL SIGNALS
  SIGNAL br_s : std_logic; --- baud rate signal 9600 Hz
  SIGNAL sec_s : std_logic; --- 1hz signal

  SIGNAL headcount_s : std_logic_vector(5 DOWNTO 0); -- number of people
  SIGNAL maxr_s : std_logic;  --- max is reached signal

  SIGNAL cup_s : std_logic;	-- increment counter
  SIGNAL cdown_s : std_logic;	-- decrement counter
  SIGNAL event_s : std_logic_vector(1 DOWNTO 0); -- event vector 
  SIGNAL detect_s : std_logic;	-- submit serial (data valid)
  SIGNAL red_s: std_logic;
  SIGNAL grn_s: std_logic;
  SIGNAL sound_s: std_logic;
  
  SIGNAL txd_s : std_logic;
  SIGNAL tled_s : std_logic;
  SIGNAL done_s : std_logic; --- from UART, done transmitting

  SIGNAL sdo_s : std_logic;
  SIGNAL sdv_s : std_logic;
  SIGNAL stx_s : std_logic;
  SIGNAL finish_s : std_logic; ---  from 3 wire interface, finishing transmitting

  SIGNAL pls_s : std_logic; -- active pulse
  SIGNAL s1_s : std_logic;    -- debounced sensor 1 signal
  SIGNAL s2_s : std_logic;    -- debounced sensor 2 signal
  SIGNAL s3_s : std_logic;    -- debounced sensor 3 signal
  


BEGIN
  ----------------------------------------------------------------
  -- debouncers for buttons
  db1 : debnc GENERIC MAP (debounce_const)
  PORT    MAP (cp_i,rb_i,s1_i,s1_s);
  db2 : debnc GENERIC MAP (debounce_const)
  PORT    MAP (cp_i,rb_i,s2_i,s2_s);
  db3 : debnc GENERIC MAP (debounce_const)
  PORT    MAP (cp_i,rb_i,s3_i,s3_s);
  ----------------------------------------------------------------
  -- clock divider for baud and 1 hz signals
  top_clock_divider : clock_divider 
  PORT MAP (cp_i,rb_i,br_s,sec_s);
  ----------------------------------------------------------------
  -- Counting Unit
  counting_unit: cu1 
  PORT MAP (cp_i, rb_i, cl_i, cup_s,cdown_s, headcount_s, maxr_s); 
   ----------------------------------------------------------------
   -- Event logger/sensing unit
  top_event_logger : event_logger 
  PORT MAP (cp_i, rb_i, cl_i, s1_s, s2_s, s3_s, done_s, finish_s,maxr_s, cup_s, cdown_s, event_s,detect_s, red_s, grn_s, sound_s); 
   ----------------------------------------------------------------
   -- UART
  uart : uat 
  PORT MAP (cp_i, rb_i, detect_s, br_s, headcount_s, event_s, txd_s, tled_s,done_s); 
   ----------------------------------------------------------------
   -- 3WireInterface
  int : interface  
  PORT MAP (cp_i, rb_i, br_s,  event_s, headcount_s, detect_s,  sdo_s, sdv_s, stx_s,finish_s); 
   ----------------------------------------------------------------
   -- Toggle for LED
  tgl : toggl 
  PORT 	  MAP (cp_i, rb_i, sec_s,pls_s);

  --------------------------------------------------
  -- SETTING OUTPUTS

  txd_o <= txd_s;     -- data transmission
  tled_o <= tled_s;    -- data transmission indication
  
  sec_o <= pls_s;      -- device alive

  sdo_o <= sdo_s;     -- ic3 interface
  sdv_o <= sdv_s;     -- ic3 interface
  stx_o <= stx_s;     -- ic3 interface

  red_o <= red_s;     -- red LED
  grn_o <= grn_s; -- green LED  
  sound_o <= sound_s; 
  rb_o <= not rb_i;       -- reset indication

END ar1;
