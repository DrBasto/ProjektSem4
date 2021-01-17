ARCHITECTURE ar1 OF operator_fsm IS

    TYPE state_name IS (idle_st, 
                        send_st);
    SIGNAL now_st,nxt_st : state_name;

    BEGIN
    
        clkd: PROCESS (rb_i,cp_i)
        BEGIN
            IF (rb_i='0') THEN now_st <= idle_st;
            ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
            END IF;
        END PROCESS clkd;
        
        st_trans: PROCESS (now_st,detect_s, finish_s)
        BEGIN
        nxt_st <= idle_st;
        CASE now_st IS
            WHEN idle_st  => IF (detect_s ='1') THEN nxt_st <= send_st;
                            ELSE                nxt_st <= idle_st;
                            END IF;
            WHEN send_st  => IF  (finish_s ='1') THEN nxt_st <= idle_st;
                            ELSE                 nxt_st <= send_st;
                            END IF;
            
        END CASE;
        END PROCESS st_trans;
        
        st_outputs: PROCESS (now_st)
        BEGIN
        CASE now_st IS
            WHEN idle_st  => send_s <= '0';
            WHEN send_st  => send_s <= '1';
        END CASE;
        END PROCESS st_outputs;
    
    END ar1;