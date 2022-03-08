echo Usage: 
echo   "Enter b for Bandit"
echo _______________________
echo   "Enter l for Leviathan"
echo _______________________
echo   "Enter k for Krypton"
echo _______________________
echo   "Enter n for Narnia"
echo _______________________

port=0
game=""

FILE="./save.txt"

if [ $FILE does not exist ]; then
    touch $FILE
fi

read level

if $level in "blkn";
    
