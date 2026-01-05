library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all; 

entity tronc_rtl is
generic (N : integer :=8);
    port ( i_a : in  std_logic_vector (2*N-1 downto 0);
           out_b: out std_logic_vector(N-1 downto 0)
          );
 end tronc_rtl;

architecture tronquage of tronc_rtl is
 signal inter : std_logic_vector (2*N-1 downto 0);
begin
inter <= i_a;
out_b <= inter(2*N-1 downto N);
end tronquage;