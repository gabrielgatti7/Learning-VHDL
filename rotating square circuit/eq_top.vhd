library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
   port(
      clk   : in  std_logic;
      en    : in STD_LOGIC;
      cw    : in STD_LOGIC;
      an    : out std_logic_vector(7 downto 0);
      sseg  : out  std_logic_vector(7 downto 0);
      sw    : in std_logic_vector(1 downto 0)
   );
end eq_top;

architecture struc_arch of eq_top is
constant N : integer := 99999999;
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin
    
   fsm11_unit : entity work.fsm11(Behavioral)
      port map(
         enable => enable,
         en => sw(0),
         cw => sw(1),
         clk   => clk,
         reset => '0',
         in0   => "10011100",
         in1   => "10100011",
         sseg  => sseg,
         an    => an
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

