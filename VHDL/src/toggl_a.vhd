-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF toggl IS

  SIGNAL tog_s : std_logic; -- toggeling signal

BEGIN

  toggle: PROCESS (rb_i,cp_i)
  BEGIN
    IF    (rb_i='0')               THEN tog_s <= '0';
    ELSIF (cp_i'EVENT AND cp_i='1') THEN
      IF (sig_i='1') THEN tog_s <= NOT tog_s;
      END IF;
    END IF;
  END PROCESS toggle;

  res_o <= tog_s;

END ar1;

-- ----------------------------------------------------------------------------