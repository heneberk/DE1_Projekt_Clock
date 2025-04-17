

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alarm_register is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        load_alarm  : in  STD_LOGIC; -- impuls pro na?tení hodnoty
        alarm_hh    : in  STD_LOGIC_VECTOR(5 downto 0);
        alarm_mm    : in  STD_LOGIC_VECTOR(5 downto 0);
        set_hh      : out STD_LOGIC_VECTOR(5 downto 0);
        set_mm      : out STD_LOGIC_VECTOR(5 downto 0)
    );
end alarm_register;

architecture Behavioral of alarm_register is
    signal reg_hh, reg_mm : STD_LOGIC_VECTOR(5 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg_hh <= (others => '0');
                reg_mm <= (others => '0');
            elsif load_alarm = '1' then
                reg_hh <= alarm_hh;
                reg_mm <= alarm_mm;
            end if;
        end if;
    end process;

    set_hh <= reg_hh;
    set_mm <= reg_mm;

end Behavioral;
