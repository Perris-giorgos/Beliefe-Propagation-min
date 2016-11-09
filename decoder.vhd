library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
port(clock : in std_logic;
	  clear : in std_logic;
--	  rst : in std_logic;
	  channelin1 :in std_logic_vector(n-1 downto 0);
	  channelin2 :in std_logic_vector(n-1 downto 0);
	  noise_var :in std_logic_vector(n-1 downto 0);
--	  start : in std_logic;
--	  i_read_RAM : in  std_logic;
--		i_write_RAM : in std_logic;
--		i_start_row_counter : in std_logic;
--		i_row_process : in std_logic;
--		i_add_lam : in std_logic;
--		i_first  : in std_logic;
--		i_minimum : in std_logic;
--		i_var_sel   : in std_logic;
--		i_sign1 : in std_logic;
--		i_check_proc: in std_logic;
--		i_bit_proc : in std_logic;
--		i_output :  in std_logic;
		write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, minimu,bit_proc1, lambdas_final1, sign1, clear_in_counter,check_proc1, start_output, first_t: in std_logic;
	  --start_output: in std_logic;
	   --start_output, write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, bit_proc1, lambdas_final1, sign1, clear_in_counter: in std_logic;
	  ar : out std_logic;
	  in_cpl : out std_logic;
	  tests : out std_logic;
--	  test1 : out std_logic;
--	  test2 : out std_logic;
	  new_lambda1: out std_logic_vector(n-1 downto 0);
	  new_lambda2: out std_logic_vector(n-1 downto 0));
end decoder;

architecture Behavioral of decoder is
component shift_registers_sipo is
    port(CLK: in std_logic;
				clr_counter : in std_logic;
				nv : in std_logic_vector(n-1 downto 0);
				Si : in std_logic_vector(n-1 downto 0);
				Si2 : in std_logic_vector(n-1 downto 0);
				SO : out array3;
				complete : out std_logic);
end component;
component shift_register_piso is
    port(CLK: in std_logic;
				clr : in std_logic;
				load : in std_logic;
				Si : in array3;
				SO : out std_logic_vector(n-1 downto 0);
				SO2 : out std_logic_vector(n-1 downto 0));
--				complete : out std_logic);
end component;
component Check2BitRAM is
	port (clk : in std_logic;
			we : in std_logic;
			en :  in std_logic;
			addr : in integer range 0 to 323;
			di : in std_logic_vector(8*n-1 downto 0);
			test : out std_logic;
			do : out std_logic_vector(8*n-1 downto 0));
end component;
component row_processor is
    Port (clk : in std_logic; 
			  row_LLR : in  STD_LOGIC_vector(8*n-1 downto 0);
			  ro : in integer range 0 to 323;
			  out_en : in std_logic;
			  clr : in std_logic;
			  test : out std_logic;
			  LLRs : out array2);
end component;
component row_counter is
		port(CLK : in std_logic;
				CLR : in std_logic;
				start : in std_logic;
				all_rows : out std_logic;
            Q : out integer range 0 to 323);
end component;
component Add_lambda is
    Port (clk : in std_logic;
			  clr :in std_logic;
			  ro : in integer range 0 to 323;
			  LLRs : in array2 ;
			  lambda : in array3;
			  lam : in array3;
			  first : in std_logic;
			  load : in std_logic;
			  test : out std_logic;
			  B2C : out array2);
end component;
component minimum_7comp is
port (LLR : in array2;
		clk : in std_logic;
		clr : in std_logic;
		en_reg : in std_logic;
		test : out std_logic;
		min_1 : out  STD_LOGIC_vector(n-1 downto 0);
      min_2 : out  STD_LOGIC_vector(n-1 downto 0);
		min_3 : out  STD_LOGIC_vector(n-1 downto 0);
		min_1pos : out std_logic_vector(2 downto 0);
		min_2pos : out std_logic_vector(2 downto 0);
		min_3pos : out std_logic_vector(2 downto 0));
end component;
component check_node_process is
	port( clk 	: in std_logic;
			clr	: in std_logic;
			en_reg: in std_logic;
			a_sign: in std_logic;
			b2c_c : in std_logic_vector(n-1 downto 0);
			min_1 : in std_logic_vector(n-1 downto 0);
			min_2 : in std_logic_vector(n-1 downto 0);
			min_3 : in std_logic_vector(n-1 downto 0);
			pos_1 : in std_logic_vector(2 downto 0);
			pos_2 : in std_logic_vector(2 downto 0);
			pos_3 : in std_logic_vector(2 downto 0);
		  var_pos: in std_logic_vector(2 downto 0);
		  test : out std_logic;
			c2b 	: out std_logic_vector(n-1 downto 0)
			); 
end component;
component BitNodeUpdate is
	Port(c2bit : in std_logic_vector(n-1 downto 0);
				lambda : in array3;
				clk : in std_logic;
				clr : in std_logic;
				row : in integer range 0 to 323;
				col : in std_logic_vector(2 downto 0);
				reg_en : in std_logic;
				test : out std_logic;
				lambda_out : out std_logic_vector(n-1 downto 0));
