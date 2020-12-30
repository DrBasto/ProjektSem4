-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF debnc IS

  SIGNAL cnt_s : unsigned(debounce_width-1 DOWNTO 0); -- about 5 ms
  SIGNAL sig_s : std_logic;

BEGIN

  PROCESS (rb_i,cp_i)
  BEGIN
    IF    (rb_i='0')               THEN cnt_s <= (others=>'0');
    ELSIF (cp_i'EVENT AND cp_i='1') THEN

      IF   (unb_i=sig_s) THEN cnt_s <= (others=>'0');
      ELSE                    cnt_s <= cnt_s + 1;
      END IF;

      IF (cnt_s = cnt_s'HIGH) THEN
        cnt_s <= (others=>'0');
        sig_s <= unb_i;
      END IF;

    END IF;
  END PROCESS;
  deb_o <= sig_s;

END ar1;

-- ----------------------------------------------------------------------------