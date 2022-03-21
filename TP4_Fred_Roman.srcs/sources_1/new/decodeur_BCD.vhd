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

--entity decodeur_BCD is Port (  
--    DIGITS : in integer ; 
--    SEGMENTS : out std_logic_vector(6 downto 0));
            
--end decodeur_BCD;

--architecture archiBCD of decodeur_BCD is

--begin

--with DIGITS select --on attribue la valeur des segments en fonction de la valeur en entr�e
--    SEGMENTS <=  "1000000" when 0,
--                 "1111001" when 1,
--                 "0100100" when 2,
--                 "0110000" when 3,
--                 "0011001" when 4,
--                 "0010010" when 5,
--                 "0000010" when 6,
--                 "1111000" when 7,
--                 "0000000" when 8,
--                 "0010000" when 9,
----                 "0001000" when "1010",
----                 "0000011" when "1011",
----                 "0100111" when "1100",
----                 "0100001" when "1101",
----                 "0000110" when "1110",
--                 "1111111" when others;

--end archiBCD; 


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

entity decodeur_BCD is Port (  
    DIGITS : in UNSIGNED  ; 
    SEGMENTS : out std_logic_vector(6 downto 0));
            
end decodeur_BCD;

architecture archiBCD of decodeur_BCD is

begin

with DIGITS select --on attribue la valeur des segments en fonction de la valeur en entr?e
    SEGMENTS <=  "1000000" when "0000",
                 "1111001" when "0001",
                 "0100100" when "0010",
                 "0110000" when "0011",
                 "0011001" when "0100",
                 "0010010" when "0101",
                 "0000010" when "0110",
                 "1111000" when "0111",
                 "0000000" when "1000",
                 "0010000" when "1001",
--                 "0001000" when "1010",
--                 "0000011" when "1011",
--                 "0100111" when "1100",
--                 "0100001" when "1101",
--                 "0000110" when "1110",
                 "1111111" when others;

end archiBCD; 