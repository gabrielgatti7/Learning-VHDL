library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
   port(
      clk   : in  std_logic;
      sw    : in std_logic_vector(1 downto 0);
      led   : out std_logic_vector(1 downto 0)
   );
end eq_top;

architecture struc_arch of eq_top is
constant N : integer := 49999999;
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin
    
   fsm11_unit : entity work.fsm11(Behavioral)
      port map(
         enable => enable,
         a => sw(0),
         b => sw(1),
         clk   => clk,
         reset => '0',
         car_enter => led(0),
         car_exit => led(1)
      );
    
    enable <= '1' when divide_clk = N else '0';
    
    process (clk)
              begin
                  if(clk'event and clk='1') then
                      divide_clk <= divide_clk+1;
                      if divide_clk = N then
                          divide_clk <= 0;
                      end if;
                  end if;
           end process;
end struc_arch;

