@echo off
setlocal enableextensions enabledelayedexpansion
:start
cls

set game=""
set port=0
rem todo...
rem check IF number 

echo    B for Bandit
echo ___________________
echo    L for Leviathan
echo ___________________
echo    K for Krypton
echo ___________________
echo    N for Narnia
echo ___________________
echo.

IF exist save.txt (type save.txt) ELSE GOTO makefile

:main
rem enter game name and branches port
echo.
set /p challenge=Enter challenge letter:
if %challenge%==b (
    set game=Bandit
    set port=2220
) else if %challenge%==l (
    set game=Leviathan
    set port=2223
) else if %challenge%==k (
    set game=Krypton
    set port=2231
) else if %challenge%==n (
    set game=Narnia
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
echo Bandit> save.txt
echo Leviathan>> save.txt
echo Krypton>> save.txt
echo Narnia>> save.txt 
goto main

:savelvl
rem save the specified level on current game
Set infile=save.txt
Set replace=%game% last level is: %number%
for /F "tokens=* delims=," %%n in (!infile!) do (
set LINE=%%n
set TMPR=!LINE:%game%=%replace%!
Echo !TMPR!>>tmp.txt
)
del %infile%
ren tmp.txt %infile%
GOTO main

