
ARCHITECTURE ar1 OF clock_divider IS


SIGNAL brt_s : unsigned(10 DOWNTO 0);  ---- baud rate counter
SIGNAL sect_s : unsigned(23 DOWNTO 0); ---- baud rate counter


BEGIN
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
    IF (rb_i='0') THEN sect_s <= "000000000000000000000000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
        CASE sect_s IS
        WHEN "101101110001101011111111" => sect_s <= "000000000000000000000000";
        WHEN OTHERS =>   sect_s <= sect_s + 1;
        END CASE;
    END IF;
    END PROCESS cnthz;

    br_s <= '1' WHEN brt_s = "10011100001" ELSE '0'; -- 1249
    sec_o <= '1' WHEN sect_s = "101101110001101011111111" ELSE '0'; --11999999   

END ar1;
