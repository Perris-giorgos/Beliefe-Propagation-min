--7 comparators 3 stages network

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity minimum_7comp is
port (LLR : in array2;
		clk : in std_logic;
		clr : in std_logic;
		en_reg : in std_logic;
		min_1 : out  STD_LOGIC_vector(n-1 downto 0);
      min_2 : out  STD_LOGIC_vector(n-1 downto 0);
		min_3 : out  STD_LOGIC_vector(n-1 downto 0);
		min_1pos : out std_logic_vector(2 downto 0);
		min_2pos : out std_logic_vector(2 downto 0);
		min_3pos : out std_logic_vector(2 downto 0));
end minimum_7comp;

architecture Behavioral of minimum_7comp is

component Comparator is
    Port (
			  LLR1 : in  STD_LOGIC_vector(n-1 downto 0);
           LLR2 : in  STD_LOGIC_vector(n-1 downto 0);
			  pos1 : in std_logic_vector(2 downto 0);
			  pos2 : in std_logic_vector(2 downto 0);
           mium : out  STD_LOGIC_vector(n-1 downto 0);
           maxi : out  STD_LOGIC_vector(n-1 downto 0);
			  minpos : out std_logic_vector(2 downto 0);
			  min_2pos : out std_logic_vector(2 downto 0));
end component;
component comparator_min_only is
    Port ( 
			  LLR1 : in  STD_LOGIC_vector(n-1 downto 0);
           LLR2 : in  STD_LOGIC_vector(n-1 downto 0);
			  pos1 : in std_logic_vector(2 downto 0);
			  pos2 : in std_logic_vector(2 downto 0);
           mium : out  STD_LOGIC_vector(n-1 downto 0);
			  minpos : out std_logic_vector(2 downto 0));
end component;
component registerN is
	port(d : in std_logic_vector(n-1 downto 0);
			load : in std_logic;
				clk : in std_logic;
				clr : in std_logic;
				q : out std_logic_vector(n-1 downto 0));
end component;
component register3bit is
	port(d : in std_logic_vector(2 downto 0);
		  load : in std_logic;
		   clk : in std_logic;
			clr : in std_logic;
			q : out std_logic_vector(2 downto 0));
end component;
signal  r0, r1, r2, r3, r4, r5 ,r6, r7 : std_logic_vector(n-1 downto 0);
signal min1,min2,min3,min4,min5,min6,min7 : std_logic_vector(n-1 downto 0);
signal minpos1, minpos2, minpos3,minpos4, minpos5, minpos6,minpos7, maxpos1, maxpos2 : std_logic_vector(2 downto 0);
signal max1, max2 : std_logic_vector(n-1 downto 0);

begin
r0 <= std_logic_vector(abs(signed(LLr(0))));
r1 <= std_logic_vector(abs(signed(LLr(1))));
r2 <= std_logic_vector(abs(signed(LLr(2))));
r3 <= std_logic_vector(abs(signed(LLr(3))));
r4 <= std_logic_vector(abs(signed(LLr(4))));
r5 <= std_logic_vector(abs(signed(LLr(5))));
r6 <= std_logic_vector(abs(signed(LLr(6))));
r7 <= std_logic_vector(abs(signed(LLr(7))));

--stage one
c1 : comparator_min_only port map (llr1 => r0, llr2 => r1, pos1 => "000", pos2 => "001", mium =>min1, minpos => minpos1);
c2 : comparator_min_only port map (llr1 => r2, llr2 => r3, pos1 => "010", pos2 => "011", mium =>min2, minpos => minpos2);
c3 : comparator_min_only port map (llr1 => r4, llr2 => r5, pos1 => "100", pos2 => "101", mium =>min3, minpos => minpos3);
c4 : comparator_min_only port map (llr1 => r6, llr2 => r7, pos1 => "110", pos2 => "111", mium =>min4, minpos => minpos4);
--stage two
c5 : comparator port map (llr1 => min1, llr2 => min2, pos1 => minpos1, pos2 => minpos2, mium => min5, maxi => max1, minpos => minpos5, min_2pos => maxpos1);
c6 : comparator port map (llr1 => min3, llr2 => min4, pos1 => minpos3, pos2 => minpos4, mium => min6, maxi => max2, minpos => minpos6, min_2pos => maxpos2);
--stage three
c7 : comparator_min_only port map (llr1 => max1, llr2 => max2, pos1 => maxpos1, pos2 => maxpos2, mium => min7, minpos => minpos7);

re1 : registerN port map (d => min5, load => en_reg, clk => clk, clr => clr , q => min_1);
re2 : registerN port map (d => min6, load => en_reg, clk => clk, clr => clr , q => min_2);
re3 : registerN port map (d => min7, load => en_reg, clk => clk, clr => clr , q => min_3);

re4 : register3bit port map (d => minpos5, load => en_reg, clk => clk, clr => clr , q => min_1pos);
re5 : register3bit port map (d => minpos6, load => en_reg, clk => clk, clr => clr , q => min_2pos);
re6 : register3bit port map (d => minpos7, load => en_reg, clk => clk, clr => clr , q => min_3pos);

end Behavioral;