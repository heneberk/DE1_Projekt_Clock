----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2025 09:09:35 AM
-- Design Name: 
-- Module Name: simple_counter - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0));
end simple_counter;

architecture Behavioral of simple_counter is
    signal sig_count : std_logic_vector(3 downto 0);
begin
    process (clk)
        begin
        if rising_edge(clk) then
            if rst = '1' then
                sig_count <= b"0000";
                count <= (others => '0');
            elsif en = '1' then
                sig_count <= sig_count + 1;
                count <= sig_count;
            end if;
        end if;
    end process;
end Behavioral;
