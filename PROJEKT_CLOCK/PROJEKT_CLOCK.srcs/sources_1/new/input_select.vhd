----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 11:17:48 PM
-- Design Name: 
-- Module Name: input_select - Behavioral
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

entity input_select is
    Port ( clk : in STD_LOGIC;
           sw_set : in STD_LOGIC;
           btn_up : in STD_LOGIC;
           btn_down : in STD_LOGIC;
           btn_left : in STD_LOGIC;
           btn_right : in STD_LOGIC;
           btn_center : in STD_LOGIC;
           clock_set : out STD_LOGIC;
           clock_down : out STD_LOGIC;
           clock_up : out STD_LOGIC;
           clock_left : out STD_LOGIC;
           clock_right : out STD_LOGIC;
           stpw_center : out STD_LOGIC;
           stpw_up : out STD_LOGIC;
           alarm_up : out STD_LOGIC;
           alarm_down : out STD_LOGIC;
           alarm_left : out STD_LOGIC;
           alarm_right : out STD_LOGIC;
           alarm_set : out STD_LOGIC);
end input_select;

architecture Behavioral of input_select is
    type state_type is (CLOCK, ALARM, STPW);
    signal state : state_type := CLOCK;

begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            case state is
                when CLOCK =>
                    clock_up <= btn_up;
                    clock_down <= btn_down;
                    clock_left <= btn_left;
                    clock_right <= btn_right;
                    clock_sw <= set_sw;
                when others =>
                    state <= CLOCK;
            end case;
        end if;
    end process;
end Behavioral;
