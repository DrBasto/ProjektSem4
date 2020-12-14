
ARCHITECTURE ar1 OF clock_divider IS

SIGNAL co_s    : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL brt_s    : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN

clock_dividerE6 : c10  PORT MAP (rb_i,cp_i,co_s(6));             -- co_s(6) : 1200kHz
clock_dividerE5 : c10en  PORT MAP (rb_i,cp_i,co_s(6),co_s(5));     -- co_s(5) :  120kHz
clock_dividerE4 : c10en  PORT MAP (rb_i,cp_i,co_s(5),co_s(4));     -- co_s(4) :   12kHz
clock_dividerE3 : c10en  PORT MAP (rb_i,cp_i,co_s(4),co_s(3));     -- co_s(3) :    1.2kHz
clock_dividerE2 : c10en  PORT MAP (rb_i,cp_i,co_s(3),co_s(2));     -- co_s(2) :   120Hz
clock_dividerE1 : c10en  PORT MAP (rb_i,cp_i,co_s(2),co_s(1));     -- co_s(1) :    12Hz
clock_dividerE0 : c12en  PORT MAP (rb_i,cp_i,co_s(1),co_s(0));     -- co_s(0) :     1Hz
----------- BAUD RATE --------------------------
clkbrE2 : c5en PORT MAP(rb_i,cp_i,co_s(6),brt_s(2));
clkbrE1 : c5en PORT MAP(rb_i,cp_i,brt_s(2),brt_s(1));
clkbrE0 : c5en PORT MAP(rb_i,cp_i,brt_s(1),brt_s(0));




br_s <= brt_s(0);      -- 9,6 KHz, needed for baud-rate
sec_o <= co_s(0);      -- 1Hz, from clock_dividerE0, 80ns high, ca. 1sec low

END ar1;
