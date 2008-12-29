SetActiveLib -work
comp -include "$DSN\src\shift_register.vhd" 
comp -include "$DSN\src\TestBench\shift_register_TB.vhd" 
asim TESTBENCH_FOR_shift_register 
wave 
wave -noreg p_in
wave -noreg p_out
wave -noreg reset
wave -noreg clock
wave -noreg shift
wave -noreg load
wave -noreg s_in
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$DSN\src\TestBench\shift_register_TB_tim_cfg.vhd" 
# asim TIMING_FOR_shift_register 
