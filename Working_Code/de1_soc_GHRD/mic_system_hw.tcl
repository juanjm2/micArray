# TCL File Generated by Component Editor 17.1
# Thu May 10 10:08:31 CDT 2018
# DO NOT MODIFY


# 
# mic_system "mic_system" v1.0
#  2018.05.10.10:08:31
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module mic_system
# 
set_module_property DESCRIPTION ""
set_module_property NAME mic_system
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME mic_system
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL altera_up_clock_edge
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file altera_up_clock_edge.v VERILOG PATH altera_up_clock_edge.v TOP_LEVEL_FILE
add_fileset_file avalon_microphone_system.sv SYSTEM_VERILOG PATH avalon_microphone_system.sv
add_fileset_file i2s_master.sv SYSTEM_VERILOG PATH i2s_master.sv
add_fileset_file mic_dma.sv SYSTEM_VERILOG PATH mic_dma.sv

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL altera_up_clock_edge
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file altera_up_clock_edge.v VERILOG PATH altera_up_clock_edge.v
add_fileset_file avalon_microphone_system.sv SYSTEM_VERILOG PATH avalon_microphone_system.sv
add_fileset_file i2s_master.sv SYSTEM_VERILOG PATH i2s_master.sv
add_fileset_file mic_dma.sv SYSTEM_VERILOG PATH mic_dma.sv


# 
# parameters
# 


# 
# display items
# 


# 
# connection point CLK
# 
add_interface CLK clock end
set_interface_property CLK clockRate 50000000
set_interface_property CLK ENABLED true
set_interface_property CLK EXPORT_OF ""
set_interface_property CLK PORT_NAME_MAP ""
set_interface_property CLK CMSIS_SVD_VARIABLES ""
set_interface_property CLK SVD_ADDRESS_GROUP ""

add_interface_port CLK CLK clk Input 1


# 
# connection point RESET
# 
add_interface RESET reset end
set_interface_property RESET associatedClock CLK
set_interface_property RESET synchronousEdges DEASSERT
set_interface_property RESET ENABLED true
set_interface_property RESET EXPORT_OF ""
set_interface_property RESET PORT_NAME_MAP ""
set_interface_property RESET CMSIS_SVD_VARIABLES ""
set_interface_property RESET SVD_ADDRESS_GROUP ""

add_interface_port RESET RESET reset Input 1


# 
# connection point mic_slave
# 
add_interface mic_slave avalon end
set_interface_property mic_slave addressUnits WORDS
set_interface_property mic_slave associatedClock CLK
set_interface_property mic_slave associatedReset RESET
set_interface_property mic_slave bitsPerSymbol 8
set_interface_property mic_slave burstOnBurstBoundariesOnly false
set_interface_property mic_slave burstcountUnits WORDS
set_interface_property mic_slave explicitAddressSpan 0
set_interface_property mic_slave holdTime 0
set_interface_property mic_slave linewrapBursts false
set_interface_property mic_slave maximumPendingReadTransactions 0
set_interface_property mic_slave maximumPendingWriteTransactions 0
set_interface_property mic_slave readLatency 0
set_interface_property mic_slave readWaitStates 0
set_interface_property mic_slave readWaitTime 0
set_interface_property mic_slave setupTime 0
set_interface_property mic_slave timingUnits Cycles
set_interface_property mic_slave writeWaitTime 0
set_interface_property mic_slave ENABLED true
set_interface_property mic_slave EXPORT_OF ""
set_interface_property mic_slave PORT_NAME_MAP ""
set_interface_property mic_slave CMSIS_SVD_VARIABLES ""
set_interface_property mic_slave SVD_ADDRESS_GROUP ""

