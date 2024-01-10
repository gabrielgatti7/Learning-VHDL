library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
   port(
      sw  : in  std_logic_vector(15 downto 0); -- sw0 ao 4 para o MUX, 
                                               -- sw13 ao 15 para o cod pri
      led : out std_logic_vector(2 downto 0)   -- 3 LEDs para a saida do MUX
   );
end eq_top;

architecture struc_arch of eq_top is

  signal c1: std_logic_vector (2 downto 0); -- variavel auxiliar para a func circular
                                            -- de entrada x0, x2, x1 (swithches desordenados)
  signal code1: std_logic_vector (1 downto 0); -- variavel aux. que guarda a saida do cod pri
                                               -- usada como entrada de selecao  do MUX
  
  begin 
  
  c1 <= sw(1) & sw(3) & sw(2); -- atribuicao dos switches correspondentes a x0, x2 e x1, respect.
  
  -- instanciacao do codificador de prioridade
  prio_encoder42_unit : entity work.prio_encoder42(cond_arch)
      port map(
         r    => sw(15 downto 13),
         code => code1
         );
   
   -- instanciacao do mux
   mux1_unit : entity work.mux4(cond_arch)
       port map(
          a    => sw(3 downto 1),
          b    => sw(2 downto 0),
          c    => c1,
          d    => sw(4 downto 2),
          s    => code1,
          x    => led(2 downto 0)
          );
      
end struc_arch;

