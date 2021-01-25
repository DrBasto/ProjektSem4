
LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY event_logger is
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
END event_logger;