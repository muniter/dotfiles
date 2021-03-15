#!/usr/bin/python3
# This is a simple script that shows mi a wofi menu for some 
# commands I execute alot
import subprocess
import os

HOME = os.environ["HOME"]


def wofi(options: list):
    '''Calls rofi in dmenu mode with the given selection options
        It returns the selection
    '''
    return subprocess.check_output(
            ['wofi', '-i', '-k', '/dev/null', '-d'],
            input='\n'.join(options), encoding='UTF-8').strip('\n')


if __name__ == "__main__":
    options = {
        'Connect Wireless HeadPhones E7': 'bluetoothctl connect FC:58:FA:12:E5:09',
        'Audio Config Pavucontrol': 'pavucontrol',
        'Restart PuleseAudio': 'pulseaudio --kill && pulseaudio --start',
        'Change Audio Output': '/home/muniter/bin/scripts/volume-control change-sink'
    }

    result = wofi(options.keys())
    print(options[result])
    subprocess.run(options[result].split())