add_interface_port mic_slave AVL_ADDR address Input 2
add_interface_port mic_slave AVL_READ read Input 1
add_interface_port mic_slave AVL_WRITE write Input 1
add_interface_port mic_slave AVL_WRITEDATA writedata Input 32
add_interface_port mic_slave AVL_READDATA readdata Output 32
add_interface_port mic_slave AVL_CS chipselect Input 1
set_interface_assignment mic_slave embeddedsw.configuration.isFlash 0
set_interface_assignment mic_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment mic_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment mic_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point mic_master
# 
add_interface mic_master avalon start
set_interface_property mic_master addressUnits SYMBOLS
set_interface_property mic_master associatedClock CLK
set_interface_property mic_master associatedReset RESET
set_interface_property mic_master bitsPerSymbol 8
set_interface_property mic_master burstOnBurstBoundariesOnly false
set_interface_property mic_master burstcountUnits WORDS
set_interface_property mic_master doStreamReads false
set_interface_property mic_master doStreamWrites false
set_interface_property mic_master holdTime 0
set_interface_property mic_master linewrapBursts false
set_interface_property mic_master maximumPendingReadTransactions 0
set_interface_property mic_master maximumPendingWriteTransactions 0
set_interface_property mic_master readLatency 0
set_interface_property mic_master readWaitTime 1
set_interface_property mic_master setupTime 0
set_interface_property mic_master timingUnits Cycles
set_interface_property mic_master writeWaitTime 0
set_interface_property mic_master ENABLED true
set_interface_property mic_master EXPORT_OF ""
set_interface_property mic_master PORT_NAME_MAP ""
set_interface_property mic_master CMSIS_SVD_VARIABLES ""
set_interface_property mic_master SVD_ADDRESS_GROUP ""

add_interface_port mic_master AM_ADDR address Output 32
add_interface_port mic_master AM_BURSTCOUNT burstcount Output 3
add_interface_port mic_master AM_WRITE write Output 1
add_interface_port mic_master AM_WRITEDATA writedata Output 32
add_interface_port mic_master AM_BYTEENABLE byteenable Output 4
add_interface_port mic_master AM_WAITREQUEST waitrequest Input 1


# 
# connection point AUD_BCLK
# 
add_interface AUD_BCLK conduit end
set_interface_property AUD_BCLK associatedClock CLK
set_interface_property AUD_BCLK associatedReset RESET
set_interface_property AUD_BCLK ENABLED true
set_interface_property AUD_BCLK EXPORT_OF ""
set_interface_property AUD_BCLK PORT_NAME_MAP ""
set_interface_property AUD_BCLK CMSIS_SVD_VARIABLES ""
set_interface_property AUD_BCLK SVD_ADDRESS_GROUP ""

add_interface_port AUD_BCLK AUD_BCLK new_signal Input 1


# 
# connection point AUD_ADCLRCK
# 
add_interface AUD_ADCLRCK conduit end
set_interface_property AUD_ADCLRCK associatedClock CLK
set_interface_property AUD_ADCLRCK associatedReset RESET
set_interface_property AUD_ADCLRCK ENABLED true
set_interface_property AUD_ADCLRCK EXPORT_OF ""
set_interface_property AUD_ADCLRCK PORT_NAME_MAP ""
set_interface_property AUD_ADCLRCK CMSIS_SVD_VARIABLES ""
set_interface_property AUD_ADCLRCK SVD_ADDRESS_GROUP ""

add_interface_port AUD_ADCLRCK AUD_ADCLRCK new_signal Input 1


# 
# connection point GPIO_DIN1
# 
add_interface GPIO_DIN1 conduit end
set_interface_property GPIO_DIN1 associatedClock CLK
set_interface_property GPIO_DIN1 associatedReset RESET
set_interface_property GPIO_DIN1 ENABLED true
set_interface_property GPIO_DIN1 EXPORT_OF ""
set_interface_property GPIO_DIN1 PORT_NAME_MAP ""
set_interface_property GPIO_DIN1 CMSIS_SVD_VARIABLES ""
set_interface_property GPIO_DIN1 SVD_ADDRESS_GROUP ""

add_interface_port GPIO_DIN1 GPIO_DIN1 new_signal Input 1


# 
# connection point codec_stream
# 
add_interface codec_stream conduit end
set_interface_property codec_stream associatedClock CLK
set_interface_property codec_stream associatedReset RESET
set_interface_property codec_stream ENABLED true
set_interface_property codec_stream EXPORT_OF ""
set_interface_property codec_stream PORT_NAME_MAP ""
set_interface_property codec_stream CMSIS_SVD_VARIABLES ""
set_interface_property codec_stream SVD_ADDRESS_GROUP ""

add_interface_port codec_stream codec_stream new_signal Output 32

