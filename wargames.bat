@echo off
echo Usage: 
echo.
echo   Enter b for Bandit
echo _______________________
echo   Enter l for Leviathan
echo _______________________
echo   Enter k for Krypton
echo _______________________
echo   Enter n for Narnia
echo _______________________
echo.


:start
setlocal enableextensions enabledelayedexpansion
set game=""
set port=0
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

call :savelvl %game% %number%

:makefile
rem if savefile doesn't exist, create it with the following template
echo last level is: for Bandit> save.txt
echo last level is: for Leviathan>> save.txt
echo last level is: for Krypton>> save.txt
echo last level is: for Narnia>> save.txt 
type save.txt	
goto main

:savelvl %1 %2
rem save the specified level on current game
Set infile=save.txt
rem get number by parsing string - save to var
Set replace=last level is: %2 for %1
for /F "tokens=* delims=," %%n in (!infile!) do (
set LINE=%%n
set TMPR=!LINE:*%1=%replace%!
echo !TMPR!>>tmp.txt
)
del %infile%
ren tmp.txt %infile%
GOTO main
