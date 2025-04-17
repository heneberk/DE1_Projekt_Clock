

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity alarm_output is
    Port (
        clk         : in  STD_LOGIC;
        alarm_match : in  STD_LOGIC;
        buzzer_out  : out STD_LOGIC;
        led_alarm   : out STD_LOGIC
    );
end alarm_output;

architecture Behavioral of alarm_output is
    signal blink : STD_LOGIC := '0';
    signal counter : INTEGER range 0 to 49999999 := 0; -- ~0.5s na 100MHz
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if alarm_match = '1' then
                if counter = 49999999 then
                    blink <= not blink;
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            else
                blink <= '0';
                counter <= 0;
            end if;
        end if;
    end process;

    buzzer_out <= blink;
    led_alarm <= blink;
end Behavioral;
