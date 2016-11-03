library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BitNodeUpdate is
	Port(c2bit : in std_logic_vector(n-1 downto 0);
				lambda : in array3;
				lam : in array3;
				clk : in std_logic;
				clr : in std_logic;
				row : in integer range 0 to 323;
				col : in std_logic_vector(2 downto 0);
				complete : in std_logic;
				lambda_out : out std_logic_vector(n-1 downto 0));
end BitNodeUpdate;

architecture Behavioral of BitNodeUpdate is
--component registerN
--	port( d : in std_logic_vector(n-1 downto 0);
--				clk : in std_logic;
--				clr : in std_logic;
--				q : out std_logic_vector(n-1 downto 0));
--end component;
component adderNbit
	port(c2b : in std_logic_vector(n-1 downto 0);
	  old : in std_logic_vector(n-1 downto 0);
		neo : out std_logic_vector(n-1 downto 0)
		);
end component;
signal current_lambda : std_logic_vector(n-1 downto 0);
signal previous_lambda : std_logic_vector(n-1 downto 0);
signal index : integer range 0 to 323;
signal indexed : std_logic_vector(n-1 downto 0);
begin 
--index <= col_position(row, to_integer(unsigned(col)));
indexed <= lambda(col_position(row, to_integer(unsigned(col))));
--A : registerN port map(current_lambda, clk, clr, previous_lambda);
B : adderNbit port map(c2bit, indexed, current_lambda); 
--process(clk)
--begin
--if (clk'event and clk='1')then
--	if complete = '1' then
--		lambda_out <= std_logic_vector(signed(current_lambda) + signed(lam(index)));
--	elsif complete='0' then
--		lambda_out <= current_lambda;
--	end if;
--	if clr = '1' then
--		lambda_out <= (others => '0');
--	end if;
--end if;
--end process;
lambda_out <= current_lambda;

end Behavioral;