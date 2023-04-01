@echo off

md "%~n1"

move "%1" "%~n1"

echo %~dpn1\%~nx1 > test.txt

start /wait width.au3

set /p divisions=< test.txt

split-image "%~dpn1\%~nx1" %divisions% 1

del "%~dpn1\%~nx1"

del test.txt

pause