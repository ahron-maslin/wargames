#!/usr/bin/env python3
import signal
import subprocess


def usage():
    print(
        """
    Welcome to wargames!

    1) for Bandit
    2) for Leviathan
    3) for Krypton
    4) for Narnia
    5) for Behemoth
    6) for Utumno
    7) for Maze
    8) for Vortex
    9) for Semtex
    10) for Manpage
    11) for Drifter
    """
    )


GAME_INFO = [('bandit', 2220), ('leviathan', 2223), ('krypton', 2231),
             ('narnia', 2226), ('behemoth', 2221), ('utumno', 2227), 
             ('maze', 2225), ('vortex', 2228), ('semtex', 2229), 
             ('manpage', 2224), ('drifter', 2230)]


def cleanup(signum, frame):  # ctrl-c handler
    print(f'Last completed level was: {level} on game: {GAME_INFO[chosen_game-1][0]}')
    exit(1)


signal.signal(signal.SIGINT, cleanup)


def ssh_wrapper(game, port, level):
    subprocess.call(
        ["ssh", f'{game}{level}@{game}.labs.overthewire.org', f'-p {port}'])

usage()

chosen_game = int(input("Which game would you like to play? "))
if GAME_INFO[chosen_game-1][0] is None:
    print('Not a valid game')

print(f'Selected game: {GAME_INFO[chosen_game-1][0]}')
level = int(input("Which level? "))


while True:
    ssh_wrapper(GAME_INFO[chosen_game-1][0],
                GAME_INFO[chosen_game-1][1], level)
    level = level + 1
