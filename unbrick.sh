#!/bin/bash

echo "resetting device";
# gatttool --adapter=hci0 --device=BA:03:1C:67:56:22 --char-write-req --handle=0x0035 --value=55;
# gatttool --adapter=hci0 --device=BA:03:1C:67:56:22 --char-write-req --handle=0x0035 --value=35;
gatttool --adapter=hci0 --device=BA:03:1C:67:56:22 --char-write-req --handle=0x0035 --value=36;

echo "start up waiting";
sleep 10;

echo "setting Uart BPS to 115200";
gatttool --adapter=hci0 --device=BA:03:1C:67:56:22 --char-write-req --handle=0x0032 --value=05;

echo "setting Device Name";
# my FNB58-SERIAL => "FNB58-037176"
# gatttool --adapter=hci0 --device=BA:03:1C:67:56:22 --char-write-req --handle=0x002c --value=464e4235382d303337313731;
# "Loso USB Meter"
gatttool --adapter=hci0 --device=BA:03:1C:67:56:22 --char-write-req --handle=0x002c --value=4C6F736F20555342204D65746572;

