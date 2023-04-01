@echo off
if "%~1"=="" echo Only Drag and Drop allowed&pause&exit

set file=%1%
set file=%file: =_%

rem  echo %file%

FOR %%i IN ("%file%") DO (

set file2=%%~ni%%~xi

)
ren "%~1" %file2%

call split.bat %file%