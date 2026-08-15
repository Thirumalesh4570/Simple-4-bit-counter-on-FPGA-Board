## PL Clock (100 MHz LVDS)
set_property PACKAGE_PIN D7 [get_ports clk_p]
set_property PACKAGE_PIN D6 [get_ports clk_n]
set_property IOSTANDARD LVDS [get_ports {clk_p clk_n}]
create_clock -period 10.000 [get_ports clk_p]

## LEDs
set_property PACKAGE_PIN AF5 [get_ports {PL_USER_LED[0]}]
set_property PACKAGE_PIN AE7 [get_ports {PL_USER_LED[1]}]
set_property PACKAGE_PIN AH2 [get_ports {PL_USER_LED[2]}]
set_property PACKAGE_PIN AE5 [get_ports {PL_USER_LED[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports PL_USER_LED*]

## Push Button
set_property PACKAGE_PIN AB6 [get_ports PL_USER_PB0]
set_property IOSTANDARD LVCMOS12 [get_ports PL_USER_PB0]

## Switch
set_property PACKAGE_PIN AB1 [get_ports PL_USER_SW0]
set_property IOSTANDARD LVCMOS12 [get_ports PL_USER_SW0]
