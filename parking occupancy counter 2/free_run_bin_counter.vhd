library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity free_run_bin_counter is
   generic(N : integer := 16);
   port(
      clk      : in  std_logic;
      reset    : in  std_logic;
      inc_ct   : in  std_logic;
      dec_ct   : in  std_logic;
      enabl   : in  std_logic;
      max_tick : out std_logic;
      q        : out std_logic_vector(N-1 downto 0)
   );
end free_run_bin_counter;

architecture arch of free_run_bin_counter is
   signal r_reg  : unsigned(N-1 downto 0);
   signal r_next_inc : unsigned(N-1 downto 0);
   signal r_next_dec : unsigned(N-1 downto 0);
begin
   -- register
   process(clk,reset)
   begin
      if (reset='1') then
         r_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         if (enabl = '1') then
             if (inc_ct='1') then
                r_reg <= r_next_inc;
             end if;
             if (dec_ct='1') then
                 r_reg <= r_next_dec;
             end if;
         end if;
      end if;
   end process;
   -- next-state logic
   r_next_inc <= r_reg + 1;
   r_next_dec <= r_reg - 1;
   -- output logic
   q <= std_logic_vector(r_reg);
end arch;