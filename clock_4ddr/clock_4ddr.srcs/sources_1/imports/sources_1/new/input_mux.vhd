----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 02:46:07 AM
-- Design Name: 
-- Module Name: input_mux - Behavioral
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

entity input_mux is
    Port ( btn_in : in STD_LOGIC_VECTOR (4 downto 0);
           btn_out_clock : out STD_LOGIC;
           btn_out_stw : out STD_LOGIC;
           state : out STD_LOGIC;
           clk : in STD_LOGIC;
           sw_state : in STD_LOGIC);
end input_mux;

architecture Behavioral of input_mux is

begin


end Behavioral;
