-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 23 Apr 2025 10:48:08 GMT
-- Request id : cfwk-fed377c2-6808c56876d14

library ieee;
use ieee.std_logic_1164.all;

entity tb_clock is
end tb_clock;

architecture tb of tb_clock is

    component clock
        port (clk       : in std_logic;
              clk_1hz   : in std_logic;
              rst       : in std_logic;
              set_sw    : in std_logic;
              btn_right : in std_logic;
              btn_left  : in std_logic;
              btn_up    : in std_logic;
              btn_down  : in std_logic;
              seconds   : out std_logic_vector (5 downto 0);
              minutes   : out std_logic_vector (5 downto 0);
              hours     : out std_logic_vector (4 downto 0));
    end component;

    signal clk       : std_logic;
    signal clk_1hz   : std_logic;
    signal rst       : std_logic;
    signal set_sw    : std_logic;
    signal btn_right : std_logic;
    signal btn_left  : std_logic;
    signal btn_up    : std_logic;
    signal btn_down  : std_logic;
    signal seconds   : std_logic_vector (5 downto 0);
    signal minutes   : std_logic_vector (5 downto 0);
    signal hours     : std_logic_vector (4 downto 0);

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : clock
    port map (clk       => clk,
              clk_1hz   => clk_1hz,
              rst       => rst,
              set_sw    => set_sw,
              btn_right => btn_right,
              btn_left  => btn_left,
              btn_up    => btn_up,
              btn_down  => btn_down,
              seconds   => seconds,
              minutes   => minutes,
              hours     => hours);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        clk_1hz <= '0';
        set_sw <= '0';
        btn_right <= '0';
        btn_left <= '0';
        btn_up <= '0';
        btn_down <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_clock of tb_clock is
    for tb
    end for;
end cfg_tb_clock;