library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
 
entity sous_rtl is
generic (N : integer :=8);
    port ( i_a,i_b : in  std_logic_vector (N-1 downto 0);
           reset         : in  std_logic;
           out_c        : out std_logic_vector(N-1 downto 0)
          );
 end sous_rtl;

architecture soustraction of sous_rtl is
begin
  process(i_a,i_b,reset)
  variable c_temp : std_logic_vector(N-1 downto 0);
    begin
    c_temp := i_a - i_b;
    if (i_a(N-1)= '0')and (i_b(N-1)='1')and (c_temp(N-1)='1') and (reset = '0') then
        c_temp := (others =>'1');
        c_temp(N-1):= '0';
      elsif (i_a(N-1)= '1')and (i_b(N-1)='0')and (c_temp(N-1)='0') and (reset = '0') then
        c_temp := (others =>'0');
        c_temp(N-1):= '1';
      elsif (reset = '1') then
        c_temp := (others =>'0');
      end if;
      
out_c <=  c_temp;

end process;

end soustraction;
