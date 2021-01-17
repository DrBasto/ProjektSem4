ARCHITECTURE ar1 OF logger_fsm IS

    TYPE state_name IS (idle_st,     -- idle, waiting
                        s1passlr_st, -- first ligth sensor active
                        s2passlr_st, -- second light sensor active
                        entry_st,    -- 3rd light sensor active, someone enters
                        s3passrl_st, -- 3rd light sensor active
                        s2passrl_st, -- 2nd light sensor active
                        exit_st);    -- 3rd light sensor active, someone leaves
    SIGNAL now_st,nxt_st : state_name;

    BEGIN
    
      clkd: PROCESS (rb_i,cp_i)
      BEGIN
        IF (rb_i='0') THEN now_st <= idle_st;
        ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
        END IF;
      END PROCESS clkd;
    
      st_trans: PROCESS (now_st, s1_i, s2_i, s3_i, done_s, finish_s)
      BEGIN
        nxt_st <= idle_st;
        CASE now_st IS
            WHEN idle_st => IF    (s1_i = '1')  THEN nxt_st <= s1passlr_st;
                            ELSIF (s3_i = '1')  THEN nxt_st <= s3passrl_st;
                            ELSE                                    nxt_st <= idle_st;
                            END IF;
------------------------------------------------ entry -----------------------------------------------------------
            WHEN s1passlr_st => IF  (s2_i = '1')  THEN nxt_st <= s2passlr_st;
                            ELSIF (s3_i = '1')    THEN nxt_st <= s3passrl_st;
                            ELSE                       nxt_st <= s1passlr_st;
                            END IF;
            WHEN s2passlr_st => IF  (s3_i = '1')  THEN nxt_st <= entry_st;
                            ELSIF (s1_i = '1')    THEN nxt_st <= s1passlr_st;
                            ELSE                       nxt_st <= s2passlr_st;
                            END IF;
            WHEN entry_st => nxt_st <= idle_st;
                            
------------------------------------------------ exit -------------------------------------------------------------
            WHEN s3passrl_st => IF (s2_i = '1') THEN nxt_st <= s2passrl_st;
                            ELSIF (s1_i = '1')  THEN nxt_st <= s1passlr_st;
                            ELSE                     nxt_st <= s3passrl_st;
                            END IF;
            WHEN s2passrl_st => IF  (s1_i = '1')  THEN nxt_st <= exit_st;
                            ELSIF (s3_i = '1')    THEN nxt_st <= s3passrl_st;
                            ELSE                       nxt_st <= s2passrl_st;
                            END IF;
            WHEN exit_st => nxt_st <= idle_st;
         
      END CASE;
      END PROCESS st_trans;
    
      st_outputs: PROCESS (now_st)
      BEGIN
        CASE now_st IS
         WHEN idle_st      =>  enter_s <= '0'; exit_s <= '0' ; cup_s <= '0' ; cdown_s <= '0';
         WHEN s1passlr_st  =>  enter_s <= '0'; exit_s <= '0' ; cup_s <= '0' ; cdown_s <= '0';
         WHEN s2passlr_st  =>  enter_s <= '0'; exit_s <= '0' ; cup_s <= '0' ; cdown_s <= '0';
         WHEN entry_st     =>  enter_s <= '1'; exit_s <= '0' ; cup_s <= '1' ; cdown_s <= '0';
         WHEN s3passrl_st  =>  enter_s <= '0'; exit_s <= '0' ; cup_s <= '0' ; cdown_s <= '0';
         WHEN s2passrl_st  =>  enter_s <= '0'; exit_s <= '0' ; cup_s <= '0' ; cdown_s <= '0';
         WHEN exit_st      =>  enter_s <= '0'; exit_s <= '1' ; cup_s <= '0' ; cdown_s <= '1';
        END CASE;
      END PROCESS st_outputs;
    
    END ar1;