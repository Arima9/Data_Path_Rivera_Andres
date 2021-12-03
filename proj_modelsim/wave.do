onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_tb/INST
add wave -noupdate /MIPS_tb/STATE
add wave -noupdate /MIPS_tb/MCLK
add wave -noupdate /MIPS_tb/MCLR
add wave -noupdate -radix hexadecimal /MIPS_tb/GPIO_o_tb
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/PC_reg
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/AdrSM_mux
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/MS_Rdat
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/Instr_reg
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/Data_reg
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/A3RF_mux
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/WDRF_mux
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/RF_RD1
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/RF_RD2
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/SrcA_mux
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/SrcB_mux
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/ALUresult
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/ACC_reg
add wave -noupdate -radix hexadecimal /MIPS_tb/DUT/PCin_mux
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {235700 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 108
configure wave -valuecolwidth 73
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {72100 ps} {258300 ps}
