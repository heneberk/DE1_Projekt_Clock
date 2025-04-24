----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2025 02:17:31 AM
-- Design Name: 
-- Module Name: clock - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock is
    Port (
           clk : in STD_LOGIC;
           clk_1hz : in STD_LOGIC;
           rst : in STD_LOGIC;
           sw_set : in std_logic;
           btn_right : in std_logic;
           btn_left : in std_logic;
           btn_up : in std_logic;
           btn_down : in std_logic;
           seconds : out std_logic_vector (5 downto 0);
           minutes : out std_logic_vector (5 downto 0);
           hours : out std_logic_vector (4 downto 0)
     );
end clock;

architecture Behavioral of clock is
    type state_type is (DISP, SET);
    signal state : state_type := DISP;
    signal digit : integer range -1 to 3 ;
    
    signal seconds_n : integer range -1 to 60 := 58;
    signal minutes_n : integer range -1 to 60 := 58;
    signal hours_n : integer range -1 to 24 := 23;
    
    signal clk_1hz_rising : std_logic := '0';
begin
    process (clk)
    begin
        if rising_edge(clk) then
            clk_1hz_rising <= clk_1hz;
            
            case state is
                when DISP =>
                    if (sw_set = '1') then
                        state <= SET;
                    elsif (clk_1hz = '1' and clk_1hz_rising = '0') then
                        seconds_n <= seconds_n + 1;

                        if (seconds_n = 59) then
                            seconds_n <= 0;
                            minutes_n <= minutes_n + 1;
                        end if;
                        if (minutes_n = 59 and seconds_n = 59) then
                            minutes_n <= 0;
                            hours_n <= hours_n + 1;
                        end if;
                        if (hours_n = 23 and minutes_n = 59 and seconds_n = 59) then
                            hours_n <= 0;
                        end if;
                    end if;        
                when SET =>
                    if (sw_set = '0') then
                        state <= DISP;
                    elsif (btn_right = '1') then
                        digit <= digit + 1;
                    elsif (btn_left = '1') then
                        digit <= digit - 1;
                    elsif (btn_up = '1') then
                        case digit is
                            when 0 =>
                                seconds_n <= seconds_n + 1;
                            when 1 =>
                                minutes_n <= minutes_n + 1;
                            when 2 =>
                                hours_n <= hours_n + 1;
                            when others =>
                                digit <= 0;
                        end case; 
                    elsif (btn_down = '1') then
                        case digit is
                            when 0 =>
                                seconds_n <= seconds_n - 1;
                            when 1 =>
                                minutes_n <= minutes_n - 1;
                            when 2 =>
                                hours_n <= hours_n - 1;
                            when others =>
                                digit <= 0;
                        end case;               
                    end if;

                    -- overflow mitigation
                    if (seconds_n > 59) then
                        seconds_n <= 0;
                    elsif (seconds_n < 0) then
                        seconds_n <= 59;
                    end if;
                    
                    if (minutes_n > 59) then
                        minutes_n <= 0;
                    elsif (minutes_n < 0) then
                        minutes_n <= 59;
                    end if;
                    
                    if (hours_n > 23) then
                        hours_n <= 0;
                    elsif (hours_n < 0) then
                        hours_n <= 23;
                    end if;
                    
                    if (digit > 2) then
                        digit <= 0;
                    elsif (digit < 0) then
                        digit <= 2;
                    end if; 

                when others =>
                    state <= DISP;
            end case;
        end if;
    end process;
       
    
    seconds <= std_logic_vector(to_unsigned(seconds_n, seconds'length));
    minutes <= std_logic_vector(to_unsigned(minutes_n, minutes'length));
    hours <= std_logic_vector(to_unsigned(hours_n, hours'length));
end Behavioral;
