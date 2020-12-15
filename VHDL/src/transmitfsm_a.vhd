ARCHITECTURE ar1 OF transmit_fsm IS

    TYPE state_name IS (idle_st, tstart_st, vec1_st, vec2_st, vec3_st, vec4_st, vec5_st, vec6_st, vec7_st, vec8_st, tstop_st);
    SIGNAL now_st,nxt_st : state_name;

    BEGIN
    
      clkd: PROCESS (rb_i,cp_i)
      BEGIN
        IF (rb_i='0') THEN now_st <= idle_st;
        ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
        END IF;
      END PROCESS clkd;
    
      st_trans: PROCESS (now_st, br_s, start_s)
      BEGIN
        nxt_st <= idle_st;
        CASE now_st IS
            WHEN idle_st => IF   (br_s ='1' AND start_s = '1') THEN nxt_st <= tstart_st;
                            ELSE                                    nxt_st <= idle_st;
                            END IF;
            WHEN tstart_st => IF (br_s ='1') THEN nxt_st <= vec1_st;
                            ELSE                  nxt_st <= tstart_st;
                            END IF;
            WHEN vec1_st => IF ((br_s ='1'))   THEN nxt_st <= vec2_st;
                            ELSE                    nxt_st <= vec1_st;
                            END IF;
            WHEN vec2_st => IF ((br_s ='1'))   THEN nxt_st <= vec3_st;
                            ELSE                    nxt_st <= vec2_st;
                            END IF;
            WHEN vec3_st => IF ((br_s ='1'))   THEN nxt_st <= vec4_st;
                            ELSE                    nxt_st <= vec3_st;
                            END IF;
            WHEN vec4_st => IF ((br_s ='1'))   THEN nxt_st <= vec5_st;
                            ELSE                    nxt_st <= vec4_st;
                            END IF;
            WHEN vec5_st => IF ((br_s ='1'))   THEN nxt_st <= vec6_st;
                            ELSE                    nxt_st <= vec5_st;
                            END IF;
            WHEN vec6_st => IF ((br_s ='1'))   THEN nxt_st <= vec7_st;
                            ELSE                    nxt_st <= vec6_st;
                            END IF;
            WHEN vec7_st => IF ((br_s ='1'))   THEN nxt_st <= vec8_st;
                            ELSE                    nxt_st <= vec7_st;
                            END IF;
            WHEN vec8_st => IF ((br_s ='1'))   THEN nxt_st <= tstop_st;
                            ELSE                    nxt_st <= vec8_st;
                            END IF;
            WHEN tstop_st => IF ((br_s ='1'))   THEN nxt_st <= idle_st;
                            ELSE                     nxt_st <= tstop_st;
                            END IF;
         
      END CASE;
      END PROCESS st_trans;
    
      ausgabe: PROCESS (now_st,event_s,headcount_s)
      BEGIN
        CASE now_st IS
         WHEN idle_st  =>     txd_s <= '1';            tled_o <= '0' ; done_s <= '0' ;
         WHEN tstart_st  =>   txd_s <= '0';            tled_o <= '0' ; done_s <= '0' ;
         WHEN vec1_st  =>     txd_s <= event_s(0);     tled_o <= '1' ; done_s <= '0' ;
         WHEN vec2_st  =>     txd_s <= event_s(1);     tled_o <= '1' ; done_s <= '0' ;
         WHEN vec3_st  =>     txd_s <= headcount_s(0); tled_o <= '1' ; done_s <= '0' ;
         WHEN vec4_st  =>     txd_s <= headcount_s(1); tled_o <= '1' ; done_s <= '0' ;
         WHEN vec5_st  =>     txd_s <= headcount_s(2); tled_o <= '1' ; done_s <= '0' ;
         WHEN vec6_st  =>     txd_s <= headcount_s(3); tled_o <= '1' ; done_s <= '0' ;
         WHEN vec7_st  =>     txd_s <= headcount_s(4); tled_o <= '1' ; done_s <= '0' ;
         WHEN vec8_st  =>     txd_s <= headcount_s(5); tled_o <= '1' ; done_s <= '0' ;
         WHEN tstop_st =>     txd_s <= '1';            tled_o <= '0' ; done_s <= '1' ;
        END CASE;
      END PROCESS ausgabe;
    
    END ar1;