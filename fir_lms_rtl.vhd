----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2025 12:48:03 PM
-- Design Name: 
-- Module Name: fir_lms_rtl - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

    entity fir_lms_rtl is
        Port (
        i_x_ref : in std_logic_vector(7 downto 0);
        i_x : in std_logic_vector(7 downto 0);
        mu : in std_logic_vector(7 downto 0);
        out_x_est : inout std_logic_vector(15 downto 0);
        reset, clk: in std_logic
         );
    end fir_lms_rtl;

architecture Structural of fir_lms_rtl is
    component lms_rtl  is
        Port ( 
        i_x_ref: in std_logic_vector(7 downto 0);
        out_x_est : in std_logic_vector(15 downto 0);
        i_x : in std_logic_vector(7 downto 0);
        mu : in std_logic_vector(7 downto 0);
        reset, clk: in std_logic;
        w1, w2, w3, w4, w5: out std_logic_vector(7 downto 0)
        );
    end component;

    component fir_rtl  is
      Port (
        x_in: in std_logic_vector(7 downto 0);
        s_out: out std_logic_vector(15 downto 0);
        w1, w2, w3, w4, w5: in std_logic_vector(7 downto 0);
        clk : in std_logic;
        reset : in std_logic   
       );
    end component;
    
    signal w1, w2, w3, w4, w5 : std_logic_vector(7 downto 0);
    signal s_fir_out : std_logic_vector(15 downto 0);
--    signal reset, clk: std_logic;
    begin
    
    FIR1: fir_rtl
        port map (
          x_in   => i_x,
          w1 => w1,
          w2 => w2,
          w3 => w3,
          w4 => w4,
          w5 => w5,
          s_out => out_x_est,
          clk   => clk,
          reset => reset
        );
    
--    process(clk)
--    begin
--        if rising_edge(clk) then
--            if reset = '1' then
--                out_x_est <= (others => '0');
--            else
--                out_x_est <= s_fir_out; -- retard
--            end if;
--        end if;
--    end process;
    
    LMS1: lms_rtl
        port map (
          i_x => i_x,
          i_x_ref => i_x_ref,
          out_x_est => out_x_est,
          mu => mu,
          clk => clk,
          reset => reset,
          w1 => w1,
          w2 => w2,
          w3 => w3,
          w4 => w4,
          w5 => w5
        );
        

end Structural;
