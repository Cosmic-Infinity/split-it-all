@echo off

if "%~1"=="" echo Only Drag and Drop allowed&pause&exit

md "%~n1"

move "%1" "%~n1"

rem echo "%~dpn1\%~nx1" > test.txt
echo %~dp1%~n1\%~nx1> test.txt

start /wait width.exe

set /p divisions=< test.txt

split-image "%~dp1%~n1\%~nx1" %divisions% 1

del "%~dp1%~n1\%~nx1"

del test.txt

pause