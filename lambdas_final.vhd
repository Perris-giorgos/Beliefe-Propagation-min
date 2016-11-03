library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;


entity lambdas_final is
		port (clk : in std_logic;
				regen : in std_logic;
				lam : in array3;
				lambda : in array3;
				lambdasfinal : out array3
				);
end lambdas_final;

architecture Behavioral of lambdas_final is
component lambda_final1 is
port (clk : in std_logic;
			reg_en : in std_logic;
			lam : in std_logic_vector(n-1 downto 0);
			lambda : in std_logic_vector(n-1 downto 0);
			lambda_out : out std_logic_vector(n-1 downto 0) );
end component;
begin
gen : for i in 0 to 647 generate 
	new_soft_codeword : lambda_final1 port map (clk => clk, reg_en => regen, lambda =>lambda(I), lam => lam(I) , lambda_out =>lambdasfinal (I));
end generate gen;

end Behavioral;

