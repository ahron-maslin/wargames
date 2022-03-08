import os
import json
import subprocess

def usage():
    print(
        """
    Welcome to wargames!

    1) for Bandit
    2) for Leviathan
    3) for Krypton
    4) for Narnia
    """
    )

game_info = [('bandit', 2220), ('leviathan', 2223), ('krypton', 2231), ('narnia', 2226) ]

def ssh_wrapper(game, port, level):
     subprocess.call(["ssh", f'{game}{level}@{game}.labs.overthewire.org', f'-p {port}'])

usage()



game_choice = int(input("Which game would you like to play? "))
if str(game_choice) not in '1234':
    print("not a valid game")
print(f'Selected game: {game_info[game_choice-1][0]}')
level = int(input("Which level? "))


while True:
    ssh_wrapper(game_info[game_choice-1][0], game_info[game_choice-1][1], level)
    level = level + 1
