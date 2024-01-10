library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
   port(
      clk  : in  std_logic;
      sw   : in  std_logic_vector(7 downto 0);
      led  : out std_logic_vector(3 downto 0)
   );
end eq_top;

architecture struc_arch of eq_top is
signal in_cod_prio : std_logic_vector(2 downto 0);
signal out_cod_prio : std_logic_vector(1 downto 0);
signal i_mux1 : std_logic_vector(3 downto 0);
signal i_mux2 : std_logic_vector(3 downto 0);
signal i_mux3 : std_logic_vector(3 downto 0);
signal i_mux4 : std_logic_vector(3 downto 0);
signal s_mux1 : std_logic;
signal s_mux2 : std_logic;
signal s_mux3 : std_logic;
signal s_mux4 : std_logic;
signal enable : std_logic;
signal q_ff   : std_logic_vector(3 downto 0);
signal inc_out1 : std_logic_vector(3 downto 0);
begin
in_cod_prio(2) <= sw(7); -- cLD
in_cod_prio(1) <= sw(6); -- cINC
in_cod_prio(0) <= sw(5); -- cSHR

i_mux1(3) <= sw(3);
i_mux2(3) <= sw(2);
i_mux3(3) <= sw(1);
i_mux4(3) <= sw(0); 

i_mux1(2) <= inc_out1(3);
i_mux2(2) <= inc_out1(2);
i_mux3(2) <= inc_out1(1);
i_mux4(2) <= inc_out1(0);

i_mux1(1) <= sw(4);
i_mux2(1) <= q_ff(3);
i_mux3(1) <= q_ff(2);
i_mux4(1) <= q_ff(1);

i_mux1(0) <= q_ff(3);
i_mux2(0) <= q_ff(2);
i_mux3(0) <= q_ff(1);
i_mux4(0) <= q_ff(0);

led(3) <= q_ff(3);
led(2) <= q_ff(2);
led(1) <= q_ff(1);
led(0) <= q_ff(0);


    cod_prio_unit : entity work.cod_prio(cond_arch)
        port map(
            r     => in_cod_prio,
            pcode => out_cod_prio
        );
    
   mux1_unit : entity work.mux_4x1(cond_arch)
      port map(
         i => i_mux1,
         c => out_cod_prio,
         s => s_mux1
      );
      
   mux2_unit : entity work.mux_4x1(cond_arch)
      port map(
         i => i_mux2,
         c => out_cod_prio,
         s => s_mux2
      );
        
   mux3_unit : entity work.mux_4x1(cond_arch)
      port map(
         i => i_mux3,
         c => out_cod_prio,
         s => s_mux3
      );
      
   mux4_unit : entity work.mux_4x1(cond_arch)
      port map(
         i => i_mux4,
         c => out_cod_prio,
         s => s_mux4
      );
      
    ff1_unit : entity work.FF_D(Behavioral)
       port map(
         D   => s_mux1,
         e   => enable,
         Q   => q_ff(3),
         clk => clk
       );
       
     ff2_unit : entity work.FF_D(Behavioral)
       port map(
         D   => s_mux2,
         e   => enable,
         Q   => q_ff(2),
         clk => clk
        );
        
     ff3_unit : entity work.FF_D(Behavioral)
         port map(
           D   => s_mux3,
           e   => enable,
           Q   => q_ff(1),
           clk => clk
         );
         
      ff4_unit : entity work.FF_D(Behavioral)
        port map(
          D   => s_mux4,
          e   => enable,
          Q   => q_ff(0),
          clk => clk
        );
      
      div_clk_unit : entity work.div_clk(Behavioral)
        port map(
            clk => clk,
            en  => enable
        );
       
      inc_4bit_unit : entity work.inc_4bits(Behavioral)
        port map(
            inc_in  => q_ff,
            inc_out => inc_out1
        );
end struc_arch;

