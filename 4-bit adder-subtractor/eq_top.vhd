library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
   port(
      sw  : in  std_logic_vector(15 downto 0); -- sw0 ao 3 para o vetor a
                                               -- sw4 ao 7 para o vetor b
                                               -- sw15 para sub
      led : out std_logic_vector(4 downto 0)   -- LEDs 0 a 3 para saída s
                                               -- LED 4 para overflow
   );
end eq_top;

architecture struc_arch of eq_top is

  signal co1: std_logic_vector(3 downto 0); -- vetor aux para co e ci
                                            -- ci dos full adders recebem co do anterior
  signal b_out: std_logic_vector (3 downto 0); -- vetor aux que guarda a saida do mux
                                               -- usada como entrada os full adder
  signal soma: std_logic_vector (3 downto 0); -- vetor aux que guarda as saidas dos full adder
  
  begin 
  
  led(3 downto 0) <= soma; -- conexao das saidas soma (resultado das operacoes) aos led corresp.
  
  -- eq overflow: a3.b3.s3' + a3'.b3'.s3
  led(4) <= (sw(3) and b_out(3) and not(soma(3))) or (not(sw(3)) and not(b_out(3)) and (soma(3)));
  
  
 -- instanciacao do mux 2x1
 mux_unit : entity work.mux2_1_1bit(cond_arch)
     port map(
         b    => sw(7 downto 4),
         sub  => sw(15),
         y    => b_out
         );
  
 -- instanciacao dos somadores completos
  fa_unit_1 : entity work.fa(full_add)
      port map(
         a   => sw(0),
         b   => b_out(0),
         ci  => sw(15),
         co  => co1(0),
         s   => soma(0)
         );
         
   fa_unit_2 : entity work.fa(full_add)
       port map(
          a   => sw(1),
          b   => b_out(1),
          ci  => co1(0),
          co  => co1(1),
          s   => soma(1)
          ); 
          
    fa_unit_3 : entity work.fa(full_add)
        port map(
           a   => sw(2),
           b   => b_out(2),
           ci  => co1(1),
           co  => co1(2),
           s   => soma(2)
           );
           
     fa_unit_4 : entity work.fa(full_add)
        port map(
           a   => sw(3),
           b   => b_out(3),
           ci  => co1(2),
           co  => co1(3),
           s   => soma(3)
           );
    
 
      
end struc_arch;

