------------------------------------------------------------------------------------
---- Company: 
---- Engineers: ALPHONSE and WOLFENSPERGER
---- 
---- Create Date: 12/09/2021 08:39:32 AM
---- Design Name: 
---- Module Name: decodeur_affichage - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 23.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
----use IEEE.std_logic_arith.all; 
----use IEEE.std_logic_unsigned.ALL;
--use IEEE.numeric_std.ALL;
---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity decodeur_affichage is Port (  
--   commande : in unsigned (5 downto 0); 
--   afficheur_num : in std_logic;
--   horloge:in std_logic ; 

--   numero_affiche : out integer);

--end decodeur_affichage;

--architecture archidecodeur_affichage of decodeur_affichage is
--signal pwm : integer;
--begin

--pwm<=to_integer (commande);
--process (afficheur_num)

--begin
----Dans le cas ou la commande ne comprend qu'un seul digit 
----on l'affiche sans traitement directement dans le premier afficheur 7 segments
--if ((afficheur_num='0')AND(pwm <10))then
--    numero_affiche<= pwm;

----Si la commande comprend 2 digits--
----On fait deux traitments de notre donnee

--elsif((pwm>=10)AND (pwm<64))then
----Tout d'abord on fait modulo 10 sur la position pour recuperer le chiffre de l'unit? et l'afficher sur le premier afficheur   

--    if(afficheur_num ='0')then
--    numero_affiche<=(pwm mod 10);
----Puis on divise par 10 pour recuperer le chiffre de la dizaine et l'afficher sur le deuxieme afficheur
--    elsif(afficheur_num ='1')then
--      numero_affiche<=pwm / 10;
--    end if;


----Si la commande comprend 3 digits--
----On fait 3 traitments de notre donnee
----Tout d'abord on fait modulo 10 sur la position pour recuperer le chiffre de l'unit? et l'afficher sur le premier afficheur   
----elsif(pwm>=100 AND pwm<999)then
----    if(afficheur_num ="00")then
----    numero_affiche<=(pwm mod 10);
---- --Puis on divise par 10 sur la position et le tout modulo 10, pour recuperer le chiffre de l'unit? et l'afficher sur le deuxieme afficheur     
----    elsif(afficheur_num ="01")then
----      numero_affiche<=(pwm/ 10)mod 10;
---- --Finalement  en divisant par 100 la position pour r?cuper le centierme et l'afficher sur le troisieme afficheur   
----    elsif(afficheur_num ="10")then
----     numero_affiche<=pwm / 100;
----   end if;


--else
----Dans le reste des cas on affiche rien en attribuant la valeur 10 qui n'est pas referencer dans notre table de verite
--   numero_affiche <=10;
--end if;

--end process;
--end archidecodeur_affichage; 





----------------------------------------------------------------------------------
-- Company: 
-- Engineers: ALPHONSE and WOLFENSPERGER
-- 
-- Create Date: 12/09/2021 08:39:32 AM
-- Design Name: 
-- Module Name: decodeur_affichage - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 23.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Company: ECN
-- Engineers: ALPHONSE and WOLFENSPERGER
-- 
-- Create Date: 01/2022 08:39:32 AM
-- Design Name: 
-- Module Name: decodeur_affichage - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 23.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.std_logic_arith.all; 
--use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

entity decodeur_affichage is Port (
        commande : in unsigned ;
        afficheur_num : in std_logic_vector(1 downto 0);
        horloge:in std_logic ;
        numero_affiche : out unsigned;
        sdp : out std_logic);

end decodeur_affichage;

architecture archidecodeur_affichage of decodeur_affichage is
    signal calcul : unsigned (5 downto 0);
begin
    process (afficheur_num)

    begin
        --Dans le cas ou la commande ne comprend qu'un seul digit 
        --on l'affiche directement dans le premier afficheur 7 segments
        if ((afficheur_num="00")AND(commande <10))then
            numero_affiche<=commande (3 downto 0);
        --Si la commande comprend 2 digits --On fait plusieurs traitments de notre donnee
        elsif((commande>=10)AND (commande<99))then
            ----Tout d'abord on fait modulo 10 sur la position pour recuperer le chiffre de l'unité et l'afficher sur le premier afficheur   
            if(afficheur_num ="00")then
                calcul<=(commande mod 10);
                numero_affiche<=calcul(3 downto 0);
            ----Puis on divise par 10 pour recuperer le chiffre de la dizaine et l'afficher sur le deuxieme afficheur
            elsif(afficheur_num ="01")then
                calcul<=commande / 10;
                numero_affiche<=calcul(3 downto 0);
            else
                --Dans le reste des cas on affiche rien en attribuant la valeur 10 qui n'est pas referencer dans notre table de verite
                numero_affiche <="1111";
            end if;
        else
            --Dans le reste des cas on affiche rien en attribuant la valeur 10 qui n'est pas referencer dans notre table de verite
            numero_affiche <="1111";
        end if;

    end process;
end archidecodeur_affichage;
