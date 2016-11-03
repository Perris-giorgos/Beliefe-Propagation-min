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
	  channelin1 :in std_logic_vector(n-1 downto 0);
	  channelin2 :in std_logic_vector(n-1 downto 0);
	  noise_var :in std_logic_vector(n-1 downto 0);
	  start_output: in std_logic;
	  new_lambda1: out std_logic_vector(n-1 downto 0);
	  new_lambda2: out std_logic_vector(n-1 downto 0);
	  min1 , min2, min3 :out std_logic_vector(n-1 downto 0);
	  pos1,pos2,pos3 : out std_logic_vector(2 downto 0));
end decoder;

architecture Behavioral of decoder is
component shift_registers_sipo is
    port(CLK: in std_logic;
--				clr : in std_logic;
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
			do : out std_logic_vector(8*n-1 downto 0));
end component;
component row_processor is
    Port (clk : in std_logic; 
			  row_LLR : in  STD_LOGIC_vector(8*n-1 downto 0);
			  ro : in integer range 0 to 323;
			  out_en : out std_logic;
			  clr : in std_logic;
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
			  B2C : out array2);
end component;
component minimum_7comp is
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
end component;
component BitNodeUpdate is
	Port(c2bit : in std_logic_vector(n-1 downto 0);
				lambda : in array3;
				clk : in std_logic;
				clr : in std_logic;
				row : in integer range 0 to 323;
				col : in std_logic_vector(2 downto 0);
				reg_en : in std_logic;
				lambda_out : out std_logic_vector(n-1 downto 0));
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
				row_out : out std_logic_vector(8*n-1 downto 0));
end component;
component lambdas_final is
		port (clk : in std_logic;
				clr : in std_logic;
				regen : in std_logic;
				lam : in array3;
				lambda : in array3;
				lambdasfinal : out array3
				);
end component;

signal channel_lambdas, new_lambdas : array3;
signal row_llrs: array2;
signal write_enable1, read_enable1, row_process1, enable_rcounter,clear_rcounter, add_lambda1, bit_proc1, lambdas_final1: std_logic;
signal ar, rst_fsm, in_cpl : std_logic;
signal row_counter1: integer range 0 to 323;
signal row , datainput: std_logic_vector(8*n-1 downto 0);
signal b2c2 :array2;
signal c2b0,c2b1,c2b2,c2b3,c2b4,c2b5,c2b6,c2b7, indexedLambda0, indexedLambda1, indexedLambda2, indexedLambda3, indexedLambda4, indexedLambda5,indexedLambda6, indexedLambda7 : std_logic_vector(n-1 downto 0);
signal fist_t :std_logic;
signal minimu :std_logic;
begin
--control
--control_unit : FSM (clk => clock, rstall => rst_fsm, inputs_complete => in_cpl);

c2b_RAM: Check2BitRAM port map (clk => clock, we => write_enable1, en => read_enable1,  addr => row_counter1, di => datainput, do => row);
count_rows : row_counter port map (clk => clock, start => enable_rcounter , clr => clear_rcounter,all_rows =>ar ,Q => row_counter1);

inputs : shift_registers_sipo port map (CLK => clock, Si => channelin1,	Si2 => channelin2, complete => in_cpl, SO => channel_lambdas);
row_proc : row_processor port map (clk => clock, row_LLR => row, ro => row_counter1, out_en => row_process1, clr =>clear, LLRs => row_llrs);
give_bit2check: add_lambda port map (clk =>clock, clr => clear, ro => row_counter1, LLRs => row_llrs, lambda => new_lambdas, lam => channel_lambdas, first => fist_t, load => add_lambda1, B2C => b2c2);
minimum3 :minimum_7comp port map (LLR => b2c2, clk => clock, clr => clear, en_reg => minimu, min_1 => min1, min_2 => min2, min_3 => min3, min_1pos => pos1, min_2pos => pos2, min_3pos => pos3);

