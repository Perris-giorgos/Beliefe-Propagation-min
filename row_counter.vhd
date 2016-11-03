library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity row_counter is
    port(CLK : in std_logic;
				CLR : in std_logic;
				start : in std_logic;
				all_rows : out std_logic;
            Q : out integer range 0 to 323);
end row_counter;

architecture archi of row_counter is
    signal tmp: integer range 0 to 323;
begin
    process (CLK)
    begin
        if (CLK'event and CLK='1') then
          if (CLR='1') then
            tmp <= 0;
          elsif start = '1' then 
            tmp <= tmp + 1;
				if tmp >= 322 then
					all_rows <= '1';
				else
					all_rows <= '0';
				end if;
          end if;
        end if;
    end process;
    Q <= tmp;
end archi;				