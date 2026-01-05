----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2025 05:54:22 PM
-- Design Name: 
-- Module Name: pe__rtl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Processeur élémentaire pour filtre FIR avec composants
-- 
-- Dependencies: mult_rtl, add_rtl, reg_rtl
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pe_adpta_1_rtl is
  port(
    i_x_ref     : in  std_logic_vector(7 downto 0);
    out_x_est   : in  std_logic_vector(15 downto 0);
    reset      : in  std_logic;
    clk         : in std_logic;
    mu : in std_logic_vector (7 downto 0);
    out_tronc   : out std_logic_vector(7 downto 0)
  );
end pe_adpta_1_rtl;

architecture Behavioral of pe_adpta_1_rtl is
  
  -- ========================
  -- Component Declarations
  -- ========================
  component tronc_rtl is
    generic (N : integer :=8);
    port ( i_a : in  std_logic_vector (2*N-1 downto 0);
           out_b: out std_logic_vector(N-1 downto 0)
          );
  end component;
  
  component sous_rtl is
    generic (N : integer :=8);
    port ( i_a,i_b : in  std_logic_vector (N-1 downto 0);
           reset         : in  std_logic;
           out_c        : out std_logic_vector(N-1 downto 0)
          );
  end component;
  
  component mult_rtl is
    generic (N : integer := 8);
    port (
      i_a, i_b  : in  std_logic_vector(N-1 downto 0);
      reset     : in  std_logic;
      out_c     : out std_logic_vector(2*N-1 downto 0)
    );
  end component;
  
  -- ========================
  -- Internal Signals
  -- ========================
  signal  tronc_out_x_est : std_logic_vector(7 downto 0);  -- Sortie du multiplieur
  signal sous_out  : std_logic_vector(7 downto 0);  -- Sortie du soustracteur
  signal mult_out : std_logic_vector(15 downto 0); -- Sortie du multiplieur

begin
  
 
  -- ========================
  -- Instantiate Multiplier
  -- Multiplication: mult_out = sous_out * mu 
  -- ========================
  mult1 : mult_rtl 
  port map(i_a => sous_out,
           i_b => mu,
           reset => reset,
           out_c => mult_out);
  
  -- ========================
  -- Instantiate Adder
  -- Soustraction: add_out = i_x_ref - tronc_out
  -- ========================
  sous1 : sous_rtl 
  port map(i_a => i_x_ref,
           i_b => tronc_out_x_est,
           reset => reset,
           out_c => sous_out
           );
  
  -- ========================
  -- Instantiate : troncage 16 en 8 bits 
  -- ========================
tronc1: tronc_rtl
  port map(i_a => out_x_est,
           out_b => tronc_out_x_est
           );
           
tronc2: tronc_rtl
port map(i_a => mult_out,
           out_b => out_tronc
           );
  
  
end Behavioral;