end component;
component bitproc_outputs is
port (clk : in std_logic;
		--clr : in std_logic;
		--en_reg : in std_logic;
		row : in integer range 0 to 323;
		a0 : in std_logic_vector(n-1 downto 0); 
		a1 : in std_logic_vector(n-1 downto 0);
		a2 : in std_logic_vector(n-1 downto 0);
		a3 : in std_logic_vector(n-1 downto 0);
		a4 : in std_logic_vector(n-1 downto 0);
		a5 : in std_logic_vector(n-1 downto 0);
		a6 : in std_logic_vector(n-1 downto 0);
		a7 : in std_logic_vector(n-1 downto 0);
		test : out std_logic;
		lambdas : out array3);		
end component;
component c2b_RAm_prep is
	port(clk : in std_logic;
			  ro : in integer range 0 to 323;
				c_2_b0 : in std_logic_vector(n-1 downto 0);
				c_2_b1 : in std_logic_vector(n-1 downto 0);
				c_2_b2 : in std_logic_vector(n-1 downto 0);
				c_2_b3 : in std_logic_vector(n-1 downto 0);
				c_2_b4 : in std_logic_vector(n-1 downto 0);
				c_2_b5 : in std_logic_vector(n-1 downto 0);
				c_2_b6 : in std_logic_vector(n-1 downto 0);
				c_2_b7 : in std_logic_vector(n-1 downto 0);
				reg_en : in std_logic;
				test : out std_logic;
				row_out : out std_logic_vector(8*n-1 downto 0));
end component;
component lambdas_final is
		port (clk : in std_logic;
				clr : in std_logic;
				regen : in std_logic;
				lam : in array3;
				lambda : in array3;
				test :out std_logic;
				lambdasfinal : out array3
				);
end component;
--start_output, write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, bit_proc1, lambdas_final1, sign1, clear_in_counter
--component FSM is
--port (clk : in std_logic;
--		rstall: in std_logic;
--		--input signals
--		i_inputs_complete : in std_logic;
--		i_start : in std_logic;
--		i_row_cpl: in std_logic;
--		i_all_rows : in std_logic;
		--output 
--		o_read_RAM : out std_logic;
--		write_enable1 : out std_logic;
--		o_start_row_counter : out std_logic;
--		o_row_process : out std_logic;
--		o_add_lam : out std_logic;
--		o_first  : out std_logic;
--		o_minimum : out std_logic;
--		o_var_sel   : out std_logic;
--		o_sign1 : out std_logic;
--		o_check_proc: out std_logic;
--		o_bit_proc : out std_logic;
--		o_output :  out std_logic);
--end component;
component sign_all is
port (clk: in std_logic;
		clr: in std_logic;
		l0 : in std_logic_vector(n-1 downto 0);
		l1 : in std_logic_vector(n-1 downto 0);
		l2 : in std_logic_vector(n-1 downto 0);
		l3 : in std_logic_vector(n-1 downto 0);
		l4 : in std_logic_vector(n-1 downto 0);
		l5 : in std_logic_vector(n-1 downto 0);
		l6 : in std_logic_vector(n-1 downto 0);
		l7 : in std_logic_vector(n-1 downto 0);
		out_en: in std_logic;
		test : out std_logic;
		a_sign: out std_logic);
end component;
component testout is
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
end component;
signal channel_lambdas, new_lambdas : array3;
signal row_llrs: array2;
--signal write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, bit_proc1, lambdas_final1, sign1, clear_in_counter,check_proc1, start_output: std_logic;
--signal ar, in_cpl : std_logic;
signal row_counter1: integer range 0 to 323;
signal row , datainput: std_logic_vector(8*n-1 downto 0);
signal b2c2 :array2;
signal c2b0,c2b1,c2b2,c2b3,c2b4,c2b5,c2b6,c2b7, indexedLambda0, indexedLambda1, indexedLambda2, indexedLambda3, indexedLambda4, indexedLambda5,indexedLambda6, indexedLambda7 : std_logic_vector(n-1 downto 0);
signal fist_t : std_logic;
signal sign_a : std_logic;
signal min1 , min2, min3 : std_logic_vector(n-1 downto 0);
signal pos1,pos2,pos3 : std_logic_vector(2 downto 0);
signal new_lambdas1 : array3;
signal test,test1,test2, test3, test4,test5,test6,test7,test8,test9,test10,test11,test12, test13,test14,test15,test16,test17,test18,test19,test20, test21, test22,test23: std_logic;
begin
--control
 --clear_rcounter, clear_in_counter

--control_unit : FSM port map (clk => clock, rstall => rst, i_inputs_complete => in_cpl, i_start => start, i_all_rows => ar, o_read_RAM => read_enable1, write_enable1 => write_enable1,
--							o_start_row_counter => enable_rcounter, o_row_process => row_process1, o_add_lam => add_lambda1, o_first => fist_t, o_minimum => minimu, o_check_proc => check_proc1, o_bit_proc => bit_proc1,
--							o_sign1 => sign1, o_output => lambdas_final1);
count_rows : row_counter port map (clk => clock, start => enable_rcounter , clr => clear_rcounter,all_rows =>ar ,Q => row_counter1);
c2b_RAM: Check2BitRAM port map (clk => clock, we => write_enable1, en => read_enable1,  addr => row_counter1, di => datainput, test => test, do => row);

