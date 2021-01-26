@echo off
setlocal enableextensions enabledelayedexpansion
:start
cls

set game=""
set port=0

echo    b for Bandit
echo ___________________
echo    l for Leviathan
echo ___________________
echo    k for Krypton
echo ___________________
echo    n for Narnia
echo ___________________
echo.

IF exist save.txt (type save.txt) ELSE GOTO makefile

:main
rem enter game name and branches port
echo.
set /p challenge=Enter challenge letter:
if %challenge%==b (
    set game=bandit
    set port=2220
) else if %challenge%==l (
    set game=leviathan
    set port=2223
) else if %challenge%==k (
    set game=krypton
    set port=2231
) else if %challenge%==n (
    set game=narnia
    set port=2226
) else (
    echo Not a challenge!
    goto main )

:level
rem ssh into level with selected game and specified port
set /p number=Enter level number: 
rem test if input is a number
echo %number%| findstr /r "^[1-9][0-9]*$">nul
if %errorlevel% equ 0 (
    ssh %game%%number%@%game%.labs.overthewire.org -p %port%
) else (
    echo Not a number!
    goto level
)

goto savelvl

:makefile
rem if savefile doesn't exist, create it with the following template
echo last level is: for bandit> save.txt
echo last level is: for leviathan>> save.txt
echo last level is: for krypton>> save.txt
echo last level is: for narnia>> save.txt 
type save.txt	
goto main

:savelvl
rem save the specified level on current game
Set infile=save.txt
rem get number by parsing string - save to var
Set replace=last level is: %number% for %game%
for /F "tokens=* delims=," %%n in (!infile!) do (
set LINE=%%n
set TMPR=!LINE:*%game%=%replace%!
echo !TMPR!>>tmp.txt
)
del %infile%
ren tmp.txt %infile%
GOTO main
