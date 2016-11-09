
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Comparator is
    Port (
			  LLR1 : in  STD_LOGIC_vector(n-1 downto 0);
           LLR2 : in  STD_LOGIC_vector(n-1 downto 0);
			  pos1 : in std_logic_vector(2 downto 0);
			  pos2 : in std_logic_vector(2 downto 0);
           mium : out  STD_LOGIC_vector(n-1 downto 0);
           maxi : out  STD_LOGIC_vector(n-1 downto 0);
			  minpos : out std_logic_vector(2 downto 0);
			  min_2pos : out std_logic_vector(2 downto 0));
end comparator;

architecture comp of comparator is

begin
	process(LLR1,LLr2,pos1,pos2)
	begin
		if (abs(signed(LLR1)) < abs(signed(LLR2))) then
			mium <= std_logic_vector(abs(signed(LLR1)));
			minpos <= pos1;
			maxi <=std_logic_vector(abs(signed(LLR2)));
			min_2pos <= pos2;
		else
			maxi <= std_logic_vector(abs(signed(LLR1)));
			minpos <= pos2;
			mium <= std_logic_vector(abs(signed(LLR2)));
			min_2pos <= pos1;		
		end if;	
	end process;
end comp;