inputs : shift_registers_sipo port map (CLK => clock, clr_counter => clear_in_counter, Si => channelin1,	Si2 => channelin2, nv => noise_var, complete => in_cpl, SO => channel_lambdas);
row_proc : row_processor port map (clk => clock, row_LLR => row, ro => row_counter1, out_en => row_process1, clr =>clear, test => test1, LLRs => row_llrs);
give_bit2check: add_lambda port map (clk =>clock, clr => clear, ro => row_counter1, LLRs => row_llrs, lambda => new_lambdas, lam => channel_lambdas, first => fist_t, load => add_lambda1, test => test2, B2C => b2c2);
minimum3 :minimum_7comp port map (LLR => b2c2, clk => clock, clr => clear, en_reg => minimu, test => test3,min_1 => min1, min_2 => min2, min_3 => min3, min_1pos => pos1, min_2pos => pos2, min_3pos => pos3);

--check node update
find_sign : sign_all port map (clk => clock, clr => clear, l0 => b2c2(0), l1 => b2c2(1), l2 => b2c2(2), l3 => b2c2(3), l4 => b2c2(4), l5 => b2c2(5), l6 => b2c2(6), l7 => b2c2(7), out_en => sign1, test => test4, a_sign => sign_a);

check_process0: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(0), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "000", test => test5, c2b => c2b0);
check_process1: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(1), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "001", test => test6,c2b => c2b1);
check_process2: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(2), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "010", test => test7,c2b => c2b2);
check_process3: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(3), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "011", test => test8,c2b => c2b3);
check_process4: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(4), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "100", test => test9,c2b => c2b4);
check_process5: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(5), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "101", test => test10,c2b => c2b5);
check_process6: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(6), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "110", test => test11,c2b => c2b6);
check_process7: check_node_process port map(clk => clock, clr => clear, en_reg => check_proc1, b2c_c => b2c2(7), a_sign => sign_a, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "111", test => test12,c2b => c2b7);

--bit node update:
bitproc0 :BitNodeUpdate port map (c2bit => c2b0, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "000", reg_en => bit_proc1, test => test13, lambda_out => indexedLambda0);
bitproc1 :BitNodeUpdate port map (c2bit => c2b1, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "001", reg_en => bit_proc1, test => test14, lambda_out => indexedLambda1);
bitproc2 :BitNodeUpdate port map (c2bit => c2b2, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "010", reg_en => bit_proc1, test => test15, lambda_out => indexedLambda2);
bitproc3 :BitNodeUpdate port map (c2bit => c2b3, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "011", reg_en => bit_proc1, test => test16, lambda_out => indexedLambda3);
bitproc4 :BitNodeUpdate port map (c2bit => c2b4, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "100", reg_en => bit_proc1, test => test17, lambda_out => indexedLambda4);
bitproc5 :BitNodeUpdate port map (c2bit => c2b5, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "101", reg_en => bit_proc1, test => test18, lambda_out => indexedLambda5);
bitproc6 :BitNodeUpdate port map (c2bit => c2b6, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "110", reg_en => bit_proc1, test => test19, lambda_out => indexedLambda6);
bitproc7 :BitNodeUpdate port map (c2bit => c2b7, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "111", reg_en => bit_proc1, test => test20, lambda_out => indexedLambda7);

bpout : bitproc_outputs port map(clk => clock, row => row_counter1, a0 => indexedLambda0, a1=> indexedLambda1, a2 => indexedLambda2, a3 => indexedLambda3, a4 => indexedLambda4, a5 => indexedLambda5, a6 => indexedLambda6,	a7 => indexedLambda7, test => test21, lambdas => new_lambdas);	

--RAM prep:
Ram_prep : c2b_RAm_prep port map (clk => clock, ro => row_counter1, c_2_b0 => c2b0, c_2_b1 => c2b1, c_2_b2 => c2b2, c_2_b3 => c2b3, c_2_b4 => c2b4, c_2_b5 => c2b5, c_2_b6 => c2b6,	c_2_b7 => c2b7, reg_en => bit_proc1, test => test22, row_out => datainput); 

soft_codeword : lambdas_final  port map (clk =>clock, clr => clear, regen => lambdas_final1, lam => channel_lambdas, lambda => new_lambdas, test => test23, lambdasfinal => new_lambdas1);
--new_lambdas1 <= new_lambdas;
outputs: shift_register_piso port map (clk => clock, clr => clear, load => start_output, si => new_lambdas1, so => new_lambda1 , so2 => new_lambda2);

test_box : testout port map (test,test1,test2, test3, test4,test5,test6,test7,test8,test9,test10,test11,test12, test13,test14,test15,test16,test17,test18,test19,test20, test21,test22,test23,tests);
end Behavioral;