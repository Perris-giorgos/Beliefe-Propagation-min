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
		clr : in std_logic;
			reg_en : in std_logic;
			lam : in std_logic_vector(n-1 downto 0);
			lambda : in std_logic_vector(n-1 downto 0);
			lambda_out : out std_logic_vector(n-1 downto 0) );
end lambda_final1;

architecture Behavioral of lambda_final1 is
component registerN is
	port(d : in std_logic_vector(n-1 downto 0);
		  load : in std_logic;
		   clk : in std_logic;
			clr : in std_logic;
			q : out std_logic_vector(n-1 downto 0));
end component;
signal lambda_out1 : std_logic_vector(n-1 downto 0);
begin
	lambda_out1 <= std_logic_vector(signed(lambda) + signed(lam));
	out1: registerN port map (d => lambda_out1, clk => clk, clr => clr, load =>reg_en, q => lambda_out);

end Behavioral;

