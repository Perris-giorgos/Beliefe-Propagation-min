----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:14:22 10/02/2016 
-- Design Name: 
-- Module Name:    lambda_update - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lambda_update is
    Port (clk : in std_LOGIC; 
			 c2bupdate : in  STD_LOGIC_vector(n-1 downto 0);
 --        varpos : in  STD_LOGIC_vector(2 downto 0);
--chkpos : in  STD_LOGIC_vector(2 downto 0);
			  pos_lambda: in integer;
			  lambda : in array3;
           c2bupdate : out  STD_LOGIC_vector(n-1 downto 0));
end lambda_update;

architecture Behavioral of lambda_update is
signal temp : STD_LOGIC_vector(n-1 downto 0);
begin
process(clk)
begin
	temp <= c2bupdate + lambda(pos_lambda);
end process;
lambda(pos_lambda) <= temp;

end Behavioral;