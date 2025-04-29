----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2025 09:14:56 AM
-- Design Name: 
-- Module Name: bin2seg - Behavioral
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

entity bin2seg is
    Port ( clear : in STD_LOGIC;
           bin : in STD_LOGIC_VECTOR (3 downto 0);
           digit : in std_logic_vector (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           anodes : out STD_LOGIC_VECTOR (6 DOWNTO 0));
end bin2seg;


architecture Behavioral of bin2seg is

begin

-- This combinational process decodes binary input (`bin`) into 7-segment display output
-- (`seg`) for a Common Anode configuration. When either `bin` or `clear` changes, the
-- process is triggered. Each bit in `seg` represents a segment from A to G. The display
-- is cleared if input `clear` is set to 1.
    p_7seg_decoder : process (digit, clear) is
    begin
    
      if (clear = '1') then
        seg <= "1111111";  -- Clear the display
      else
        case digit is
            when x"0" =>
                anodes <= "01111111";
            when x"1" =>
                anodes <= "10111111";
            when x"2" =>
                anodes <= "11011111";
            when x"3" =>
                anodes <= "11101111";
            when x"4" =>
                anodes <= "11110111";
            when x"5" =>
                anodes <= "11111011";
            when others =>
                anodes <= "01111111";               
        end case;
        case bin is
          when x"0" =>     -- x"0" means "0000" in hexadecimal
            seg <= "0000001";
          when x"1" =>
            seg <= "1001111";
          when x"2" =>
            seg <= "0010010";
          when x"3" =>
            seg <= "0000110";
          when x"4" =>
            seg <= "1001100";
          when x"5" =>
            seg <= "0100100";
          when x"6" =>
            seg <= "0100000";
          when x"7" =>
            seg <= "0001111";
          when x"8" =>
            seg <= "0000000";
          when x"9" =>
            seg <= "0000100";
          when x"A" =>
            seg <= "0001000";
          when x"B" =>
            seg <= "1100000";
          when x"C" =>
            seg <= "0110001";
          when x"D" =>
            seg <= "1000010";
          when x"E" =>
            seg <= "0110000";
          when others =>
            seg <= "0111000";
        end case;
    
      end if;    
    end process p_7seg_decoder;


end Behavioral;
