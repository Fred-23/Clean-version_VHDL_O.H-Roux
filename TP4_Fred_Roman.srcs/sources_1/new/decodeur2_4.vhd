------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 12/07/2021 10:34:07 AM
---- Design Name: 
---- Module Name: decodeur_BCD - Behavioral
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
--use IEEE.std_logic_arith.all;
---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity decodeur2_4 is Port (  
--    AFF: in std_logic; 
--    AN: out std_logic_vector(3 downto 0));
            
--end decodeur2_4;

--architecture archidecodeur2_4 of decodeur2_4 is

--begin

--with AFF select --passage de 2 bits ? 4 bits
--    AN <=  "1110" when '0',  --le 0 correspond ? l'afficheur allum?, les autres sont ? 1
--           "1101" when others;

--end archidecodeur2_4; 


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2021 10:34:07 AM
-- Design Name: 
-- Module Name: decodeur_BCD - Behavioral
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
use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodeur2_4 is Port (  
    AFF: in std_logic_vector(1 downto 0); 
    AN: out std_logic_vector(3 downto 0));
            
end decodeur2_4;

architecture archidecodeur2_4 of decodeur2_4 is

begin

with AFF select --passage de 2 bits ? 4 bits
    AN <=  "1110" when "00",  --le 0 correspond ? l'afficheur allum?, les autres sont ? 1
           "1101" when "01",
           "1011" when "10",
           "1111"  when others;

end archidecodeur2_4; 