--check node update
check_process0: dsaj port map(l0 => llr1, l1 => llr2 , l2 => llr3, l3 => llr4, l4 => llr5, l5 => llr6, l6 => llr7, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "000", c2b => c2b0);
check_process1: dsaj port map(l0 => llr0, l1 => llr2 , l2 => llr3, l3 => llr4, l4 => llr5, l5 => llr6, l6 => llr7, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "001", c2b => c2b1);
check_process2: dsaj port map(l0 => llr0, l1 => llr1 , l2 => llr3, l3 => llr4, l4 => llr5, l5 => llr6, l6 => llr7, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "010", c2b => c2b2);
check_process3: dsaj port map(l0 => llr0, l1 => llr1 , l2 => llr2, l3 => llr4, l4 => llr5, l5 => llr6, l6 => llr7, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "011", c2b => c2b3);
check_process4: dsaj port map(l0 => llr0, l1 => llr1 , l2 => llr2 ,l3 => llr3, l4 => llr5, l5 => llr6, l6 => llr7, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "100", c2b => c2b4);
check_process5: dsaj port map(l0 => llr0, l1 => llr1 , l2 => llr2 ,l3 => llr3, l4 => llr4, l5 => llr6, l6 => llr7, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "101", c2b => c2b5);
check_process6: dsaj port map(l0 => llr0, l1 => llr1 , l2 => llr2 ,l3 => llr3, l4 => llr4, l5 => llr5, l6 => llr7, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "110", c2b => c2b6);
check_process7: dsaj port map(l0 => llr0, l1 => llr1 , l2 => llr2 ,l3 => llr3, l4 => llr4, l5 => llr5, l6 => llr6, clk => clock, clr => clear, en_reg => row_process1, min_1 => min1, pos_1 => pos1, min_2 => min2, pos_2 => pos1, min_3 => min3, pos_3 => pos3, var_pos => "111", c2b => c2b7);

--bit node update:
bitproc0 :BitNodeUpdate port map (c2bit => c2b0, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "000", reg_en => bit_proc1, lambda_out => indexedLambda0);
indexedLambda0 <= new_lambdas(col_position(row_counter1, 0));
bitproc1 :BitNodeUpdate port map (c2bit => c2b1, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "001", reg_en => bit_proc1, lambda_out => indexedLambda1);
indexedLambda1 <= new_lambdas(col_position(row_counter1, 1));
bitproc2 :BitNodeUpdate port map (c2bit => c2b2, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "010", reg_en => bit_proc1, lambda_out => indexedLambda2);
indexedLambda2 <= new_lambdas(col_position(row_counter1, 2));
bitproc3 :BitNodeUpdate port map (c2bit => c2b3, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "011", reg_en => bit_proc1, lambda_out => indexedLambda3);
indexedLambda3 <= new_lambdas(col_position(row_counter1, 3));
bitproc4 :BitNodeUpdate port map (c2bit => c2b4, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "100", reg_en => bit_proc1, lambda_out => indexedLambda4);
indexedLambda4 <= new_lambdas(col_position(row_counter1, 4));
bitproc5 :BitNodeUpdate port map (c2bit => c2b5, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "101", reg_en => bit_proc1, lambda_out => indexedLambda5);
indexedLambda5 <= new_lambdas(col_position(row_counter1, 5));
bitproc6 :BitNodeUpdate port map (c2bit => c2b6, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "110", reg_en => bit_proc1, lambda_out => indexedLambda6);
indexedLambda6 <= new_lambdas(col_position(row_counter1, 6));
bitproc7 :BitNodeUpdate port map (c2bit => c2b7, lambda => new_lambdas, clk => clock, clr => clear, row => row_counter1, col => "111", reg_en => bit_proc1, lambda_out => indexedLambda7);
indexedLambda7 <= new_lambdas(col_position(row_counter1, 7));

--RAM prep:
Ram_prep : c2b_RAm_prep port map (clk => clock, ro => row_counter1, c_2_b0 => c2b0, c_2_b1 => c2b1, c_2_b2 => c2b2, c_2_b3 => c2b3, c_2_b4 => c2b4, c_2_b5 => c2b5, c_2_b6 => c2b6,	c_2_b7 => c2b7, reg_en => bit_proc1,	row_out => datainput); 

soft_codeword : lambdas_final  port map (clk =>clock, clr => clear, regen => lambdas_final1, lam => channel_lambdas, lambda => new_lambdas, lambdasfinal => new_lambdas);

outputs: shift_register_piso port map (clk => clock, clr => clear, load => start_output, si => new_lambdas, so => new_lambda1 , so2 => new_lambda2);

end Behavioral;