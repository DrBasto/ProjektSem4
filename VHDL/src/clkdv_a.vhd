
ARCHITECTURE ar1 OF clock_divider IS

--SIGNAL co_s : std_logic_vector(6 downto 0);
SIGNAL brt_s : unsigned(10 DOWNTO 0);
SIGNAL hzt_s : unsigned(23 DOWNTO 0);
--SIGNAL braux_s : std_logic;
--SIGNAL aux2_s : std_logic;

BEGIN

    ----------- 1 Hz Rate --------------------------
--    clock_dividerE6 : c10  PORT MAP (rb_i,cp_i,co_s(6));             -- co_s(6) : 1200kHz
--    clock_dividerE5 : c10en  PORT MAP (rb_i,cp_i,co_s(6),co_s(5));     -- co_s(5) :  120kHz
--    clock_dividerE4 : c10en  PORT MAP (rb_i,cp_i,co_s(5),co_s(4));     -- co_s(4) :   12kHz
--    clock_dividerE3 : c10en  PORT MAP (rb_i,cp_i,co_s(4),co_s(3));     -- co_s(3) :    1.2kHz
--    clock_dividerE2 : c10en  PORT MAP (rb_i,cp_i,co_s(3),co_s(2));     -- co_s(2) :   120Hz
--    clock_dividerE1 : c10en  PORT MAP (rb_i,cp_i,co_s(2),co_s(1));     -- co_s(1) :    12Hz
--    clock_dividerE0 : c12en  PORT MAP (rb_i,cp_i,co_s(1),co_s(0));

    ----------- BAUD RATE --------------------------
    cntbr : PROCESS (rb_i,cp_i)
    BEGIN
    IF (rb_i='0') THEN brt_s <= "00000000000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
        CASE brt_s IS
        WHEN "10011100001" => brt_s <= "00000000000";
        WHEN OTHERS =>   brt_s <= brt_s + 1;
        END CASE;
    END IF;
    END PROCESS cntbr;

    ----------- 1 Hz Rate --------------------------
    cnthz : PROCESS (rb_i,cp_i)
    BEGIN
    IF (rb_i='0') THEN hzt_s <= "000000000000000000000000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
        CASE hzt_s IS
        WHEN "101101110001101011111111" => hzt_s <= "000000000000000000000000";
        WHEN OTHERS =>   hzt_s <= hzt_s + 1;
        END CASE;
    END IF;
    END PROCESS cnthz;

    br_s <= '1' WHEN brt_s = "10011100001" ELSE '0'; -- 1249
    sec_o <= '1' WHEN hzt_s = "101101110001101011111111" ELSE '0'; --11999999   
    --sec_o <= co_s(0);

END ar1;
