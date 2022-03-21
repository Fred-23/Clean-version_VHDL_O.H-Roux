------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 12/07/2021 11:25:28 AM
---- Design Name: 
---- Module Name: modulo_4 - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.std_logic_arith.all;  --utilisation de la librairie arithm√©tique pour la question 1
--use IEEE.std_logic_unsigned.ALL;
--use IEEE.numeric_std.ALL;
---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity modulo_3 is
--Port ( clk: in std_logic; 
--       Aff: out std_logic); -- signal de selction de l'afficheur sur deux bits
--end modulo_3;

--architecture archimodulo_3 of modulo_3 is
----signal compteur2 : std_logic_vector(1 downto 0);
--signal compteur : std_logic := '0';
----signal clk_mod : std_logic;

--begin
--Aff<=compteur;

--modulo : process(clk) --Pour basculer d'un afficbeur a un autre
-- begin
--    if(rising_edge (clk)) then --a chaque front montant de l'horloge d'entree
--        compteur<= not compteur; -- on incremente le compteur
--    end if;
--end process;
    
    
    
--end archimodulo_3;



----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2021 11:25:28 AM
-- Design Name: 
-- Module Name: modulo_4 - Behavioral
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
use IEEE.std_logic_arith.all;  --utilisation de la librairie arithmÈtique pour la question 1
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modulo_3 is
Port ( clk: in std_logic; 
       Aff: out std_logic_vector(1 downto 0)); -- signal de selction de l'afficheur sur deux bits
end modulo_3;

architecture archimodulo_3 of modulo_3 is
signal compteur2 : std_logic_vector(1 downto 0):="00";
--signal clk_mod : std_logic;

begin
Aff<=compteur2;

modulo : process(clk) --Pour basculer d'un afficbeur a un autre
 begin
    if(rising_edge (clk)) then --a chaque front montant de l'horloge d'entree
        compteur2<=compteur2+1; -- on incremente le compteur
--        if(compteur2="11") then --revenir au premier afficheur une fois avoir pass? le dernier
--            compteur2 <="00";
--            end if;
            
    end if;
end process;
    
    
end archimodulo_3;

