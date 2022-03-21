----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2022 03:24:54 PM
-- Design Name: 
-- Module Name: test_bench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench is
--  Port ( clock_basys3 out: std_logic :='0';
--         clock_1mhz_simu : std_logic :='0';
--         clock_adc_real : std_logic :='0'; );

end test_bench;




architecture Behavioral of test_bench is

component source_file
   Port ( 
         sys_clk_pin: in std_logic;
         
         PWM_PIN : out std_logic ;
         --Les BP---
         btnU : in std_logic;
         btnD : in std_logic;
         
--         cs_n : out std_logic;
--         DIN  : out  std_logic;
--         DOUT : in std_logic;
          sclk : out std_logic

      );
end component;

signal clock_basys3 : std_logic :='0';
signal clock_100mhz_simu : std_logic :='0';
signal clock_adc_real : std_logic;
signal cs_n_simu : std_logic ;
signal DIN_simu : std_logic;
signal DOUT_simu : std_logic :='0';
signal simu_pwm : std_logic :='0';
signal sclk_pwm : std_logic :='0';
signal btUp : std_logic :='0';
signal btdown : std_logic :='0';




begin

main_map : source_file port map(clock_100mhz_simu,simu_pwm,btUp,btdown,sclk_pwm );


horloge_adc : process 

begin
    wait for 5 ns;
    clock_100mhz_simu<= not clock_100mhz_simu;
end process;


end Behavioral;
