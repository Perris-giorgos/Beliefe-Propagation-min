library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.my_types_pkg.all;

entity Check2BitRAM is
port (clk : in std_logic;
			we : in std_logic;
			en :  in std_logic;
			addr : in integer range 0 to 323;
			di : in std_logic_vector(8*n-1 downto 0);
			do : out std_logic_vector(8*n-1 downto 0));
end Check2BitRAM;

architecture syn of Check2BitRAM is
type ram_type is array (0 to 323) of std_logic_vector (8*n-1 downto 0);
signal RAM : ram_type;
begin
process (clk)
begin
	if clk'event and clk = '1' then
		if en = '1' then
			if we = '1' then
				RAM(addr) <= di;
				do <= di;
			else
				do <= RAM( addr);
			end if;
		end if;
	end if;
end process;
end syn;