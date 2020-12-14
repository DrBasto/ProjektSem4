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
    
      st_trans: PROCESS (now_st, br_i, start_s)
      BEGIN
        nxt_st <= idle_st;
        CASE now_st IS
            WHEN idle_st => IF   (br_s ='1' AND start_s = '1') THEN nxt_st <= maxreach_st;
                            ELSE                     nxt_st <= idle_st;
                            END IF;
            WHEN maxreach_st => IF (enter_s='0' AND exit_s='1') THEN nxt_st <= idle_st;
                            ELSE                                    nxt_st <= maxreach_st;
                            END IF;
            WHEN entry_st => IF (enter_s='0' AND exit_s='0')   THEN nxt_st <= idle_st;
                            ELSE                                    nxt_st <= entry_st;
                            END IF;
            WHEN exit_st => IF (enter_s='0' AND exit_s='0')   THEN nxt_st <= idle_st;
                            ELSE                                    nxt_st <= exit_st;
                            END IF;
                
         
      END CASE;
      END PROCESS st_trans;
    
      ausgabe: PROCESS (now_st)
      BEGIN
        CASE now_st IS
         WHEN idle_st  =>     event_s <= '00'; red_o <= '0' ; grn_o <= '1' ; sound_o <= '0' ; detect_s <= '0' ;
         WHEN entry_st  =>    event_s <= '01'; red_o <= '0' ; grn_o <= '1' ; sound_o <= '1' ; detect_s <= '1' ;
         WHEN exit_st  =>     event_s <= '10'; red_o <= '0' ; grn_o <= '1' ; sound_o <= '1' ; detect_s <= '1' ;
         WHEN maxreach_st =>  event_s <= '11'; red_o <= '1' ; grn_o <= '0' ; sound_o <= '1' ; detect_s <= '1' ;
        END CASE;
      END PROCESS ausgabe;
    
    END ar1;