

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.all;
  USE IEEE.NUMERIC_STD.all;

-- --------------------------------------------------------------------

PACKAGE comp_pack IS

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- TOP
-- --------------------------------------------------------------------

COMPONENT top IS
PORT(
  rb_i   : IN  std_logic;
  cp_i   : IN  std_logic;
  s1_i   : IN  std_logic;
  s2_i   : IN  std_logic;
  s3_i   : IN  std_logic;
  cl_i   : IN  std_logic;
  rb_o   : OUT std_logic;
  sec_o  : OUT std_logic;
  grn_o  : OUT std_logic;
  red_o  : OUT std_logic;
  tled_o : OUT std_logic;
  txd_o  : OUT std_logic;
  sdi_o  : OUT std_logic;
  sdv_o  : OUT std_logic;
  stx_o  : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT rate IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  br_o : OUT std_logic;
  hz_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT count IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  inc_i : IN std_logic;
  dec_i : IN std_logic;
  min_o : OUT std_logic;
  max_o : OUT std_logic;
  num_o : OUT std_logic_vector(7 DOWNTO 0)
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT control IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  enter_i : IN std_logic;
  leave_i : IN std_logic;
  min_i  : IN  std_logic;
  max_i  : IN  std_logic;
  inc_o : OUT std_logic;
  dec_o : OUT std_logic;
  evt_o : OUT std_logic_vector(7 DOWNTO 0);
  sub_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT trigger IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  s1_i : IN std_logic;
  s2_i : IN std_logic;
  s3_i : IN std_logic;
  enter_o : OUT std_logic;
  leave_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT uat is
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  br_i : IN std_logic;  -- baud rate
  dv_i : IN std_logic;  -- data valid
  num_i : std_logic_vector(7 DOWNTO 0); -- data (number)
  txd_o : OUT std_logic -- serial output
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT interface is
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  sub_i : IN std_logic;
  evt_i : IN std_logic_vector(7 DOWNTO 0);
  num_i : IN std_logic_vector(7 DOWNTO 0);
  sdi_o : OUT std_logic;
  sdv_o : OUT std_logic;
  stx_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- BAUD RATE GENERATOR
-- --------------------------------------------------------------------

COMPONENT c10ec IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN STD_LOGIC;
  co_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT c10xc IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  co_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT c12ec IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN std_logic;
  co_o : OUT std_logic
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT reg24e IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN std_logic;
  d_i  : IN std_logic_vector(7 DOWNTO 0);
  q_o  : OUT std_logic_vector(7 DOWNTO 0)
  );
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- UART
-- --------------------------------------------------------------------

COMPONENT uat_fsm IS
PORT (rb_i   :  IN std_logic;                     -- Reset, active low
      cp_i   :  IN std_logic;                     -- Syscp, @ 12MHz
      dv_i   :  IN std_logic;                     -- Have new RTC or GPS-Data
      br_i   :  IN std_logic;                     -- Baud-Rate to ena Counter
     dne_i   :  IN std_logic;                     -- Last Bit transmitted
     sto_o   : OUT std_logic;                     -- enable register load
     clr_o   : OUT std_logic;                     -- clear Bit-Counters
     nxt_o   : OUT std_logic                      -- next Bit, inc count
     );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT reg8 IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN std_logic;
  d_i  : IN std_logic_vector(7 DOWNTO 0);
  q_o  : OUT std_logic_vector(7 DOWNTO 0)
  );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT c11bin IS
PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
      cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
      en_i   :  IN STD_LOGIC;                     -- Enable Count
      cl_i   :  IN STD_LOGIC;                     -- Clear Counter
      co_o   : OUT STD_LOGIC;                     -- Carry Out
       q_o   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)   -- Counter Value
      );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT mx2tdo IS
PORT (s_i  :  IN STD_LOGIC_VECTOR(  3 DOWNTO 0);  -- get bits
      d_i  :  IN STD_LOGIC_VECTOR(  7 DOWNTO 0);  -- BYTE
    txd_o  : OUT STD_LOGIC);                      -- txd, Serial Output
END COMPONENT;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- INTERFACE TO S3
-- --------------------------------------------------------------------

COMPONENT interface_fsm IS
PORT (
  rb_i : IN std_logic;                     -- Reset, active low
  cp_i : IN std_logic;                     -- Syscp, @ 12MHz
  dv_i : IN std_logic;                     -- Have new RTC or GPS-Data
  dne_i : IN std_logic;                     -- Last Bit transmitted
  ldr_o : OUT std_logic;                     -- enable register load
  act_o : OUT std_logic;
  vld_o: OUT std_logic;
  clr_o : OUT std_logic;                     -- clear Bit-Counters
  nxt_o : OUT std_logic                      -- next Bit, inc count
      );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT c16bin IS
PORT (rb_i   :  IN STD_LOGIC;                     -- Reset, active low
      cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
      en_i   :  IN STD_LOGIC;                     -- Enable Count
      cl_i   :  IN STD_LOGIC;                     -- Clear Counter
      co_o   : OUT STD_LOGIC;                     -- Carry Out
       q_o   : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)   -- Counter Value
      );
END COMPONENT;

-- --------------------------------------------------------------------

COMPONENT mx2snd IS
PORT (s_i  :  IN STD_LOGIC_VECTOR( 4 DOWNTO 0);  -- get bits
      d_i  :  IN STD_LOGIC_VECTOR(15 DOWNTO 0);  -- BYTE
    txd_o  : OUT STD_LOGIC);                      -- txd, Serial Output
END COMPONENT;

-- --------------------------------------------------------------------

END comp_pack;