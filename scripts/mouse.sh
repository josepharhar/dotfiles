##xinput --set-prop 10 'Device Accel Constant Deceleration' 1.2
#
##xinput --list-props 10
#
#xinput --set-prop 'PixArt Lenovo USB Optical Mouse' 'libinput Accel Speed' -0.7
##xinput --set-prop 10 'libinput Accel Profiles Available' 1, 1
##xinput --set-prop 10 'libinput Accel Profile Enabled' 1, 0
##xinput --set-prop 10 'Coordinate Transformation Matrix' 1, 0, 0, 0, 1, 0, 0, 0, 1

# disable acceleration
xinput --set-prop 'Logitech USB-PS/2 Optical Mouse' 'libinput Accel Profile Enabled' 0, 1
# set speed
xinput --set-prop 'Logitech USB-PS/2 Optical Mouse' 'libinput Accel Speed' 1
