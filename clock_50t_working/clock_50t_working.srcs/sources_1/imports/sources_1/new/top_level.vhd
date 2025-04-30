----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2025 10:04:25 AM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           SW_SET : in STD_LOGIC );
end top_level;

architecture Behavioral of top_level is
    component debounce is
        generic (
            DB_TIME : time := 25 ms
        );
        port (
            clk     : in    std_logic;
            btn_in  : in    std_logic; -- Asynchronous and noisy input
            btn_out : out   std_logic; -- Synchronised, debounced and filtered output
            edge    : out   std_logic;
            rise    : out   std_logic;
            fall    : out   std_logic
        );
    end component;

    component clk_1hz is
        Generic (
            COUNTTO : integer
        );
        Port ( clk_in : in STD_LOGIC;
               clk_out : out STD_LOGIC;
               rst : in std_logic);
    end component;
    
    component clock is
        Port (
               clk : in STD_LOGIC;
               clk_1hz : in STD_LOGIC;
               rst : in STD_LOGIC;
               sw_set : in std_logic;
               btn_right : in std_logic;
               btn_left : in std_logic;
               btn_up : in std_logic;
               btn_down : in std_logic;
               seconds : out std_logic_vector (3 downto 0);
               seconds_ten : out std_logic_vector (3 downto 0);
               minutes : out std_logic_vector (3 downto 0);
               minutes_ten : out std_logic_vector (3 downto 0);
               hours : out std_logic_vector (3 downto 0);
               hours_ten : out std_logic_vector (3 downto 0)
               
         );
    end component;
    
    component simple_counter is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               en : in STD_LOGIC;
               count : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component bin2seg is
        Port ( clear : in STD_LOGIC;
            seconds : in std_logic_vector (3 downto 0);
            seconds_ten : in std_logic_vector (3 downto 0);
            minutes : in std_logic_vector (3 downto 0);
            minutes_ten : in std_logic_vector (3 downto 0);
            hours : in std_logic_vector (3 downto 0);
            hours_ten : in std_logic_vector (3 downto 0);
            digit : in std_logic_vector (3 downto 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0);
            anodes : out STD_LOGIC_VECTOR (7 DOWNTO 0);
            reset_counter : out std_logic);
    end component;

    signal sig_clk : std_logic;
    signal sig_clk_1hz : std_logic;
    signal sig_clk_1khz : std_logic;

    signal sig_seconds : std_logic_vector (3 downto 0);
    signal sig_seconds_ten : std_logic_vector (3 downto 0);
    signal sig_minutes : std_logic_vector (3 downto 0);
    signal sig_minutes_ten : std_logic_vector (3 downto 0);
    signal sig_hours : std_logic_vector (3 downto 0);
    signal sig_hours_ten : std_logic_vector (3 downto 0);

    signal sig_digit : std_logic_vector (3 downto 0);
    signal sig_reset_counter : std_logic;
    
    signal btn_up_d : std_logic;
    signal btn_down_d : std_logic;
    signal btn_left_d : std_logic;
    signal btn_right_d : std_logic;
    signal btn_center_d : std_logic;
    
begin
    c_clock : clock
        port map (
            clk => sig_clk,
            clk_1hz => sig_clk_1hz,
            seconds => sig_seconds,
            seconds_ten => sig_seconds_ten,
            minutes => sig_minutes,
            minutes_ten => sig_minutes_ten,
            hours => sig_hours,
            hours_ten => sig_hours_ten,

            sw_set => SW_SET,
            rst => btn_center_d,
            btn_up => btn_up_d,
            btn_down => btn_down_d,
            btn_left => btn_left_d,
            btn_right => btn_right_d
        
        );


    display : bin2seg
        port map (
            clear => btn_center_d,
            seconds => sig_seconds,
            seconds_ten => sig_seconds_ten,
            minutes => sig_minutes,
            minutes_ten => sig_minutes_ten,
            hours => sig_hours,
            hours_ten => sig_hours_ten,
            digit => sig_digit, 
            seg(6) => CA,
            seg(5) => CB,
            seg(4) => CC,
            seg(3) => CD,
            seg(2) => CE,
            seg(1) => CF,
            seg(0) => CG,
            anodes => AN,
            reset_counter => sig_reset_counter
        );
    c_btn_up : debounce
        port map (
            clk => CLK100MHZ,
            btn_in => BTNU,
            btn_out => btn_up_d
        );

    c_btn_down : debounce
        port map (
            clk => CLK100MHZ,
            btn_in => BTND,
            btn_out => btn_down_d
        );

    c_btn_left : debounce
        port map (
            clk => CLK100MHZ,
            btn_in => BTNL,
            btn_out => btn_left_d          
        );
    
    c_btn_right : debounce
        port map (
            clk => CLK100MHZ,
            btn_in => BTNR,
            btn_out => btn_right_d          
        );
    
    c_btn_center : debounce
        port map (
            clk => CLK100MHZ,
            btn_in => BTNC,
            btn_out => btn_center_d          
        );
    
    c_clock_1hz : clk_1hz
        generic map (
            COUNTTO => 50000000
        )
        port map (
            clk_in => CLK100MHZ,
            clk_out => sig_clk_1hz,
            rst => btn_center_d
        );
    
    c_clock_1khz : clk_1hz
        generic map (
            COUNTTO => 50000
        )
        port map (
            clk_in => CLK100MHZ,
            clk_out => sig_clk_1khz,
            rst => btn_center_d
        );
        
    counter : simple_counter
        port map (
            clk => sig_clk_1khz,
            rst => sig_reset_counter,
            en => '1',
            count => sig_digit
        );
     DP <= '1';
     sig_clk <= CLK100MHZ;
end Behavioral;
