----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:03 09/30/2020 
-- Design Name: 
-- Module Name:    mux2_1_1bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2_1_1bit is
    Port ( b : in  STD_LOGIC_VECTOR(3 downto 0); -- entrada - vetor b de 4 bits
           sub : in  STD_LOGIC; -- entrada de seleção
           y : out  STD_LOGIC_VECTOR(3 downto 0) -- saída do MUX - vetor de 4 bits
    );
end mux2_1_1bit;

architecture cond_arch of mux2_1_1bit is
begin
   y <= b when sub = '0' else
	    not(b);
end cond_arch;
