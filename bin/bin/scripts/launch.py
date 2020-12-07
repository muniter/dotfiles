import argparse
from i3ipc import Connection, Event

# 1. Call the script as a command, passing the selection criteria
# and the sway command to execute, and optionally a timer.
# Get the sway socket and subscribe to window commands, and wait
# Until a window event is received that mathces the passed criteria
# or times out, and the optional timer is how much time will it wait
# for subsequent events of the same criteria.

def new_window(sway, e, command=''):
    '''This executes a command in a new window that
    matches the given expression'''
    con = e.container
    resp = con.command(command)
    [r for r in resp if resp.success]


def main():
    sway = Connection()
    sway.on(Event.WINDOW_NEW, new_window)
    sway.main()

if __name__ == "__main__":
    main()
    parser = argparse.ArgumentParser(
            description='Execute [command] to new [window] matching criteria.')
    parser.add_argument('criteria',
