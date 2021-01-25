ARCHITECTURE ar1 OF cu1 IS

  SIGNAL headcount_s : unsigned(5 DOWNTO 0); -- 6 Bit

BEGIN
  
  run_counter: PROCESS (cp_i, rb_i, cl_i, cup_s, cdown_s)
  BEGIN
	  IF (rb_i = '0' OR cl_i = '1' ) THEN headcount_s <= "000000";
	  ELSIF (cp_i'EVENT AND cp_i = '1') THEN
			IF (cup_s = '1') AND (cdown_s = '0') THEN headcount_s <= headcount_s + 1;
			ELSIF (cdown_s = '1') AND (cup_s = '0') THEN headcount_s <= headcount_s - 1;
			END IF;
	  END IF;
  END PROCESS run_counter;

  maxr_s <= '1' WHEN headcount_s="001010" ELSE '0'; -- for the meantime this is the max = 10
  headcount_o <= std_logic_vector(headcount_s);

END ar1;