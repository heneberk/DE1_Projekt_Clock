


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity alarm_comparator is
    Port (
        current_hh  : in  STD_LOGIC_VECTOR(5 downto 0);
        current_mm  : in  STD_LOGIC_VECTOR(5 downto 0);
        alarm_hh    : in  STD_LOGIC_VECTOR(5 downto 0);
        alarm_mm    : in  STD_LOGIC_VECTOR(5 downto 0);
        alarm_on    : in  STD_LOGIC;
        alarm_match : out STD_LOGIC
    );
end alarm_comparator;

architecture Behavioral of alarm_comparator is
begin
    process(current_hh, current_mm, alarm_hh, alarm_mm, alarm_on)
    begin
        if alarm_on = '1' and current_hh = alarm_hh and current_mm = alarm_mm then
            alarm_match <= '1';
        else
            alarm_match <= '0';
        end if;
    end process;
end Behavioral;
