library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
   port(
      clk   : in  std_logic;
      btn  : in  std_logic_vector(4 downto 0);
      an   : out std_logic_vector(3 downto 0);
      sseg : out std_logic_vector(7 downto 0)
   );
end eq_top;

architecture struc_arch of eq_top is
constant N : integer := 49999999;
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

signal inc : std_logic;
signal dec : std_logic;
signal q_out : std_logic_vector(15 downto 0);

signal a_in : std_logic;
signal b_in : std_logic;

begin
    
   fsm11_unit : entity work.fsm11(Behavioral)
      port map(
         enable => enable,
         a => a_in,
         b => b_in,
         clk   => clk,
         reset => '0',
         car_enter => inc,
         car_exit => dec
      );
      
    -- instanciacao contador
    counter_unit : entity work.free_run_bin_counter(arch)
        port map(
            clk => clk,
            reset => '0',
            inc_ct => inc,
            dec_ct => dec,
            enabl => enable,
            q => q_out
        );
     
     -- instantiate hex display time-multiplexing circuit
       disp_unit : entity work.disp_hex_mux
          port map(
             clk   => clk,
             reset => '0',
             hex3  => q_out(15 downto 12),
             hex2  => q_out(11 downto 8),
             hex1  => q_out(7 downto 4),
             hex0  => q_out(3 downto 0), 
             dp_in => "1011",
             an    => an(3 downto 0),
             sseg  => sseg
          );
    
    enable <= '1' when divide_clk = N else '0';
    
    -- instanciacao debounce btn 3 - left - a
    btn3_unit : entity work.db_fsm(arch)
        port map(
            clk => clk,
            reset => '0',
            sw => btn(3),
            db => a_in
        );
        
    -- instanciacao debounce btn 1 - right - b
    btn1_unit : entity work.db_fsm(arch)
        port map(
            clk => clk,
            reset => '0',
            sw => btn(1),
            db => b_in
        );
    
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

