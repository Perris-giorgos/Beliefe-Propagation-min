library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
port (clk : in std_logic;
		rstall: in std_logic;
		--input signals
		i_inputs_complete : in std_logic;
		i_start : in std_logic;
		i_row_cpl: in std_logic;
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
		o_check_proc: out std_logic;
		o_bit_proc : out std_logic;
		o_output :  out std_logic
		);
end FSM;

architecture Behavioral of FSM is
type t_control_logic_fsm is (st_wait_inputs,
									  ST_RESET,
									  st_read_new_row,
									  st_row_proc,
									  st_add_lambda,
									  st_find_minimum,
									  st_check_process,
									  st_writerow_bitproc,
									  st_final_lambda,
									  st_output);
										
signal r_st_present 	: t_control_logic_fsm;
signal w_st_next 		: t_control_logic_fsm;
signal first : integer range 0 to 1;
begin

p_state : process(clk,rstb)
    begin
    if (CLK'event and CLK='1') then
      if(rstall='1') then
        r_st_present            <= ST_RESET;
      else
        r_st_present            <= w_st_next;
      end if;
	end if;
end process p_state;	


p_comb : process(	i_inputs_complete,
						r_st_present,
						i_all_rows,
						i_start
						)
		begin
			case r_st_present is
			 when st_wait_inputs => 
				if (i_inputs_complete = '1') then 
					w_st_next <= st_read_new_row;
				end if;
			 when  st_read_new_row =>
				w_st_next <= st_row_proc;
			 when st_row_proc =>
				w_st_next <= st_add_lambda;
			 when st_add_lambda =>
				w_st_next <= st_find_minimum;
			 when st_find_minimum =>
				w_st_next <= st_check_process;
			 when st_check_process =>
				w_st_next <= st_writerow_bitproc;
			 when st_writerow_bitproc =>
				w_st_next <= st_final_lambda;
			 when st_final_lambda =>
				if i_all_rows = '1' and i_row_cpl = '1' then
					w_st_next <= st_outputs;
				elsif i_all_rows = '0' and i_row_cpl = '1' then
					w_st_next <= st_read_new_row;
				end if;
			 when others => --st_rst
				if (i_start='1') then w_st_next <= st_wait_inputs; end if;
		end case;			
end process p_comb;
	
p_state_out : process(clk)
	begin
    if (CLK'event and CLK='1') then
		if rstall = '1' then 
			o_read_RAM <= '0';
			o_write_RAM <= '0';
			o_start_row_counter <= '0';
			o_row_process <= '0';
			o_add_lam <= '0';
			o_minimum <= '0';
			o_var_sel <= '0';
			o_check_proc <= '0';
			o_bit_proc <= '0';
			o_output <= '0';
		else
        case r_st_present is
			when st_wait_inputs =>
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '0';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '0';
				o_var_sel <= '0';
				check_proc <= '0';
				o_bit_proc <= '0';
				o_final_lambda <= '0';
				o_output <= '0';
			when st_read_new_row =>
				o_read_RAM <= '1';
				o_write_RAM <= '0';
				o_start_row_counter <= '1';
				o_row_process <= '0';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '0';
				o_var_sel <= '0';
				o_check_proc <= '0';	
				o_bit_proc <= '0';
				o_final_lambda <= '0';
				o_output <= '0';
			when st_row_proc =>
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '1';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '0';
				o_var_sel <= '0';
				o_check_proc <= '0';
				o_bit_proc <= '0';
				o_final_lambda <= '0';
				o_output <= '0';				
			when st_add_lambda =>
				if c = 0 then
					o_first <= '1';
					c <= 1;
				else
					o_first <= '0';
				end if;
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '0';
				o_add_lam <= '1';
				o_minimum <= '0';
				o_var_sel <= '0';
				o_check_proc <= '0';	
				o_bit_proc <= '0';
				o_final_lambda <= '0';
				o_output <= '0';
			when st_find_minimum =>
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '0';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '1';
				o_var_sel <= '1';
				o_check_proc <= '0';
				o_bit_proc <= '0';
				o_final_lambda <= '0';
				o_output <= '0';
			when st_check_process =>
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '0';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '0';
				o_var_sel <= '0';
				o_check_proc <= '1';
				o_bit_proc <= '0';
				o_final_lambda <= '0';
				o_output <= '0';
			when st_writerow_bitproc =>
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '0';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '0';
				o_var_sel <= '0';
				o_check_proc <= '0';
				o_bit_proc <= '1';
				o_final_lambda <= '0';
				o_output <= '0';
			when st_final_lambda =>
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '0';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '0';
				o_var_sel <= '0';
				o_check_proc <= '0';
				o_bit_proc <= '0';
				o_final_lambda <= '1';
				o_output <= '0';
			when o_output =>
				o_read_RAM <= '0';
				o_write_RAM <= '0';
				o_start_row_counter <= '0';
				o_row_process <= '0';
				o_add_lam <= '0';
				o_first <= '0';
				o_minimum <= '0';
				o_var_sel <= '0';
				o_check_proc <= '0';
				o_bit_proc <= '0';
				o_final_lambda <= '0';
				o_output <= '1';
			end case;
		end if;
	end if;
end process p_state_out;
end Behavioral;