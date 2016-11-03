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
				col_no : in std_logic_vector(2 downto 0);
				c_2_b : in std_logic_vector(n-1 downto 0);
				complete_row : in std_logic;
				enable_write : out std_logic;
				row_out : out std_logic_vector(8*n-1 downto 0));
end c2b_RAm_prep;

architecture Behavioral of c2b_RAm_prep is
--component Check2BitRAM is
--port (clk : in std_logic;
			--we : in std_logic;
			--en :  in std_logic;
			--addr : in integer range 0 to 323;
		--	di : in std_logic_vector(8*n downto 0);
	--		do : out std_logic_vector(8*n downto 0));
--end component;
--signal ubound, lbound : integer;
signal c_2_b_temp : array2;

begin
c_2_b_temp(to_integer(unsigned(col_no))) <= c_2_b;
process(clk)
begin
if (clk'event and clk='1')then
	if row_weight(ro) = '1' then
		row_out <= c_2_b_temp(0)&c_2_b_temp(1)&c_2_b_temp(2)&c_2_b_temp(3)&c_2_b_temp(4)&c_2_b_temp(5)&c_2_b_temp(6)&c_2_b_temp(7);
	else
				row_out (8*n-1 downto n)<= c_2_b_temp(0)&c_2_b_temp(1)&c_2_b_temp(2)&c_2_b_temp(3)&c_2_b_temp(4)&c_2_b_temp(5)&c_2_b_temp(6);
				row_out(n-1 downto 0)<= (others =>'X');
	end if;
	 if complete_row = '1' then
		enable_write <= '1';
	 elsif complete_row = '0' then
		enable_write <= '0';
	 end if;
	--((n-1 downto  0) => c_2_b_temp(7),
	--							(2*n-1 downto  n) => c_2_b_temp(6),
		--						(3*n-1 downto  2*n) => c_2_b_temp(5),
			--					(4*n-1 downto  3*n) => c_2_b_temp(4),
				--				(5*n-1 downto  4*n) => c_2_b_temp(3),
					--			(6*n-1 downto  5*n) => c_2_b_temp(2),
						--		(7*n-1 downto  6*n) => c_2_b_temp(1),
							--	(8*n-1 downto  7*n) => c_2_b_temp(0)
								--8*n => r_weight);
end if;
end process;
end Behavioral;