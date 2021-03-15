#!/usr/bin/python3

'''
This program is intended to allow me to extract more functionality of the keybaord, making
'''

import atexit
import evdev
import os
import time
from time import sleep

# Check if running as roout
assert os.geteuid() == 0, "Run the program as root"
# If I don't slee for some reason I loose escape, or any key
# I use to start the script.
sleep(1)

def get_remap(event, table):
    """Take an event, and get the remap key
    :event: The evdev event
    :returns: Tuple with the remap (key, hold, press)
    """
    for key in ev.active_keys():
        if key in table:
            return (key, table[key][0], table[key][1])
    return (False, False, False)


# Define an example dictionary describing the remaps.
REMAP_TABLE = {
            evdev.ecodes.KEY_TAB: [evdev.ecodes.KEY_LEFTMETA,
                                   evdev.ecodes.KEY_TAB,
                                   (0, 0)],
            evdev.ecodes.KEY_BACKSLASH: [evdev.ecodes.KEY_LEFTMETA,
                                         evdev.ecodes.KEY_BACKSLASH,
                                         (0, 0)],
            evdev.ecodes.KEY_CAPSLOCK: [evdev.ecodes.KEY_RIGHTALT,
                                        evdev.ecodes.KEY_ESC,
                                        (0, 0)],
            evdev.ecodes.KEY_Z: [evdev.ecodes.KEY_LEFTCTRL,
                                 evdev.ecodes.KEY_BACKSPACE,
                                 (0, 0)]
        }


# Select the keyboard
NAME = 'MosArt USB Keyboard'
devices = [evdev.InputDevice(fn) for fn in evdev.list_devices()]
kbd = [d for d in devices if d.name == NAME and len(d._rawcapabilities) > 4][0]

# Make the virtual Kb name similar.
virtual_kdb_name = f"{kbd.info.vendor}:{kbd.info.product}:{kbd.name}"

atexit.register(kbd.ungrab)  # Ungrab on exit
kbd.grab()  # Grab all the events

# Create a new keyboard mimicking the original one.
with evdev.UInput.from_device(kbd, name=virtual_kdb_name) as ui:
    # Read events from original keyboard.
    for ev in kbd.read_loop():
        # Process only key events.
        if ev.type == evdev.ecodes.EV_KEY:
            print(kbd.active_keys(True))
            # Get the remap definition
            remap = get_remap(ev, REMAP_TABLE)
            key, khold, kpress = remap
            # When pause is pressed break the loop
            if ev.code == evdev.ecodes.KEY_PAUSE and ev.value == 1:
                break
            elif remap:
                pass
            else:
                ui.write(ev.type, ev.code, ev.value)
        else:
            # Passthrough other events unmodified (e.g. SYNs).
            ui.write(ev.type, ev.code, ev.value)
