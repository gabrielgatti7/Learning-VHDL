library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fsm11 is
    Port ( clk, reset: in STD_LOGIC;
           enable    : in  std_logic;
           a         : in STD_LOGIC;
           b         : in STD_LOGIC;
           car_enter : out STD_LOGIC;
           car_exit  : out STD_LOGIC);
end fsm11;

architecture Behavioral of fsm11 is
    type eg_state_type is (s0,s1,s2,s3,s4,s5,s6,s7, s8);
    signal state_reg, state_next: eg_state_type;
begin
    -- state register
    process(clk, reset)
    begin
        if(reset = '1') then
            state_reg <= s0;
        elsif(clk'event and clk = '1') then
            if(enable = '1') then
                state_reg <= state_next;
            end if;
        end if;
    end process;
    
    -- next-state/output logic
    process(state_reg, a, b)
    begin
        state_next <= state_reg;
        car_enter <= '0';
        car_exit <= '0';
        case state_reg is
            when s0 =>
                if a = '1' then
                    state_next <= s1;
                elsif (a = '0' and b = '1') then
                    state_next <= s5;
                else
                    state_next <= s0;
                end if;
            when s1 =>
                if a = '0' then
                    state_next <= s0;
                elsif b = '1' then
                    state_next <= s2;
                else
                    state_next <= s1;
                end if;
            when s2 =>
                if b = '0' then
                    state_next <= s0;
                elsif a = '0' then
                    state_next <= s3;
                else
                    state_next <= s2;
                end if;
            when s3 =>
                if b = '0' then
                    state_next <= s4;
                elsif a = '1' then
                    state_next <= s2;
                else
                    state_next <= s3;
                end if;
            when s4 =>
                car_enter <= '1';
                state_next <= s0;
            when s5 =>
                if b = '0' then
                    state_next <= s0;
                elsif a = '1' then
                    state_next <= s6;
                else
                    state_next <= s5;
                end if;
            when s6 =>
                if a = '0' then
                    state_next <= s5;
                elsif b = '0' then
                    state_next <= s7;
                else
                    state_next <= s6;
                end if;
            when s7 =>
                if a = '0' then
                    state_next <= s8;
                elsif b = '1' then
                    state_next <= s6;
                else
                    state_next <= s7;
                end if;
            when s8 =>
                car_exit <= '1';
                state_next <= s0;
        end case;
    end process;                                       
end Behavioral;
