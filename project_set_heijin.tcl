# file for project debugged on heijin's demo board 2018/2/24

# clock pin 50M is at R9-pin
set_location_assignment	PIN_R9	-to clk_in


# reset pin
set_location_assignment	PIN_M1	-to reset


# the manual said if want to use SRAM's or FLASH's pins need to disable FLASH and SRAM
# so we have to set following pins as '0'
set_location_assignment	PIN_L11	-to sram_cs
set_location_assignment	PIN_J13	-to flash_cs

# in this case I set uart output pin as L15
set_location_assignment PIN_L15		-to uart_out


# in this case I set uart input pin as K15
set_location_assignment PIN_K15		-to uart_data_in



# in this case I set sw-out as LEDs in demo-board 
set_location_assignment PIN_J1		-to sw_out[0]
set_location_assignment PIN_J2		-to sw_out[1]
set_location_assignment PIN_K1		-to sw_out[2]
set_location_assignment PIN_K2		-to sw_out[3]





