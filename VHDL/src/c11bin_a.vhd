
ARCHITECTURE ar1 OF c11bin IS

SIGNAL state_s : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

cntx : PROCESS (rb_i,cp_i,en_i,cl_i)
BEGIN
  IF (rb_i='0') THEN state_s <= B"0000";
  ELSIF (cp_i='1' AND cp_i'EVENT) THEN
    IF (cl_i='1') THEN state_s <= "0000";
    ELSE
      CASE state_s IS
        WHEN B"0000" => IF (en_i='1') THEN state_s<= B"0001"; END IF;
        WHEN B"0001" => IF (en_i='1') THEN state_s<= B"0010"; END IF;
        WHEN B"0010" => IF (en_i='1') THEN state_s<= B"0011"; END IF;
        WHEN B"0011" => IF (en_i='1') THEN state_s<= B"0100"; END IF;
        WHEN B"0100" => IF (en_i='1') THEN state_s<= B"0101"; END IF;
        WHEN B"0101" => IF (en_i='1') THEN state_s<= B"0110"; END IF;
        WHEN B"0110" => IF (en_i='1') THEN state_s<= B"0111"; END IF;
        WHEN B"0111" => IF (en_i='1') THEN state_s<= B"1000"; END IF;
        WHEN B"1000" => IF (en_i='1') THEN state_s<= B"1001"; END IF;
        WHEN B"1001" => IF (en_i='1') THEN state_s<= B"1010"; END IF;
        WHEN B"1010" => IF (en_i='1') THEN state_s<= B"1011"; END IF;
        WHEN B"1011" => IF (en_i='1') THEN state_s<= B"0000"; END IF;
        WHEN OTHERS  =>                    state_s<= B"0000";
        END CASE;
    END IF;
  END IF;
END PROCESS cntx;

q_o   <= state_s;
co_o  <= state_s(3) AND (NOT state_s(2)) AND state_s(1) AND state_s(0);

END ar1;


