----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2025 01:21:14 AM
-- Design Name: 
-- Module Name: clk_1hz - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_1hz is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC;
           rst : in std_logic);
end clk_1hz;

architecture Behavioral of clk_1hz is
    signal counter: integer := 0;
    signal state: std_logic := '0';
begin
    process (clk_in)
    begin
        if (rst='1') then
            counter <= 0;
            state <= '0';
        elsif rising_edge(clk_in) then
            counter <= counter + 1;
        end if;
        if (counter = 50000000) then
            counter <= 0;
            state <= not state;
        end if;     
    clk_out <= state;
    end process;


end Behavioral;
