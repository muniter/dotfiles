#!/usr/bin/python3

import json
from subprocess import check_output as chout


workspaces = json.loads(chout(['swaymsg', '-r', '-t', 'get_workspaces']))
tree = json.loads(chout(['swaymsg', '-r', '-t', 'get_tree']))
marks = json.loads(chout(['swaymsg', '-r', '-t', 'get_marks']))
seats = json.loads(chout(['swaymsg', '-r', '-t', 'get_seats']))
outputs = json.loads(chout(['swaymsg', '-r', '-t', 'get_outputs']))
