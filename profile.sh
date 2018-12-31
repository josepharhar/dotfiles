for id in $(xinput --list | sed -n '/Corsair Corsair Vengeance M90 Mouse.*pointer/s/.*=\([0-9]\+\).*/\1/p')
do
  xinput --set-prop $id 'libinput Accel Profile Enabled' 0, 1 &> /dev/null
  xinput --set-prop $id 'libinput Accel Speed' 0.8 &> /dev/null
done
