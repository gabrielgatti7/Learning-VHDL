--=============================
-- Listing 4.3
--=============================
library ieee;
use ieee.std_logic_1164.all;
entity prio_encoder42 is
   port(
      r: in std_logic_vector(2 downto 0); -- entrada - vetor de 3 bits, 
                                          -- sendo r(2) = SHR_1, 
                                          -- r(1) = SHR_1C
                                          -- e r(0) = SHL_1
      code: out std_logic_vector(1 downto 0);
      active: out std_logic
   );
end prio_encoder42;

architecture cond_arch of prio_encoder42 is
begin
   code <= "11" when (r(2)='1') else
           "10" when (r(1)='1') else
           "01" when (r(0)='1') else
           "00";
   active <= r(2) or r(1) or r(0);
end cond_arch;

