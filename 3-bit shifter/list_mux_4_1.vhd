--=============================
-- Listing 4.1
--=============================
library ieee;
use ieee.std_logic_1164.all;
entity mux4 is
   port(
      a,b,c,d: in std_logic_vector(2 downto 0); -- 4 entradas, sendo cada uma um vetor de 3 bits
                                                -- a(2) = x2, a(1) = x1, a(0) = x0
                                                -- b(2) = x1, b(1) = x0, b(0) = x-1
                                                -- c(2) = x0, c(1) = x2, c(0) = x1
                                                -- d(2) = x3, d(1) = x2, d(0) = x1
      s: in std_logic_vector(1 downto 0); -- entrada de selecao de 2 bits - saida do cod pri
      x: out std_logic_vector(2 downto 0) -- saida do MUX - vetor de 3 bits
   );
end mux4;

architecture cond_arch of mux4 is
begin
   x <= a when (s="00") else -- função nao deslocar gera saida 'a'
        b when (s="01") else -- funcao SHL_1 gera a saida 'b'
        c when (s="10") else -- funcao SHR_1C gera a saida 'c'
        d;                   -- funcao SHR_1 gera a saida 'd'
end cond_arch;


