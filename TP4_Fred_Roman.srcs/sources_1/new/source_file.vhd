----------------------------------------------------------------------------------
-- Company: ECN
-- Engineer: Frederic ALPHONSE et Roman Wolfensperger
-- 
-- Create Date: 01/19/2022 09:44:29 AM
-- Design Name: 
-- Module Name: source_file - Behavioral
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
--use IEEE.std_logic_arith.ALL;
--use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity source_file is
    Port (
        sys_clk_pin: in std_logic;
        cs_n : out std_logic;
        DIN  : out  std_logic;
        DOUT : in std_logic;

        sclk : out std_logic;

        --Les Anodes du 7 segments--
        an0 : out STD_LOGIC;
        an1 : out STD_LOGIC;
        an2 : out STD_LOGIC;
        an3 : out STD_LOGIC;

        --LEDs du 7 segments--
        seg0 : out STD_LOGIC;
        seg1 : out STD_LOGIC;
        seg2 : out STD_LOGIC;
        seg3 : out STD_LOGIC;
        seg4 : out STD_LOGIC;
        seg6 : out STD_LOGIC;
        seg5 : out STD_LOGIC;

        --Les BP---
        btnU : in std_logic;
        btnD : in std_logic;

        PWM_PIN : out std_logic;

        dp : out std_logic ;
        led0 : out std_logic;
        led1 : out std_logic;
        led2 : out std_logic;
        led3 : out std_logic;
        led4 : out std_logic;
        led5 : out std_logic;
        led6 : out std_logic;
        led7 : out std_logic;
        led8 : out std_logic;
        led9 : out std_logic );
end source_file;

architecture Behavioral of source_file is
    --On definit nos components pour faire le lien entre le fichier source et les fichiers externes

    component decodeur_BCD
        --Il s'agit de la table de v?rit? du d?codeur 7 segments--
        port(
            DIGITS : in unsigned;
            SEGMENTS : out std_logic_vector(6 downto 0));

    end component ;


    component decodeur_affichage is Port (
            --Ce composant va nous permettre de gerer l'affichage, en particulier pour les valeurs superieurs  10
            --Il va nous permettre d'afficher la consigne 6 bits (Q2C) et la consigne sur 8 bits (Q2D)
            commande : in unsigned;
            afficheur_num : in std_logic_vector(1 downto 0);
            horloge:in std_logic ;
            numero_affiche : out unsigned;
            sdp : out std_logic);

    end component;

    component decodeur2_4
        --Il s'agit de la table de v?rit? du d?codeur 2 to 4 pour simplifier la selection de l'affichage sur 2 bits--
        port(

            AFF : in std_logic_vector(1 downto 0);
            AN : out std_logic_vector(3 downto 0));

    end component ;

    component modulo_3
        port(

            clk: in std_logic;
            Aff: out std_logic_vector(1 downto 0));

    end component ;




    signal compteur_adc : UNSIGNED (6 downto 0):=(others=>'0');
    signal compteur_1_28_MHz : UNSIGNED (5 downto 0):=(others=>'0'); --signal du compteur pour fréquence de la PWM
    signal compteur_pwm : UNSIGNED (5 downto 0):=(others=>'0'); --signal du compteur pour le rapport cyclique de la PWM
    signal compteur_cycle : UNSIGNED (15 downto 0):=(others=>'0'); --signal du compteur pour fréquence de la PWM
    --signal cpt_etapes : UNSIGNED (5 downto 0):=(others=>'0');

    signal trame_DIN : UNSIGNED (3 downto 0):="1010";
    signal MOSI : std_logic :='0';
    signal MISO : std_logic :='0';
    signal adc_sclk : std_logic:='0';  --Ne pas oublier d'initialiser sinon on est en undefined et pas d'horloge
    signal sigcs_n :std_logic:='1';
    signal trame_DOUT : UNSIGNED (9 downto 0):=(others=>'0');

    signal clock_pwm : std_logic :='0';
    signal sig_pwm : std_logic :='0';
    signal clock_cycle : std_logic :='0';
    signal sig_cycle : std_logic :='0';
    signal compteur_aff : UNSIGNED (19 downto 0):="00000000000000000000"; --signal du compteur pour l'horloge des 7 segments

    --signal consigne : unsigned (5 downto 0):=(others=>'0');
    signal consigne : unsigned (5 downto 0):="000000";
    signal commande_asservissement : unsigned (5 downto 0):="000000";

    signal bouton_up : std_logic :='0';
    signal bouton_down: std_logic :='0';

   

    signal sig_relache_haut : std_logic := '1';
    signal sig_relache_bas : std_logic := '1';

    signal cpt_BP_bas : unsigned (9 downto 0):=(others=>'0');
    signal cpt_BP_haut : unsigned (9 downto 0):=(others=>'0');
    signal BP_haut : std_logic :='1';
    signal BP_bas : std_logic :='1';

    signal clock_ms : std_logic :='0'; --horloge afficheurs 7 seg
    --signal sigaff : std_logic:='0'; --signal de l'afficheur

    signal sigaff : std_logic_vector (1 downto 0):="00"; --signal de selection de l'afficheur
    signal sigseg : std_logic_vector(6 downto 0);
    signal sigDigits : unsigned (3 downto 0 ):=(others=>'0');
     signal sigAN : std_logic_vector(3 downto 0); --Signal pour controler les anodes du 7 segments
    signal cpt_etapes : UNSIGNED (5 downto 0):=(others=>'0');
    signal sigdp : std_logic;

    signal tension : UNSIGNED (39 downto 0) := (others=>'0');
    --signal mesure_fem : UNSIGNED (39 downto 0) := (others=>'0');
    signal mesure : UNSIGNED (39 downto 0) := (others=>'0');
    signal lecture_fem : UNSIGNED (39 downto 0) := (others=>'0');
    signal test_fem : UNSIGNED (5 downto 0) := (others=>'0');
    signal affem : UNSIGNED (5 downto 0) := (others=>'0');
    signal prop_calcul : UNSIGNED (11 downto 0) := (others=>'0');
    
   


