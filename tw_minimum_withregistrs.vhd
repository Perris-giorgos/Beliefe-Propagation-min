--KNUTH SORT NETWORK


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

entity two_minimum_with is
    Port ( LLr : in  array2;
	 		  clk : in std_logic;
			  clr : in std_logic;
			  reg_en : in std_logic;
			  min : out  STD_LOGIC_vector(n-1 downto 0);
           min_2 : out  STD_LOGIC_vector(n-1 downto 0);
			  min_3 : out  STD_LOGIC_vector(n-1 downto 0);
			  minpos : out std_logic_vector(2 downto 0);
			  min_2pos : out std_logic_vector(2 downto 0);
			  min_3pos : out std_logic_vector(2 downto 0));
end two_minimum_with;

architecture two_min_with of two_minimum_with is
component Comparator
	port ( 
			  LLR1 : in  STD_LOGIC_vector(n-1 downto 0);
           LLR2 : in  STD_LOGIC_vector(n-1 downto 0);
			  pos1 : in std_logic_vector(2 downto 0);
			  pos2 : in std_logic_vector(2 downto 0);
           mium : out  STD_LOGIC_vector(n-1 downto 0);
           maxi : out  STD_LOGIC_vector(n-1 downto 0);
			  minpos : out std_logic_vector(2 downto 0);
			  min_2pos : out std_logic_vector(2 downto 0));
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

signal min1, max1, min2, max2, min3, max3, min4, max4, min5, max5, min6, min7,min8, min9, min10, max6, max7,max8, max9, max10, min11,min12,min13,min14,min15,max11,max12,max13,max14,max15,min16,min17,min18,min19,min20,min21,max16,max17,m11,m12,mx9,mx10: std_logic_vector(n-1 downto 0);
--max18,max19,max20,max21, min22,min23,min24,max22,max23,max24
signal minpos1, minpos2, minpos3, minpos4, maxpos1, maxpos2, maxpos3, maxpos4 , minpos5, minpos6, minpos7, minpos8, minpos9, minpos10, maxpos5, maxpos6, maxpos7,maxpos8,maxpos9,maxpos10,minpos11,minpos12,minpos13,minpos14,minpos15,maxpos11,maxpos12,maxpos13,maxpos14,maxpos15,maxpos16,maxpos17,minpos16,minpos17:std_logic_vector(2 downto 0);
--maxpos18,maxpos19,maxpos20,maxpos21,minpos16,minpos17,minpos18,minpos19,minpos20,minpos21, minpos22,minpos23,minpos24,maxpos22,maxpos23,maxpos24
signal  n0, n1, n2, n3, n4, n5 ,n6, n7 : std_logic_vector(n-1 downto 0);
signal  r0, r1, r2, r3, r4, r5 ,r6, r7 : std_logic_vector(n-1 downto 0);
signal mpos11, mpos12, mxpos9, mxpos10 : std_logic_vector(2 downto 0);
begin
n0 <= std_logic_vector(abs(signed(LLr(0))));
n1 <= std_logic_vector(abs(signed(LLr(1))));
n2 <= std_logic_vector(abs(signed(LLr(2))));
n3 <= std_logic_vector(abs(signed(LLr(3))));
n4 <= std_logic_vector(abs(signed(LLr(4))));
n5 <= std_logic_vector(abs(signed(LLr(5))));
n6 <= std_logic_vector(abs(signed(LLr(6))));
n7 <= std_logic_vector(abs(signed(LLr(7))));

--reg0 : registerN port map(r0 ,clk, clr, n0);
--reg1 : registerN port map(r1 ,clk, clr, n1);
--reg2 : registerN port map(r2 ,clk, clr, n2);
--reg3 : registerN port map(r3 ,clk, clr, n3);
--reg4 : registerN port map(r4 ,clk, clr, n4);
--reg5 : registerN port map(r5 ,clk, clr, n5);
--reg6 : registerN port map(r6 ,clk, clr, n6);
--reg7 : registerN port map(r7 ,clk, clr, n7);

