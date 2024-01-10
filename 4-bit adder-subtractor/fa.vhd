library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fa is
    Port ( a : in STD_LOGIC; -- entrada 'ax' do vetor a
           b : in STD_LOGIC; -- entrada 'bx' do vetor b
           ci : in STD_LOGIC; -- entrada carry in
           co : out STD_LOGIC; -- saida carry out
           s : out STD_LOGIC); -- resultado da soma
end fa;

architecture full_add of fa is
begin
    co <= (b and ci) or (a and ci) or (a and b);
    s <= a xor b xor ci;

end full_add;
