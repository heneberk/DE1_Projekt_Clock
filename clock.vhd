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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock is
    Port (
           clk : in STD_LOGIC;
           clk_1hz : in STD_LOGIC;
           set_sw : in std_logic;
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
    type state_type is (INIT, SET, DISP);
    signal state : state_type := INIT;
    signal digit : integer range -1 to 3 := 0;
   
    signal seconds_n : integer range -1 to 60 := 0;
    signal minutes_n : integer range -1 to 60 := 0;
    signal hours_n : integer range -1 to 24 := 0;
begin
    process (clk, rst)
    begin
        if rising_edge(clk) then
			if (rst = '1') then              
				seconds_n <= 0;
				minutes_n <= 0;
				hours_n <= 0;
				digit <= 0;
		
				state <= DISP;
			end if;
			
            case state is
                when DISP =>
                    if (set_sw = '1') then
                        state <= SET;
                    end if;  
                when SET =>
                    if (set_sw = '1') then
                        state <= DISP;
                    elsif () then
                    end if;
                when others =>
                    state <= DISP;
            end case;
        end if;
    end process;
    
    process (clk_1hz)
    begin
        if state = DISP then
            seconds_n <= seconds_n + 1;
            if seconds_n = 60 then
                seconds_n <= 0;
                minutes_n <= minutes_n + 1;
            end if;
            if minutes_n = 60 then
                minutes_n <= 0;
                hours_n <= hours_n + 1;
            end if;
            if hours_n = 24 then
                hours_n <= 0;
            end if;
        end if;
    end process;
end Behavioral;
