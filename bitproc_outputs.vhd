library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types_pkg.all;

entity bitproc_outputs is
port (
		clk : in std_logic;
		--clr : in std_logic;
		--en_reg : in std_logic;
		row : in integer range 0 to 323;
		a0 : in std_logic_vector(n-1 downto 0); 
		a1 : in std_logic_vector(n-1 downto 0);
		a2 : in std_logic_vector(n-1 downto 0);
		a3 : in std_logic_vector(n-1 downto 0);
		a4 : in std_logic_vector(n-1 downto 0);
		a5 : in std_logic_vector(n-1 downto 0);
		a6 : in std_logic_vector(n-1 downto 0);
		a7 : in std_logic_vector(n-1 downto 0);
		lambdas : out array3);		
end bitproc_outputs;

architecture Behavioral of bitproc_outputs is
begin
process(clk)
begin
	if (clk'event and clk='1')then
		lambdas(col_position(row, 0)) <= a0;
		lambdas(col_position(row, 1)) <= a1;
		lambdas(col_position(row, 2)) <= a2;
		lambdas(col_position(row, 3)) <= a3;
		lambdas(col_position(row, 4)) <= a4;
		lambdas(col_position(row, 5)) <= a5;
		lambdas(col_position(row, 6)) <= a6;
		lambdas(col_position(row, 7)) <= a7;
	end if;
end process;


end Behavioral;