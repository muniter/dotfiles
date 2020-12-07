#!/usr/bin/python3

import atexit
import evdev
import os
from time import sleep

# Check if running as roout
assert os.geteuid() == 0, "Run the program as root"
# If I don't slee for some reason I loose escape, or any key
# I use to start the script.
sleep(1)

# Define an example dictionary describing the remaps.
REMAP_TABLE = {
            evdev.ecodes.KEY_TAB: [evdev.ecodes.KEY_LEFTMETA,
                                   evdev.ecodes.KEY_TAB],
            evdev.ecodes.KEY_BACKSLASH: [evdev.ecodes.KEY_LEFTMETA,
                                         evdev.ecodes.KEY_BACKSLASH],
            evdev.ecodes.KEY_CAPSLOCK: [evdev.ecodes.KEY_RIGHTALT,
                                        evdev.ecodes.KEY_ESC],
            # evdev.ecodes.KEY_A: [evdev.ecodes.KEY_LEFTCTRL,
            #                      evdev.ecodes.KEY_A],
            # evdev.ecodes.KEY_LEFTSHIFT: [evdev.ecodes.KEY_LEFTSHIFT,
            #                              evdev.ecodes.KEY_BACKSPACE],
        }

# Select the keyboard
devices = [evdev.InputDevice(fn) for fn in evdev.list_devices()]
devices_names = list(map(lambda d: d.name, devices))

# Names
KEYBOARDS = ['AT Translated Set 2 keyboard',
             'MosArt USB Keyboard',
             'MosArt USB 2.4G Keyboard']
for k in KEYBOARDS:
    if k in devices_names:
        NAME = k
        break
kbd = [d for d in devices if d.name == NAME and len(d._rawcapabilities) > 4][0]

# Make the virtual Kb name similar.
virtual_kdb_name = f"{kbd.info.vendor}:{kbd.info.product}:{kbd.name}"

# Grab, i.e. prevent the keyboard from emitting original events.
# Don't forget to ungrab the keyboard on exit!
atexit.register(kbd.ungrab)
kbd.grab()

# Last press key wil be stored here
last_event = ''

# TODO: Fix the logic, I shoul not send events for the
# remap unless I haven't received a 2 "Hold" event.
# TODO: last_event checking fails when I press a key and the up event
# hasn't triggered, Happens a lot when using tab, because of quick typing
# rather save the last type of key event received for that remapping.
# Create a new keyboard mimicking the original one.
with evdev.UInput.from_device(kbd, name=virtual_kdb_name) as ui:
    # Read events from original keyboard.
    for ev in kbd.read_loop():
        # print("Active keycodes", kbd.active_keys(True))
        # Process only key events.
        if ev.type == evdev.ecodes.EV_KEY:
            # When end is pressed break the loop
            if ev.code == evdev.ecodes.KEY_END and ev.value == 1:
                break
            # If I want to remap that key
            elif ev.code in REMAP_TABLE:
                remap_def = REMAP_TABLE[ev.code]
                # Key to remap
                remap = remap_def[0]
                # Key to send when single press and release.
                sp_remap = remap_def[1]
                # Send the remap
                ui.write(evdev.ecodes.EV_KEY, remap, ev.value)
                # If this event is keyup
                if ev.value == 0:
                    # If last event was for this key and was a Key Down(1).
                    if last_event.code == ev.code and last_event.value == 1:
                        # Send the single press remap Down (1) and up (0).
                        ui.write(evdev.ecodes.EV_KEY, sp_remap, 1)
                        ui.write(evdev.ecodes.EV_KEY, sp_remap, 0)
            else:
                # Passthrough other key events unmodified.
                ui.write(evdev.ecodes.EV_KEY, ev.code, ev.value)
            # Remember the last press, useful to check if key
            # was released and call the solo press.
            last_event = ev
        else:
            # Passthrough other events unmodified (e.g. SYNs).
            ui.write(ev.type, ev.code, ev.value)
