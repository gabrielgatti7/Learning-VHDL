library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
   port(
      clk   : in  std_logic;
      an    : out std_logic_vector(7 downto 0);
      sseg  : out  std_logic_vector(7 downto 0)
   );
end eq_top;

architecture struc_arch of eq_top is
constant N : integer := 49999999;
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin
    
   led_mux8_unit : entity work.led_mux8(arch)
      port map(
         enable => enable,
         clk   => clk,
         reset => '0',
         in7   => "11000000",
         in6   => "11111001",
         in5   => "10100100",
         in4   => "10110000",
         in3   => "10011001",
         in2   => "10010010",
         in1   => "10000010",
         in0   => "11111000",
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

