ARCHITECTURE ar1 OF c10 IS

  SIGNAL state_s : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

  cntx : PROCESS (rb_i,cp_i)
  BEGIN
    IF (rb_i='0') THEN state_s <= "0000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
      CASE state_s IS
        WHEN "0000" =>   state_s<= "0001";
        WHEN "0001" =>   state_s<= "0010";
        WHEN "0010" =>   state_s<= "0011";
        WHEN "0011" =>   state_s<= "0100";
        WHEN "0100" =>   state_s<= "0101";
        WHEN "0101" =>   state_s<= "0110";
        WHEN "0110" =>   state_s<= "0111";
        WHEN "0111" =>   state_s<= "1000";
        WHEN "1000" =>   state_s<= "1001";
        WHEN "1001" =>   state_s<= "0000";
        WHEN OTHERS =>   state_s<= "0000";
      END CASE;
    END IF;
  END PROCESS cntx;

  cout_o <= state_s(3) AND (NOT state_s(2))
          AND (NOT state_s(1)) AND state_s(0);
  
END ar1;