library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Add_lambda is
    Port (clk : in std_logic;
			  clr :in std_logic;
			  ro : in integer range 0 to 323;
			  LLRs : in array2 ;
			  lambda : in array3;
			  lam : in array3;
			  first : in std_logic;
			  load : in std_logic;
			  B2C : out array2);
end Add_lambda;


architecture Behavioral of Add_lambda is
component registerN is
	port(d : in std_logic_vector(n-1 downto 0);
		  load : in std_logic;
		   clk : in std_logic;
			clr : in std_logic;
			q : out std_logic_vector(n-1 downto 0));
end component;

signal b2c0,b2c1,b2c2,b2c3,b2c4,b2c5,b2c6,b2c7 : std_logic_vector(n-1 downto 0);
begin
process(clk) 
begin
if clk'event and clk = '1' then
	if first = '0' then
		B2C0 <= std_logic_vector(signed(lambda(col_position(ro,0))) - signed(LLRs(0)));
		B2C1 <= std_logic_vector(signed(lambda(col_position(ro,1))) - signed(LLRs(1)));
		B2C2 <= std_logic_vector(signed(lambda(col_position(ro,2))) - signed(LLRs(2)));
		B2C3<= std_logic_vector(signed(lambda(col_position(ro,3))) - signed(LLRs(3)));
		B2C4<= std_logic_vector(signed(lambda(col_position(ro,4))) - signed(LLRs(4)));
		B2C5 <= std_logic_vector(signed(lambda(col_position(ro,5))) - signed(LLRs(5)));
		B2C6 <= std_logic_vector(signed(lambda(col_position(ro,6))) - signed(LLRs(6)));
			case row_weight(ro) is
				when '1'=> 	B2C7 <= std_logic_vector(signed(lambda(col_position(ro,7))) - signed(LLRs(7)));
				when others => B2C7 <= "XXXXXX";
			end case;
	elsif first='1' then
		B2C0 <= std_logic_vector(signed(lam(col_position(ro,0))) - signed(LLRs(0)));
		B2C1 <= std_logic_vector(signed(lam(col_position(ro,1))) - signed(LLRs(1)));
		B2C2 <= std_logic_vector(signed(lam(col_position(ro,2))) - signed(LLRs(2)));
		B2C3 <= std_logic_vector(signed(lam(col_position(ro,3))) - signed(LLRs(3)));
		B2C4 <= std_logic_vector(signed(lam(col_position(ro,4))) - signed(LLRs(4)));
		B2C5 <= std_logic_vector(signed(lam(col_position(ro,5))) - signed(LLRs(5)));
		B2C6 <= std_logic_vector(signed(lam(col_position(ro,6))) - signed(LLRs(6)));
			case row_weight(ro) is
				when '1'=> 	B2C7 <= std_logic_vector(signed(lam(col_position(ro,7))) - signed(LLRs(7)));
				when others => B2C7 <= "XXXXXX";
			end case;	
	end if;
end if;
end process;
	b0: registerN port map (d => b2c0, clk => clk, clr => clr, load =>load, q => b2c(0));
	b1: registerN port map (d => b2c1, clk => clk, clr => clr, load =>load, q => b2c(1));
	b2: registerN port map (d => b2c2, clk => clk, clr => clr, load =>load, q => b2c(2));
	b3: registerN port map (d => b2c3, clk => clk, clr => clr, load =>load, q => b2c(3));
	b4: registerN port map (d => b2c4, clk => clk, clr => clr, load =>load, q => b2c(4));
	b5: registerN port map (d => b2c5, clk => clk, clr => clr, load =>load, q => b2c(5));
	b6: registerN port map (d => b2c6, clk => clk, clr => clr, load =>load, q => b2c(6));
	b7: registerN port map (d => b2c7, clk => clk, clr => clr, load =>load, q => b2c(7));
	
end Behavioral;