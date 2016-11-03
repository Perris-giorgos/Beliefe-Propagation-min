library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity c2b_RAm_prep is
	port(clk : in std_logic;
			  ro : in integer range 0 to 323;
				c_2_b0 : in std_logic_vector(n-1 downto 0);
				c_2_b1 : in std_logic_vector(n-1 downto 0);
				c_2_b2 : in std_logic_vector(n-1 downto 0);
				c_2_b3 : in std_logic_vector(n-1 downto 0);
				c_2_b4 : in std_logic_vector(n-1 downto 0);
				c_2_b5 : in std_logic_vector(n-1 downto 0);
				c_2_b6 : in std_logic_vector(n-1 downto 0);
				c_2_b7 : in std_logic_vector(n-1 downto 0);
				reg_en : in std_logic;
				row_out : out std_logic_vector(8*n-1 downto 0));
end c2b_RAm_prep;

architecture Behavioral of c2b_RAm_prep is


begin
process(clk)
begin
if (clk'event and clk='1')then
	if row_weight(ro) = '1' then
		row_out <= c_2_b0 & c_2_b1 & c_2_b2 & c_2_b3 & c_2_b4 & c_2_b5 & c_2_b6 & c_2_b7;
	else
				row_out (8*n-1 downto n)<= c_2_b0 & c_2_b1 & c_2_b2 & c_2_b3 & c_2_b4 & c_2_b5 & c_2_b6;
				row_out(n-1 downto 0)<= (others =>'X');
	end if;

end if;
end process;

end Behavioral;