begin

    sclk<=adc_sclk;
    DIN<=MOSI;
    MISO<=DOUT;
    cs_n <=sigcs_n;

    --    led0 <= trame_DOUT(0);
    --    led1 <= trame_DOUT(1);
    --    led2 <= trame_DOUT(2);
    --    led3 <= trame_DOUT(3);
    --    led4 <= trame_DOUT(4);
    --    led5 <= trame_DOUT(5);
    --    led6 <= trame_DOUT(6);
    --    led7 <= trame_DOUT(7);
    --    led8 <= trame_DOUT(8);
    --    led9 <= trame_DOUT(9);

    --    led0 <= affem(0);
    --    led1 <= affem(1);
    --    led2 <= affem(2);
    --    led3 <= affem(3);
    --    led4 <= affem(4);
    --    led5 <= affem(5);led0 <= affem(0);
    --    led1 <= affem(1);
    --    led2 <= affem(2);
    --    led3 <= affem(3);
    --    led4 <= affem(4);
    --    led5 <= affem(5);
    dp<=sigdp;

    --sclk<=clock_pwm;  pour

    --bouton_down<=btnD;
    --bouton_up<=btnU;

    --raccordement des signaux :
    BP_haut<=btnU;
    BP_bas<=btnD;

    --consigne<="000001";
    led0 <= consigne(0);
    led1 <= consigne(1);
    led2 <= consigne(2);
    led3 <= consigne(3);
    led4 <= consigne(4);
    led5 <= consigne(5);


    --Raccordement des signaux du 7-segments--
    seg0<=sigseg(0);
    seg1<=sigseg(1);
    seg2<=sigseg(2);
    seg3<=sigseg(3);
    seg4<=sigseg(4);
    seg5<=sigseg(5);
    seg6<=sigseg(6);

    --Raccordement des  signaux des anodes du 7seg---
    an0<=sigAn(0);
    an1<=sigAn(1);
    an2<=sigAn(2);
    an3<=sigAn(3);

    --consigne <="100000";

    --PWM_PIN<=sig_pwm ;
    PWM_PIN<=sig_cycle ;

    --decodeur_aff : decodeur_affichage
    --  port map(consigne,sigaff,clock_ms,sigDigits);
    --lecture_fem<=test_fem(5 downto 0) ;
    
    decodeur_aff : decodeur_affichage
        port map(affem,sigaff,clock_ms,sigDigits,sigdp);


    decodeur_seg : decodeur_BCD
        port map(sigDigits,sigseg);

    modulo_3_3 : modulo_3
        port map(clock_ms ,sigaff);

    decodeur_2_vers_4 : decodeur2_4
        port map(sigaff,sigAn);


    lecture_bouton : process(sys_clk_pin)
    begin
        if(rising_edge(sys_clk_pin)) then
            --Partie Incrementation :
            if(BP_haut='0' AND sig_relache_haut='1') then -- On incremente le compteur pour verifier que le Bouton est pressé
                cpt_BP_haut <= cpt_BP_haut + 1;
                if(cpt_BP_haut="1111111111" AND (consigne<63)) then
                    consigne <= consigne + 1; --on incremente la consigne
                    cpt_BP_haut <= "0000000000";
                    sig_relache_haut <= '0'; --pour attendre que le bouton soit bien relaché
                end if;
            elsif(BP_haut='1' AND sig_relache_haut='0') then
                sig_relache_haut <= '1';
            else -- Bouton Poussoir à l'état 1 donc rebond
                cpt_BP_haut <= "0000000000";
            end if;
            --Partie Decrementation :
            if(BP_bas='0' AND sig_relache_bas='1') then -- On incremente le compteur pour verifier que le Bouton est pressé
                cpt_BP_bas <= cpt_BP_bas + 1;
                if(cpt_BP_bas="1111111111" AND (consigne>0)) then
                    consigne <= consigne - 1; --on decremente la consigne
                    cpt_BP_bas <= "0000000000";
                    sig_relache_bas <= '0'; --pour attendre que le bouton soit bien relaché 
                end if;
            elsif(BP_bas='1' AND sig_relache_bas='0') then
                sig_relache_bas <= '1';
            else -- Bouton Poussoir à l'état 1 donc rebond
                cpt_BP_bas <= "0000000000";
            end if;
        end if;
    end process;


    prop_calcul<=((40*(consigne-affem)));
    commande_asservissement<=prop_calcul(5 downto 0);
   

    clk : process(sys_clk_pin) -- process horloge afficheur 7 seg
    begin
        if(rising_edge (sys_clk_pin)) then
            compteur_aff <= compteur_aff+1;
            --if(compteur_aff>="1100001101010000") then   --On inverse la sortie apres 50 000 fronts montants
            if(compteur_aff="00110000110101000000") then
                clock_ms <=not clock_ms ;
                compteur_aff<=(others=>'0');
            end if;
        end if;
    end process;

    --Cela correnspond  la trame d'envoie DIN soit MOSI "1101"
    with cpt_etapes  select
 MOSI<=  '1' when "000000",
        '1'when "000001",
        '1'when "000010",
        '1'when "000011",
        '1'when "000110",
        '1'when "000111",    --Maintenir l'etat
        '0'  when others;

    with cpt_etapes  select
 sigcs_n<= '0'when "000000",
        '1'when "011110",
        '1'when "011111",
        '0'when others;


    --tension<=((33*trame_DOUT) /1024)*10;
    --mesure<=((64*trame_DOUT) /1024)*10;
    test_fem<=(trame_DOUT (9 downto 4));


    etapes: process(cpt_etapes)
    begin

        if((cpt_etapes>=10)AND (cpt_etapes<30)) then

            if((cpt_etapes mod 2)=0) then
                trame_DOUT(to_integer(9-((cpt_etapes-10)/2)))<=MISO;
            end if;

        end if;

    end process;

    adc_clk: process(sys_clk_pin)
    begin
        --Nous divisons la clk du systeme a 100Mhz a 1 Mhz en divisant par 100     l horloge avec un vecteur de bits
        if(rising_edge (sys_clk_pin)) then
            if(compteur_adc =50) then
                adc_sclk<=not adc_sclk;
                compteur_adc<="0000000";
                cpt_etapes <=cpt_etapes +1;
                if(cpt_etapes=32) then
                    cpt_etapes<="000000";
                end if;
            else
                compteur_adc <=compteur_adc +1;
            end if;
        end if;
    end process;


    PWM_freq : process(sys_clk_pin) -- process génération d'un signal carré de 20KHz pour la PWM
    begin
        if(rising_edge(sys_clk_pin)) then
            compteur_1_28_MHz <= compteur_1_28_MHz+1;
            if(compteur_1_28_MHz>="100111") then   --On inverse la sortie après 39 fronts montants
                clock_pwm <=not clock_pwm ; --horloge 1,28MHz après 64 tour d'horloge on a 20KHz
                compteur_1_28_MHz<=(others=>'0');
            end if;
        end if;
    end process;

  

    PWM_duty_cycle : process(clock_pwm) -- génération de la PWM
    begin
        if(rising_edge(clock_pwm)) then

            if(compteur_pwm=commande_asservissement AND (commande_asservissement<63)) then   --On inverse la sortie après 2500 fronts montants
                sig_pwm <= '0';
            elsif(compteur_pwm="111111" AND (commande_asservissement >0)) then --quand le compteur atteind 63
                sig_pwm <= '1'; --le signal est à l'état haut sur toutes les étapes entre 0 et la consigne
                compteur_pwm<=(others=>'0');
                --le compteur 111111 est automatiquement remis à 000000
            end if;
            compteur_pwm <= compteur_pwm+1;
        end if;
    end process;


    Cycle_freq : process(sys_clk_pin) -- process génération d'un signal carré de 20KHz pour la PWM
    begin
        if(rising_edge(sys_clk_pin)) then
            compteur_cycle <= compteur_cycle+1;
            if(compteur_cycle>="1100001101010000") then   --On inverse la sortie après 50000 fronts montants
                clock_cycle <=not clock_cycle ; --periode de 2ms

                compteur_cycle<=(others=>'0');
            elsif((clock_cycle='0') AND (compteur_cycle="1001110001000000")) then
                affem<=test_fem;

            end if;
        end if;
    end process;


    with clock_cycle   select
 sig_cycle<= sig_pwm when '1',
        '0' when others;


end Behavioral;