-- stage one
c1 : Comparator port map(n0, n1, "000", "001", min1, max1, minpos1, maxpos1);
c2	: Comparator port map(n2, n3, "010", "011", min2, max2, minpos2, maxpos2);
c3	: Comparator port map(n4, n5, "100", "101", min3, max3, minpos3, maxpos3);
c4	: Comparator port map(n6, n7, "110", "111", min4, max4, minpos4, maxpos4);

--stage two
c5 : Comparator port map(min1, min2, minpos1, minpos2, min5, max5, minpos5, maxpos5);
c6 : Comparator port map(max1, max2, maxpos1, maxpos2, min6, max6, minpos6, maxpos6);
c7 : Comparator port map(min3, min4, minpos3, minpos4, min7, max7, minpos7, maxpos7);
c8 : Comparator port map(max3, max4, maxpos3, maxpos4, min8, max8, minpos8, maxpos8);

--stage three
c9 : Comparator port map(min5, min7, minpos5, minpos7, min9, mx9, minpos9, mxpos9);
c10: Comparator port map(min6, min8, minpos6, minpos8, min10, mx10, minpos10, mxpos10);
c11 : Comparator port map(max5, max7, maxpos5, maxpos7, m11, max11, mpos11, maxpos11);
c12 : Comparator port map(max8, max6, maxpos8, maxpos6, m12, max12, mpos12, maxpos12);

--break
MidReg1 : registerN port map(m11, reg_en, clk, clr, min11);
MidReg2 : registerN port map(m12, reg_en, clk, clr, min12);
MidReg3 : registerN port map(mx9, reg_en, clk, clr, max9);
MidReg4 : registerN port map(mx10, reg_en, clk, clr, max10);
MidReg5 : register3bit port map (d => mpos11, load => reg_en, clk => clk, clr => clr , q => minpos11);
MidReg6 : register3bit port map (d => mpos12, load => reg_en, clk => clk, clr => clr , q => minpos12);
MidReg7 : register3bit port map (d => mxpos9, load => reg_en, clk => clk, clr => clr , q => maxpos9);
MidReg8 : register3bit port map (d => mxpos10, load => reg_en, clk => clk, clr => clr , q => maxpos10);

--stage four
c13 : Comparator port map(min11, max9, minpos11, maxpos9, min13, max13, minpos13, maxpos13);
c14 : Comparator port map(min12, max10, minpos12, maxpos10, min14, max14, minpos14, maxpos14);
--c15 : Comparator port map(max9, max10, maxpos9, maxpos10, min15, max15, minpos15, maxpos15);
--c16 : Comparator port map(max11, max12, maxpos11, maxpos12, min16, max16, minpos16, maxpos16);

--stage five
c15 : Comparator port map(min10, max13, minpos10, maxpos13, min15, max15, minpos15, maxpos15);
c16 : Comparator port map(min13, max14, minpos13, maxpos14, min16, max16, minpos16, maxpos16);

--stage six
c17 : Comparator port map(min15, min16, minpos15, minpos16, min17, max17, minpos17, maxpos17);
--c18 : Comparator port map(min14, max15, minpos14, maxpos15, min18, max18, minpos18, maxpos18);
--c19 : Comparator port map(max16, min11, maxpos16, minpos11, min19, max19, minpos19, maxpos19);


--min  <= min9;
--min_2  <= min17;
--minpos  <=  minpos9;
--min_2pos <= minpos17;
regout1: registerN port map(min9 , reg_en, clk, clr, min);
regout2: registerN port map(min17, reg_en, clk, clr, min_2);
regout3 : registerN port map (d => max17, load => reg_en, clk => clk, clr => clr , q => min_3);

re1 : register3bit port map (d => minpos9, load => reg_en, clk => clk, clr => clr , q => minpos);
re2 : register3bit port map (d => minpos17, load => reg_en, clk => clk, clr => clr , q => min_2pos);
re3 : register3bit port map (d => maxpos17, load => reg_en, clk => clk, clr => clr , q => min_3pos);

end;