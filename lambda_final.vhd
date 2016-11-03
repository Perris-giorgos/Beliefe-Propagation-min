library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lambda_final1 is
port (clk : in std_logic;
			complete : in std_logic;
			lam : in std_logic_vector(n-1 downto 0);
			lambda : in std_logic_vector(n-1 downto 0);
			lambda_out : out std_logic_vector(n-1 downto 0) );
end lambda_final1;

architecture Behavioral of lambda_final1 is

begin
process(clk)
begin
if (clk'event and clk='1')then
	if complete = '1' then
		lambda_out <= std_logic_vector(signed(lambda) + signed(lam));
	end if;
end if;
end process;
end Behavioral;

