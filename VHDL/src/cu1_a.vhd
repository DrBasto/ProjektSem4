ARCHITECTURE ar1 OF cu1 IS

  SIGNAL headcount_s : unsigned(5 DOWNTO 0); -- 6 Bit

BEGIN
  
  ru_n: PROCESS (cp_i, rb_i, cl_i, cup_i, cdown_i)
  BEGIN
    IF rising_edge(cl_i) THEN 
        IF (rb_i = '0') THEN headcount_s <= "000000";
        ELSIF (cp_i'EVENT AND cp_i = '1') THEN
            IF (cup_i = '1') AND (cdown_i = '0') THEN headcount_s <= headcount_s + 1;
            ELSIF (cdown_i = '1') AND (cup_i = '0') THEN headcount_s <= headcount_s - 1;
            END IF;
        END IF;
    END IF;
  END PROCESS ru_n;

  maxr_o <= '1' WHEN headcount_s="111111" ELSE '0'; -- for the meantime this is the max
  headcount_o <= std_logic_vector(headcount_s);

END ar1;