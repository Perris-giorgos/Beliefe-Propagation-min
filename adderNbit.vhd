----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:39:32 10/07/2016 
-- Design Name: 
-- Module Name:    adderNbit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adderNbit is
port(c2b : in std_logic_vector(n-1 downto 0);
		  old : in std_logic_vector(n-1 downto 0);
			neo : out std_logic_vector(n-1 downto 0)
			);
end adderNbit;

architecture Behavioral of adderNbit is
begin
neo <= std_logic_vector(signed(old) + signed(c2b));

end Behavioral;

