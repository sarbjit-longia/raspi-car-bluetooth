#!/bin/bash

MAC_ADDRESS=`cat ~/.mac_address`

function connected {
    bluetoothctl info ${MAC_ADDRESS} | grep 'Connected: yes'
}

function rssi {
    hcitool rssi ${MAC_ADDRESS}
}

function in_reach {
    bluetoothctl devices | grep ${MAC_ADDRESS}
}

function connect {
    bluetoothctl connect ${MAC_ADDRESS} > /dev/null
}

if [[ $(connected) ]]; then
  echo "connected already" >> /home/dragon/bt.log
else
  connect

