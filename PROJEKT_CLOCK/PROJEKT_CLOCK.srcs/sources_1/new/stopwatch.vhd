library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity stopwatch is
    Port (
        clk          : in  STD_LOGIC;                        -- hlavn� hodiny (100 MHz)
        rst          : in  STD_LOGIC;                        -- glob�ln� reset (nepovinn�)
        sw2          : in  STD_LOGIC;                        -- switch 2 pro aktivaci re�imu
        btn_center   : in  STD_LOGIC;                        -- tla?�tko pro ovl�d�n� re�imu
        seg_display  : out STD_LOGIC_VECTOR(23 downto 0)     -- v�stup pro 6 ?�slic
    );
end stopwatch;

architecture Behavioral of stopwatch is

    signal one_hz_clk   : STD_LOGIC := '0';
    signal clk_divider  : INTEGER := 0;
    signal seconds      : INTEGER range 0 to 59 := 0;
    signal minutes      : INTEGER range 0 to 59 := 0;
    signal hours        : INTEGER range 0 to 99 := 0;

    signal btn_state    : INTEGER range 0 to 2 := 0;     -- 0 = ?ek�n�, 1 = b��, 2 = zastaveno
    signal running      : STD_LOGIC := '0';
    signal blinking     : STD_LOGIC := '0';
    signal btn_reg      : STD_LOGIC := '0';              -- pro zachycen� n�b�n� hrany tla?�tka

begin

    -- 1Hz gener�tor + blik�n�
    clk_div: process(clk)
    begin
        if rising_edge(clk) then
            if clk_divider >= 50000000 then
                clk_divider <= 0;
                one_hz_clk <= not one_hz_clk;
                blinking <= not blinking;
            else
                clk_divider <= clk_divider + 1;
            end if;
        end if;
    end process;

    -- ?�zen� re�imu pomoc� BTN_CENTER
    process(clk)
    variable local_seconds : INTEGER range 0 to 59 := seconds;   -- Local variable for seconds
    variable local_minutes : INTEGER range 0 to 59 := minutes;   -- Local variable for minutes
    variable local_hours   : INTEGER range 0 to 99 := hours;     -- Local variable for hours
    begin
        if rising_edge(clk) then
            if sw2 = '1' then
                if btn_center = '1' and btn_reg = '0' then  -- n�b�n� hrana tla?�tka
                    case btn_state is
                        when 0 =>
                            running <= '1';  -- spustit
                            btn_state <= 1;
                        when 1 =>
                            running <= '0';  -- zastavit
                            btn_state <= 2;
                        when 2 =>
                            -- reset do v�choz�ho re�imu
                            local_seconds := 0;
                            local_minutes := 0;
                            local_hours := 0;
                            btn_state <= 0;
                        when others =>
                            btn_state <= 0;
                    end case;
                end if;
                btn_reg <= btn_center;
            else
                -- Pokud SW2 = 0, resetujeme re�im
                running <= '0';
                local_seconds := 0;
                local_minutes := 0;
                local_hours := 0;
                btn_state <= 0;
                btn_reg <= '0';
            end if;

            -- Update the global time signals once per clock cycle
            if running = '1' then
                if one_hz_clk = '1' then
                    if local_seconds = 59 then
                        local_seconds := 0;
                        if local_minutes = 59 then
                            local_minutes := 0;
                            if local_hours = 99 then
                                local_hours := 0;
                            else
                                local_hours := local_hours + 1;
                            end if;
                        else
                            local_minutes := local_minutes + 1;
                        end if;
                    else
                        local_seconds := local_seconds + 1;
                    end if;
                end if;
            end if;

            -- Assign local variables back to the signals
            seconds <= local_seconds;
            minutes <= local_minutes;
            hours <= local_hours;
        end if;
    end process;

    -- V�stup na segmentovky - zobrazuje HHMMSS
    process(blinking, btn_state)
        variable total_time : INTEGER;
    begin
        if sw2 = '1' then
            if btn_state = 0 then
                if blinking = '1' then
                    seg_display <= (others => '1'); -- zhasnuto (blik�n�)
                else
                    seg_display <= x"000000"; -- nuly
                end if;
            else

            end if;
        else
            seg_display <= (others => '1'); -- switch vypnut�, zhasnout displej
        end if;
    end process;

end Behavioral;
