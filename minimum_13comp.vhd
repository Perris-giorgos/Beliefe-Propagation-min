--7 comparators 3 stages network

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity minimum_13comp is
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
end minimum_13comp;

architecture Behavioral of minimum_13comp is
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
signal min1,min2,min3,min4,min5,min6 : std_logic_vector(n-1 downto 0);
signal max1,max2,max4,max5,max6,max7,max8,max9 : std_logic_vector(n-1 downto 0);
signal mini1,mini2,mini3 : std_logic_vector(n-1 downto 0);
signal maxpos1,maxpos2,maxpos6,maxpos4,maxpos5,maxpos7,maxpos8,maxpos9 : std_logic_vector(2 downto 0);
signal minpos1,minpos2,minpos3,minpos4,minpos5,minpos6 : std_logic_vector(2 downto 0);
signal minposi1,minposi2,minposi3 : std_logic_vector(2 downto 0);
signal min1_1,min1_2,min2_1,min2_2 : std_logic_vector(n-1 downto 0);
signal minpos1_1,minpos1_2, minpos2_1,minpos2_2: std_logic_vector(2 downto 0);
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
c1 : comparator port map (llr1 => r0, llr2 => r1, pos1 => "000", pos2 => "001", mium => min1, maxi => max1, minpos => minpos1, min_2pos => maxpos1);
c2 : comparator port map (llr1 => r4, llr2 => r5, pos1 => "100", pos2 => "101", mium => min4, maxi => max4, minpos => minpos4, min_2pos => maxpos4);

--stage two 
c3 : comparator port map (llr1 => r2, llr2 => max1, pos1 => "010", pos2 => maxpos1, mium => min2, maxi => max2, minpos => minpos2, min_2pos => maxpos2);
c4 : comparator port map (llr1 => r6, llr2 => max4, pos1 => "110", pos2 => minpos4, mium => min5, maxi => max5, minpos => minpos5, min_2pos => maxpos5);

--stage three
c5 : comparator port map (llr1 => min1, llr2 => min2, pos1 => minpos1, pos2 => minpos2, mium => min1_1, maxi => max6, minpos => minpos1_1, min_2pos => maxpos6);
c6 : comparator_min_only port map (llr1 => r3, llr2 => max2, pos1 => "011", pos2 => maxpos2, mium =>min3, minpos => minpos3);

c7 : comparator port map (llr1 => min4, llr2 => min5, pos1 => minpos4, pos2 => minpos5, mium => min2_1, maxi => max7, minpos => minpos2_1, min_2pos => maxpos7);
c8 : comparator_min_only port map (llr1 => r7, llr2 => max5, pos1 => "111", pos2 => maxpos5, mium =>min6, minpos => minpos6);

--stage four
c9 : comparator_min_only port map (llr1 => max6, llr2 => min3, pos1 => maxpos6, pos2 => minpos3, mium =>min1_2, minpos => minpos1_2);
c10 : comparator_min_only port map (llr1 => max7, llr2 => min6, pos1 => maxpos7, pos2 => minpos6, mium =>min2_2, minpos => minpos2_2);

-- stage five
c11 : comparator port map (llr1 => min1_1, llr2 => min1_2, pos1 => minpos1_1, pos2 => minpos1_2, mium => mini1, maxi => max8, minpos => minposi1, min_2pos => maxpos8);
c12 : comparator port map (llr1 => min2_1, llr2 => min2_2, pos1 => minpos2_1, pos2 => minpos2_2, mium => mini2, maxi => max9, minpos => minposi2, min_2pos => maxpos9);

--stage six
c13 : comparator_min_only port map (llr1 => max8, llr2 => max9, pos1 => maxpos8, pos2 => maxpos9, mium =>mini3, minpos => minposi3);

re1 : registerN port map (d => mini1, load => en_reg, clk => clk, clr => clr , q => min_1);
re2 : registerN port map (d => mini2, load => en_reg, clk => clk, clr => clr , q => min_2);
re3 : registerN port map (d => mini3, load => en_reg, clk => clk, clr => clr , q => min_3);

re4 : register3bit port map (d => minposi1, load => en_reg, clk => clk, clr => clr , q => min_1pos);
re5 : register3bit port map (d => minposi2, load => en_reg, clk => clk, clr => clr , q => min_2pos);
re6 : register3bit port map (d => minposi3, load => en_reg, clk => clk, clr => clr , q => min_3pos);

end Behavioral;