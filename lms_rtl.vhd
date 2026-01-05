----------------------------------------------------------------------------------
-- Par Ralph FUTA
-- Étudiant en génie électrique (concentration génie informatique) a l'Universite du Québec a Trois-Rivieres 
-- Create Date: 11/27/2025 10:04:32 AM
-- Design Name: LMS
-- Module Name: lms_rtl 
-- Description: LMS utilisant 5 processeurs PEadpt2 et d'un seul processeur PEadpt1.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

    entity lms_rtl is
        Port ( 
        i_x_ref: in std_logic_vector(7 downto 0);
        out_x_est : in std_logic_vector(15 downto 0);
        i_x : in std_logic_vector(7 downto 0);
        mu : in std_logic_vector(7 downto 0);
        reset, clk: in std_logic;
        w1, w2, w3, w4, w5: out std_logic_vector(7 downto 0)
        );
    end lms_rtl;

architecture Structural of lms_rtl is
    component pe_adpta_1_rtl is
      port(
        i_x_ref     : in  std_logic_vector(7 downto 0);
        out_x_est   : in  std_logic_vector(15 downto 0);
        reset      : in  std_logic;
        clk         : in std_logic;
        mu : in std_logic_vector (7 downto 0);
        out_tronc   : out std_logic_vector(7 downto 0)
      );
    end component;
    
    component pe_adpt_2_rtl is
      port(
        i_x, out_tronc     : in  std_logic_vector(7 downto 0);
        reset, clk  : in  std_logic;
        out_reg, w       : out std_logic_vector(7 downto 0)
      );
    end component;

  signal reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, out_tronc  : std_logic_vector(7 downto 0);  -- Sortie registre
--  signal reset, clk : std_logic;
begin

-- Intanciation

    pe2_1: pe_adpt_2_rtl
          port map(i_x => i_x,
                   out_tronc => out_tronc,
                   reset => reset,
                   clk => clk,
                   out_reg => reg_out1, 
                   w => w1
               );
        
    pe2_2: pe_adpt_2_rtl
         port map( i_x => reg_out1,
                   out_tronc => out_tronc ,
                   reset => reset,
                   clk => clk,
                   out_reg => reg_out2,
                   w => w2 
               );
    pe2_3: pe_adpt_2_rtl
             port map(i_x => reg_out2,
                   out_tronc => out_tronc ,
                   reset => reset,
                   clk => clk,
                   out_reg => reg_out3, 
                   w => w3
               );
    pe2_4: pe_adpt_2_rtl
                 port map(i_x => reg_out3,
                   out_tronc => out_tronc ,
                   reset => reset,
                   clk => clk,
                   out_reg => reg_out4,
                   w => w4 
                    );
    pe2_5: pe_adpt_2_rtl
                   port map(i_x => reg_out4,
                   out_tronc => out_tronc ,
                   reset => reset,
                   clk => clk,
                   out_reg => reg_out5,
                   w => w5 
                    );
    pe1_1: pe_adpta_1_rtl
                   port map(
                   i_x_ref => i_x_ref,
                   out_x_est => out_x_est,
                   reset => reset,
                   clk => clk,
                   mu => mu,
                   out_tronc => out_tronc                
                    );
                
                
end Structural;
