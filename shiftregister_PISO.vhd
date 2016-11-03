library ieee;
use ieee.std_logic_1164.all;
use work.my_types_pkg.all;

entity shift_register_piso is
    port(CLK: in std_logic;
				clr : in std_logic;
				load : in std_logic;
				Si : in array3;
				SO : out std_logic_vector(n-1 downto 0);
				SO2 : out std_logic_vector(n-1 downto 0));
--				complete : out std_logic);
end shift_register_piso;


architecture archi of shift_register_piso is
component registerN is
	port(d : in std_logic_vector(n-1 downto 0);
		  load : in std_logic;
		   clk : in std_logic;
			clr : in std_logic;
			q : out std_logic_vector(n-1 downto 0));
end component;

    signal tmp, tmp2: std_logic_vector(n-1 downto 0);
	 signal tmp_array : array3;
	 signal in_times :integer range 0 to 647;
begin
    process (CLK)
    begin
			if (CLK'event and CLK='1') then
--           if clr = '1' then 
--					in_times <= 0;
--				end if;
--				if load = '1' then 
--						tmp_array <= si;
--				else 
--				in_times <= in_times +1;
--				if in_times = 322 then
--					complete <= '1';
--				elsif in_times = 323 then
--					complete <= '0';
--				end if;
				-- SHIFT REGISTER PISO
					tmp <= tmp_array(0);
					tmp2 <= tmp_array(1);
					for i in 0 to 322 loop
						tmp_array(2*i) <=tmp_array(2*i+2);
						tmp_array(2*i+1) <=tmp_array(2*i+3);
					end loop;
--			end if;
			end if;
	end process;
	
	out1: registerN port map (d => tmp, clk => clk, clr => clr, load =>load, q => so);
	out2: registerN port map (d => tmp2, clk => clk, clr => clr, load =>load, q => so2);
--	so <= tmp;
--	so2 <= tmp2;
end archi;