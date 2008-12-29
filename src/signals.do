onerror { resume }
transcript off
add wave -noreg -logic {/clock}
add wave -noreg -hexadecimal -literal -signed2 {/step_no}
add wave -noreg -hexadecimal -literal -unsigned {/p_out}
add wave -noreg -hexadecimal -literal -unsigned {/p_in}
add wave -noreg -logic {/start}
add wave -noreg -logic {/load}
cursor "Cursor 1" 136.944ns
transcript on
