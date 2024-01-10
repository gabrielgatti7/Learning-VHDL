library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fsm11 is
    Port ( clk, reset : in STD_LOGIC;
           enable   : in  std_logic;
           en         : in STD_LOGIC;
           cw         : in STD_LOGIC;
           in1, in0   : in  std_logic_vector(7 downto 0); -- indicam como acendera cada display;
           an                 : out std_logic_vector(7 downto 0); -- indica qual display acendera
           sseg               : out std_logic_vector(7 downto 0)); 
end fsm11;

architecture Behavioral of fsm11 is
    type eg_state_type is (s0,s1,s2,s3,s4,s5,s6,s7);
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
    process(state_reg, en, cw, in0, in1)
    begin
        state_next <= state_reg;
        case state_reg is
            when s0 =>
                an   <= "11110111";
                sseg <= in0;
                if en = '0' then
                    state_next <= s0;
                elsif cw = '1' then
                    state_next <= s1;
                else
                    state_next <= s7;
                end if;
            when s1 =>
                an   <= "11111011";
                sseg <= in0;
                if en = '0' then
                    state_next <= s1;
                elsif cw = '1' then
                    state_next <= s2;
                else
                    state_next <= s0;
                end if;
            when s2 =>
                an   <= "11111101";
                sseg <= in0;
                if en = '0' then
                    state_next <= s2;
                elsif cw = '1' then
                    state_next <= s3;
                else
                    state_next <= s1;
                end if;
            when s3 =>
                an   <= "11111110";
                sseg <= in0;
                if en = '0' then
                    state_next <= s3;
                elsif cw = '1' then
                    state_next <= s4;
                else
                    state_next <= s2;
                end if;
            when s4 =>
                an   <= "11111110";
                sseg <= in1;
                if en = '0' then
                    state_next <= s4;
                elsif cw = '1' then
                    state_next <= s5;
                else
                    state_next <= s3;
                end if;
            when s5 =>
                an   <= "11111101";
                sseg <= in1;
                if en = '0' then
                    state_next <= s5;
                elsif cw = '1' then
                    state_next <= s6;
                else
                    state_next <= s4;
                end if;
            when s6 =>
                an   <= "11111011";
                sseg <= in1;
                if en = '0' then
                    state_next <= s6;
                elsif cw = '1' then
                    state_next <= s7;
                else
                    state_next <= s5;
                end if;
            when s7 =>
                an   <= "11110111";
                sseg <= in1;
                if en = '0' then
                    state_next <= s7;
                elsif cw = '1' then
                    state_next <= s0;
                else
                    state_next <= s6;
                end if;
        end case;
    end process;                                       
end Behavioral;
