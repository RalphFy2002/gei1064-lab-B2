----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2025 05:54:22 PM
-- Design Name: 
-- Module Name: pe_fir_rtl - Behavioral
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

entity pe_adpt_2_rtl is
  port(
    i_x, out_tronc     : in  std_logic_vector(7 downto 0);
    reset, clk  : in  std_logic;
    out_reg, w       : out std_logic_vector(7 downto 0)
  );
end pe_adpt_2_rtl;

architecture Behavioral of pe_adpt_2_rtl is
  
  -- ========================
  -- Component Declarations
  -- ========================
  component reg_rtl is
    generic (N : integer := 8);
    port(
      i_r       : in  std_logic_vector(N-1 downto 0);
      reset, clk: in  std_logic;
      out_r     : out std_logic_vector(N-1 downto 0)
    );
  end component;
  
  component reg16_rtl is
  generic (N : integer :=16);
  port(	i_r: in std_logic_vector(N-1 downto 0);
	    reset,clk: in std_logic;
	    out_r: out std_logic_vector(N-1 downto 0)
      );
  end component;
  
  component add_rtl is
    generic (N : integer := 16);
    port (
      i_a, i_b  : in  std_logic_vector(N-1 downto 0);
      reset     : in  std_logic;
      out_c     : out std_logic_vector(N-1 downto 0)
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
  
    component tronc_rtl is
    generic (N : integer :=8);
    port ( i_a : in  std_logic_vector (2*N-1 downto 0);
           out_b: out std_logic_vector(N-1 downto 0)
          );
  end component;
  
  -- ========================
  -- Internal Signals
  -- ========================
  signal mult_out : std_logic_vector(15 downto 0);  -- Sortie du multiplieur
  signal add_out  : std_logic_vector(15 downto 0);  -- Sortie de l'additionneur
  signal reg_out : std_logic_vector(15 downto 0);
  
begin
  
  -- ========================
  -- Instantiate Register for X
  -- Retarde i_x d'un cycle d'horloge
  -- ========================
  reg1 : reg_rtl port map(i_r => i_x, 
                          reset  => reset,
                          clk => clk,
                          out_r => out_reg
                          );
  
  reg2 : reg16_rtl port map (i_r => add_out,
                             reset  => reset,
                             clk => clk,
                             out_r => reg_out
                              );
  -- ========================
  -- Instantiate Multiplier
  -- Multiplication: mult_out = i_x * w
  -- ========================
  mult1 : mult_rtl 
  port map(i_a => i_x, 
           i_b => out_tronc,
           reset => reset,
           out_c => mult_out
           );
  
  -- ========================
  -- Instantiate Adder
  -- Addition: add_out = mult_out + reg_out
  -- ========================
  add1 : add_rtl port map(i_a => reg_out, 
                          i_b => mult_out, 
                          reset => reset, 
                          out_c => add_out
                          );
  
  -- ========================
  -- Instantiate Tronc
  -- ========================
    tronc1: tronc_rtl 
    port map(i_a => add_out, 
             out_b => w);
  
  
  
end Behavioral;