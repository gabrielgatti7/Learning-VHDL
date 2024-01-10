library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity led_mux8 is
   port(
      enable   : in  std_logic;
      clk, reset         : in  std_logic;
      in3, in2, in1, in0 : in  std_logic_vector(7 downto 0);
      in7, in6, in5, in4 : in  std_logic_vector(7 downto 0);
      an                 : out std_logic_vector(7 downto 0);
      sseg               : out std_logic_vector(7 downto 0)
   );
end led_mux8;

architecture arch of led_mux8 is
   type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
   signal state_reg, state_next : eg_state_type;
begin
   -- state register
      process(clk, reset)
      begin
         if (reset = '1') then
            state_reg <= s0;
         elsif (clk'event and clk = '1') then
            if (enable='1') then
                state_reg <= state_next;
            end if;
         end if;
      end process;
 
   process(in0, in1, in2, in3, in4, in5, in6, in7)
   begin
      state_next <= state_reg;
      case state_reg is   
         when s0 =>
            an   <= "11111110";
            sseg <= in0;
            state_next <= s1;
         when s1 =>
            an   <= "11111101";
            sseg <= in1;
            state_next  <= s2;
         when s2 =>
            an   <= "11111011";
            sseg <= in2;
            state_next  <= s3;
         when s3 =>
            an   <= "11110111";
            sseg <= in3;
            state_next  <= s4;
         when s4 =>
            an   <= "11101111";
            sseg <= in4;
            state_next  <= s5;
         when s5 =>
            an   <= "11011111";
            sseg <= in5;
            state_next  <= s6;
         when s6 =>
            an   <= "10111111";
            sseg <= in6;
            state_next  <= s7;
         when others =>
            an   <= "01111111";
            sseg <= in7;
            state_next  <= s0;
      end case;
   end process;
end arch;