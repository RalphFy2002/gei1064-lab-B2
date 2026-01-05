library ieee;
use ieee.std_logic_1164.all;

entity reg16_rtl is
  generic (N : integer :=16);
  port(	i_r: in std_logic_vector(N-1 downto 0);
	    reset,clk: in std_logic;
	    out_r: out std_logic_vector(N-1 downto 0)
      );
end reg16_rtl;  

architecture registre16 of reg16_rtl is
signal out_r_temp : std_logic_vector(N-1 downto 0);
begin 
    process(reset,clk)
    begin
        if reset='1' then 
           out_r_temp <= (others =>'0');
        elsif clk'event and clk='1' then
            out_r_temp <= i_r;
        end if;
    end process;
    out_r <= out_r_temp;      
end registre16;