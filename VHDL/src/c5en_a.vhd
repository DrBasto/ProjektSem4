ARCHITECTURE ar1 OF c12en IS

  SIGNAL state_s : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN

  cntx : PROCESS (rb_i,cp_i,enable_i)
  BEGIN
    IF (rb_i='0') THEN state_s <= "000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
      CASE state_s IS
        WHEN "000" => IF (enable_i='1') THEN state_s<= "001"; END IF;
        WHEN "001" => IF (enable_i='1') THEN state_s<= "010"; END IF;
        WHEN "010" => IF (enable_i='1') THEN state_s<= "011"; END IF;
        WHEN "011" => IF (enable_i='1') THEN state_s<= "100"; END IF;
        WHEN "100" => IF (enable_i='1') THEN state_s<= "000"; END IF;
        WHEN OTHERS =>                       state_s<= "000";
      END CASE;
    END IF;
  END PROCESS cntx;

  cout_o <= enable_i AND state_s(2) AND (NOT state_s(1))
               AND (NOT state_s(0));
  
END ar1;