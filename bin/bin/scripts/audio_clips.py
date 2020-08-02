h#!/usr/bin/python3
import subprocess
from datetime import datetime

# This file should be in the format $youtube-url,$start-time,$end-time,$title
file = 'videos.txt'

with open(file) as f:
    for line in f:
        data = line.strip().split(",")
        times = data[1:3]

        try:
            times = [datetime.strptime(x, '%H:%M:%S') for x in times]
        except Exception as e:
            print(times)
            print(
                'Tried this time format and failed "%H:%M:%S" will try whitout hours'
            )
        try:
            times = [datetime.strptime(x, '%M:%S') for x in times]
        except Exception as e:
            raise e

        times = [x.strftime('%H:%M:%S') for x in times]

        command = f'youtube-dl -x  --postprocessor-args "-ss {times[0]} -to {times[1]}" -o "{data[3]}.%(ext)s" {data[0]}'
        print(f'running command {command}')
        subprocess.run(command, shell=True, stderr=subprocess.PIPE, check=True)
