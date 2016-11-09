library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_box is
port (clock : in std_logic;
		clr : in std_logic;
  	  rst : in std_logic;
	  start : in std_logic;
	  channelin1 :in std_logic_vector(n-1 downto 0);
	  channelin2 :in std_logic_vector(n-1 downto 0);
	  noise_var :in std_logic_vector(n-1 downto 0);
	  test : out std_logic;
		new_lambda1: out std_logic_vector(n-1 downto 0);
	  new_lambda2: out std_logic_vector(n-1 downto 0));
end decoder_box;

architecture Behavioral of decoder_box is
component FSM is
port (clk : in std_logic;
		rstall: in std_logic;
		--input signals
		i_inputs_complete : in std_logic;
		i_start : in std_logic;
--		i_row_cpl: in std_logic;
		i_all_rows : in std_logic;
		--output 
		o_read_RAM : out std_logic;
		o_write_RAM : out std_logic;
		o_start_row_counter : out std_logic;
		o_row_process : out std_logic;
		o_add_lam : out std_logic;
		o_first  : out std_logic;
		o_minimum : out std_logic;
		o_var_sel   : out std_logic;
		o_sign1 : out std_logic;
		o_check_proc: out std_logic;
		o_bit_proc : out std_logic;
		o_final_lambda: out std_logic;
		o_output :  out std_logic);
end component;
component decoder is
port(clock : in std_logic;
	  clear : in std_logic;
	  channelin1 :in std_logic_vector(n-1 downto 0);
	  channelin2 :in std_logic_vector(n-1 downto 0);
	  noise_var :in std_logic_vector(n-1 downto 0);
		write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, minimu,bit_proc1, lambdas_final1, sign1, clear_in_counter,check_proc1,  start_output,first_t: in std_logic;
		ar : out std_logic;
	  in_cpl : out std_logic;
	  	--start_output: in std_logic;
	   --start_output, write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, bit_proc1, lambdas_final1, sign1, clear_in_counter: in std_logic;
	  tests : out std_logic;
	  new_lambda1: out std_logic_vector(n-1 downto 0);
	  new_lambda2: out std_logic_vector(n-1 downto 0));
end component;
signal write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, minimu,bit_proc1, lambdas_final1, sign1, clear_in_counter,check_proc1, start_output, first_t: std_logic;
signal ar, in_cpl : std_logic;

begin
control_unit : FSM port map (clk => clock, rstall => rst, i_inputs_complete => in_cpl, i_start => start, i_all_rows => ar, o_read_RAM => read_enable1, o_write_ram => write_enable1,
							o_start_row_counter => enable_rcounter, o_row_process => row_process1, o_add_lam => add_lambda1, o_first => first_t, o_minimum => minimu, o_check_proc => check_proc1, o_bit_proc => bit_proc1,
							o_sign1 => sign1, o_final_lambda => lambdas_final1, o_output  => start_output);
decode : decoder port map (clock => clock, clear => clr, clear_rcounter => clr,clear_in_counter=> clr,channelin1 => channelin1, channelin2 => channelin2, noise_var => noise_var,read_enable1 => read_enable1, write_enable1 => write_enable1,
							enable_rcounter => enable_rcounter, row_process1 => row_process1, add_lambda1 => add_lambda1, first_t => first_t, minimu => minimu, check_proc1 => check_proc1, bit_proc1 => bit_proc1,
							sign1 => sign1, lambdas_final1 => lambdas_final1, start_output=>start_output, in_cpl => in_cpl,ar => ar, tests => test, new_lambda1 => new_lambda1,new_lambda2 => new_lambda2);

end Behavioral;