library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;


entity row_processor is
    Port (clk : in std_logic; 
			  row_LLR : in  STD_LOGIC_vector(8*n-1 downto 0);
			  ro : in integer range 0 to 323;
			  out_en: in std_logic;
			  clr : in std_logic;
			  LLRs : out array2 );
			  --LLRs_abs : out array2;
--			  rowweight : out std_logic);
end row_processor;

architecture row_proc of row_processor is
component registerN is
	port(d : in std_logic_vector(n-1 downto 0);
		  load : in std_logic;
		   clk : in std_logic;
			clr : in std_logic;
			q : out std_logic_vector(n-1 downto 0));
end component;
signal llrs0,llrs1,llrs2,llrs3,llrs4,llrs5,llrs6,llrs7 : std_logic_vector(n-1 downto 0);
begin

LLRs6 <= row_LLR(2*n-1 downto  n);
LLRs5 <= row_LLR(3*n-1 downto  2*n);
LLRs4 <= row_LLR(4*n-1 downto  3*n);
LLRs3 <= row_LLR(5*n-1 downto  4*n);
LLRs2 <= row_LLR(6*n-1 downto  5*n);
LLRs1 <= row_LLR(7*n-1 downto  6*n);
LLRs0 <= row_LLR(8*n-1 downto  7*n);
process(clk)
begin
if clk'event and clk = '1' then
case row_weight(ro) is
	when '1'=> LLRs7 <= row_LLR(n-1 downto  0);
							  --LLRs_abs(7) <= STD_LOGIC_vector(abs(signed(row_LLR(n-1 downto  0))));
	when others => LLRs7 <= "XXXXXX";
										--LLRs_abs(7) <= "XXXXXX";
end case;
end if;
end process;
	l0: registerN port map (d => llrs0, clk => clk, clr => clr, load =>out_en, q => llrs(0));
	l1: registerN port map (d => llrs1, clk => clk, clr => clr, load =>out_en, q => llrs(1));
	l2: registerN port map (d => llrs2, clk => clk, clr => clr, load =>out_en, q => llrs(2));
	l3: registerN port map (d => llrs3, clk => clk, clr => clr, load =>out_en, q => llrs(3));
	l4: registerN port map (d => llrs4, clk => clk, clr => clr, load =>out_en, q => llrs(4));
	l5: registerN port map (d => llrs5, clk => clk, clr => clr, load =>out_en, q => llrs(5));
	l6: registerN port map (d => llrs6, clk => clk, clr => clr, load =>out_en, q => llrs(6));
	l7: registerN port map (d => llrs7, clk => clk, clr => clr, load =>out_en, q => llrs(7));


end row_proc;