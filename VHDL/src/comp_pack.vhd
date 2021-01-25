

LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.all;
  USE IEEE.NUMERIC_STD.all;

-- --------------------------------------------------------------------



-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- TOP
-- --------------------------------------------------------------------
PACKAGE comp_pack IS
  COMPONENT top IS
  PORT(
    cp_i   : IN  std_logic;   --- clock
    rb_i   : IN  std_logic;   --- reset
    cl_i   : IN  std_logic;   --- clear number of people
    s1_i   : IN  std_logic;   --- gates
    s2_i   : IN  std_logic;
    s3_i   : IN  std_logic;
    txd_o  : OUT std_logic;   --- uart output
    tled_o : OUT std_logic;   --- LED
    sec_o : OUT std_logic;    
    sdo_o  : OUT std_logic;
    sdv_o  : OUT std_logic;
    stx_o  : OUT std_logic;
    red_o  : OUT std_logic;
    grn_o  : OUT std_logic;
    sound_o  : OUT std_logic
    );
  END COMPONENT;

  -----------------------------------------------------------------------
  COMPONENT toggl IS  -- Signal Toggle
  PORT (
    cp_i   : IN  std_logic;                      -- Syscp, @ 12MHz
    rb_i : IN  std_logic;                      -- Reset, active low
    sig_i   : IN  std_logic;                      -- Pulseing signal
    res_o   : OUT std_logic                       -- Toggeled output
    );
  END COMPONENT;

  -- --------------------------------------------------------------------
  COMPONENT debnc IS  -- Debouncer
  GENERIC (
    debounce_width : integer
    );
  PORT (
    cp_i : IN  std_logic;                      -- Reset, active low
    rb_i   : IN  std_logic;                      -- Syscp, @ 12MHz
    unb_i   : IN  std_logic;                      -- Unbounced Input
    deb_o   : OUT std_logic                       -- Debounced Output
    );
  END COMPONENT;
  ----------------------------------------------------------------------------
  COMPONENT clock_divider IS
  PORT(
      cp_i : IN std_logic;
      rb_i : IN std_logic;
      br_s : OUT std_logic;
      sec_o : OUT std_logic
      );
  END COMPONENT;

  -- --------------------------------------------------------------------

  COMPONENT cu1 IS
  PORT(
    cp_i : IN std_logic;
    rb_i : IN std_logic;
    cl_i : IN std_logic;
    cup_s : IN std_logic;
    cdown_s : IN std_logic;
    headcount_o : OUT std_logic_vector(5 DOWNTO 0);
    maxr_s : OUT std_logic
    );
  END COMPONENT;

  -- --------------------------------------------------------------------

  COMPONENT event_logger IS
  PORT(
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
	  cl_i : IN std_logic;
    s1_i : IN std_logic;
    s2_i : IN std_logic;
    s3_i : IN std_logic;
    done_s : IN std_logic; 
    finish_s : IN std_logic;
    maxr_s : IN std_logic;
    cup_s  : OUT std_logic;
    cdown_s  : OUT std_logic;
    event_s  : OUT std_logic_vector(1 DOWNTO 0);
    detect_s : OUT std_logic;
    red_o : OUT std_logic;
    grn_o : OUT std_logic;
    sound_o : OUT std_logic
    );
  END COMPONENT;

  -- --------------------------------------------------------------------

  COMPONENT uat is
  PORT(
    cp_i : IN std_logic;
    rb_i : IN std_logic;
    detect_s : IN std_logic;
    br_s : IN std_logic;
    headcount_s :  IN std_logic_vector(5 DOWNTO 0);
    event_s : IN std_logic_vector(1 DOWNTO 0);
    txd_o : OUT std_logic;
    tled_o : OUT std_logic;
    done_o : OUT std_logic
    );
  END COMPONENT;

  -- --------------------------------------------------------------------

  COMPONENT interface is
  PORT(
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
    br_s   : IN std_logic;
    event_s : IN std_logic_vector(1 DOWNTO 0);
    headcount_s : IN std_logic_vector(5 DOWNTO 0);
    detect_s : IN std_logic; 
    sdo_o  : OUT std_logic;
    sdv_o  : OUT std_logic;
    stx_o  : OUT std_logic;
    finish_o : OUT std_logic
    );
  END COMPONENT;

  -- --------------------------------------------------------------------
  -- --------------------------------------------------------------------

  -- UART
  -- --------------------------------------------------------------------

  COMPONENT control_fsm IS
  PORT (
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
    detect_s : IN std_logic;
    done_s : IN std_logic;
    start_s : OUT std_logic
      );
  END COMPONENT;

  -- --------------------------------------------------------------------

  COMPONENT transmit_fsm IS
  PORT(
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
    br_s : IN std_logic;
    start_s : IN std_logic;
    event_s : IN std_logic_vector(1 DOWNTO 0);
    headcount_s : IN std_logic_vector(5 DOWNTO 0);
    txd_s : OUT std_logic;
    tled_s : OUT std_logic;
    done_s : OUT std_logic
    );
  END COMPONENT;

  -- --------------------------------------------------------------------
  ---- EVENT LOGGER ---------------------

  COMPONENT logger_fsm IS
  PORT (   
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
    s1_i   : IN  std_logic;
    s2_i   : IN  std_logic;
    s3_i   : IN  std_logic;
    done_s : IN std_logic;
    finish_s : IN std_logic;
    cup_s  : OUT std_logic;
    cdown_s: OUT std_logic;
    enter_s: OUT std_logic;
    exit_s : OUT std_logic
        );
  END COMPONENT;

  -- --------------------------------------------------------------------

  COMPONENT keeper_fsm IS
  PORT (
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
	  cl_i : IN std_logic;
    enter_s : IN std_logic;
    exit_s : IN std_logic;
    maxr_s : IN std_logic;
    done_s : IN std_logic;
    finish_s : IN std_logic;
    detect_s : OUT std_logic;
    event_s : OUT std_logic_vector(1 DOWNTO 0);
    red_o : OUT std_logic;
    grn_o : OUT std_logic;
    sound_o : OUT std_logic
      );                      -- txd, Serial Output
  END COMPONENT;

  -- --------------------------------------------------------------------
  -- --------------------------------------------------------------------

  -- INTERFACE TO S3
  -- --------------------------------------------------------------------

  COMPONENT operator_fsm IS
  PORT (
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
    detect_s : IN std_logic;
    finish_s : IN std_logic;
    send_s : OUT std_logic
        );
  END COMPONENT;

  -- --------------------------------------------------------------------

  COMPONENT sender_fsm IS
  PORT ( 
    cp_i   : IN  std_logic;
    rb_i   : IN  std_logic;
    br_s : IN std_logic;
    send_s  : IN std_logic;
    event_s : IN std_logic_vector(1 DOWNTO 0);
    headcount_s : IN std_logic_vector(5 DOWNTO 0);
    sdo_o  : OUT std_logic;
    sdv_o  : OUT std_logic;
    stx_o  : OUT std_logic;
    finish_s : OUT std_logic
        );
  END COMPONENT;

-- --------------------------------------------------------------------

CONSTANT max_people : integer := 10; --- use in tb
CONSTANT debounce_const  : integer := 19;
CONSTANT num_width_const : integer :=  6;
CONSTANT evt_width_const : integer :=  2;

END comp_pack;