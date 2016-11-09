library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testout is
port (t : in std_logic;
		t1 : in std_logic;
		t2 : in std_logic;
		t3 : in std_logic;
		t4 : in std_logic;
		t5 : in std_logic;
		t6 : in std_logic;
		t7 : in std_logic;
		t8 : in std_logic;
		t9 : in std_logic;
		t10 : in std_logic;
		t11 : in std_logic;
		t12 : in std_logic;
		t13 : in std_logic;
		t14 : in std_logic;
		t15 : in std_logic;
		t16 : in std_logic;
		t17 : in std_logic;
		t18 : in std_logic;
		t19 : in std_logic;
		t20 : in std_logic;
		t21 : in std_logic;
		t22 : in std_logic;
		t23 : in std_logic;
		tout : out std_logic
		);
end testout;

architecture Behavioral of testout is
signal n1,n2,m1,m2 : std_logic;
begin
n1 <= t or t1 or t2 or t3 or t4 or t5 ;
m1 <= t6 or t7 or  t8 or t9 or t10 or t11;
n2 <= t12 or t13 or t14 or t15 or t16 or t17;
m2 <= t18 or t19 or t20 or t21 or t22 or t23 ;

tout <= n1 or m1 or n2 or m2;
end Behavioral;

