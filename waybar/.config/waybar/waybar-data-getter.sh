#!/bin/bash
sleep 1
while [ true ]
do
echo "Calling hass-cli"
hass-cli -o json state list '(binary_sensor.internet_state|sensor.outside_th_*)' >> /tmp/waybar_ha_data.json
sleep 10;
done
