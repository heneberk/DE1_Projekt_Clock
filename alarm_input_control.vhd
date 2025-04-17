library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alarm_input_control is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        btn_enter   : in  STD_LOGIC;
        btn_up      : in  STD_LOGIC;
        btn_down    : in  STD_LOGIC;
        sw_select   : in  STD_LOGIC; -- SW14: 0=minuty, 1=hodiny
        alarm_on_sw : in  STD_LOGIC; -- SW15: zapnutí alarmu /jestli zazvoni nebo nezazvoni kdyz prijde nastaveny cas/
        alarm_hh_reg : out STD_LOGIC_VECTOR(5 downto 0);
        alarm_mm_reg : out STD_LOGIC_VECTOR(5 downto 0);
        alarm_active : out STD_LOGIC -- výstupní indikace
    );
end alarm_input_control;

architecture Behavioral of alarm_input_control is

    signal temp_value     : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal btn_enter_prev : STD_LOGIC := '0';
    signal btn_up_prev    : STD_LOGIC := '0';
    signal btn_down_prev  : STD_LOGIC := '0';

    signal reg_hh         : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal reg_mm         : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                temp_value <= (others => '0');
                reg_hh <= (others => '0');
                reg_mm <= (others => '0');
            else
                -- tla?ítko nahoru (BTNU)
                if btn_up = '1' and btn_up_prev = '0' then
                    if temp_value < 59 then
                        temp_value <= temp_value + 1;
                    end if;
                end if;

                -- tla?ítko dol? (BTND)
                if btn_down = '1' and btn_down_prev = '0' then
                    if temp_value > 0 then
                        temp_value <= temp_value - 1;
                    end if;
                end if;

                -- tla?ítko Enter (BTNC)
                if btn_enter = '1' and btn_enter_prev = '0' then
                    if sw_select = '1' then
                        reg_hh <= temp_value;
                    else
                        reg_mm <= temp_value;
                    end if;
                end if;

                -- aktualizace historie tla?ítek
                btn_up_prev <= btn_up;
                btn_down_prev <= btn_down;
                btn_enter_prev <= btn_enter;
            end if;
        end if;
    end process;

    -- Výstupy
    alarm_hh_reg <= reg_hh;
    alarm_mm_reg <= reg_mm;
    alarm_active <= alarm_on_sw;

end Behavioral;

