
ARCHITECTURE ar1 OF clock_divider IS

SIGNAL count_s : integer:=1;
SIGNAL co_s : std_logic_vector(6 downto 0);
SIGNAL tmp_s : std_logic;
SIGNAL tmp2_s : std_logic;

BEGIN

PROCESS(rb_i,cp_i)
begin
    IF ((rb_i='0') AND (count_s = freq_baud AND (cp_i'event AND cp_i='1'))) THEN
        count_s <=1;
    ELSIF(cp_i'event AND cp_i='1') THEN
        count_s <= count_s+1;
    END IF;
END PROCESS;

PROCESS(rb_i,count_s) 
BEGIN 
    IF(rb_i='0') THEN
        tmp_s <= '0';
    ELSIF (count_s = freq_baud) THEN
        tmp_s <= '1';
    ELSE tmp_s <='0';
    END IF;
    END PROCESS;

br_s <= tmp_s;

PROCESS(rb_i,count_s) 
BEGIN 
    IF(rb_i='0') THEN
        tmp2_s <= '0';
    ELSIF (count_s = freq_hz) THEN
        tmp2_s <= '1';
    ELSE tmp2_s <='0';
    END IF;
    END PROCESS;

sec_o <= tmp2_s;

--clock_dividerE6 : c10  PORT MAP (rb_i,cp_i,co_s(6));             -- co_s(6) : 1200kHz
--clock_dividerE5 : c10en  PORT MAP (rb_i,cp_i,co_s(6),co_s(5));     -- co_s(5) :  120kHz
--clock_dividerE4 : c10en  PORT MAP (rb_i,cp_i,co_s(5),co_s(4));     -- co_s(4) :   12kHz
--clock_dividerE3 : c10en  PORT MAP (rb_i,cp_i,co_s(4),co_s(3));     -- co_s(3) :    1.2kHz
--clock_dividerE2 : c10en  PORT MAP (rb_i,cp_i,co_s(3),co_s(2));     -- co_s(2) :   120Hz
--clock_dividerE1 : c10en  PORT MAP (rb_i,cp_i,co_s(2),co_s(1));     -- co_s(1) :    12Hz
--clock_dividerE0 : c12en  PORT MAP (rb_i,cp_i,co_s(1),co_s(0));     -- co_s(0) :     1Hz
----------- BAUD RATE --------------------------
--clkbrE2 : c5en PORT MAP(rb_i,cp_i,co_s(6),brt_s(2));
--clkbrE1 : c5en PORT MAP(rb_i,cp_i,brt_s(2),brt_s(1));
--clkbrE0 : c5en PORT MAP(rb_i,cp_i,brt_s(1),brt_s(0));




--br_s <= brt_s(0);      -- 9,6 KHz, needed for baud-rate
--sec_o <= co_s(0);      -- 1Hz, from clock_dividerE0, 80ns high, ca. 1sec low

END ar1;
