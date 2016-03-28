@echo off
:directory 
SET /P install=install or upgrade:
IF "%install%"=="upgrade" (choco upgrade all --noop)
REM Get installation directory from user. If nothing provided set as D:\ProgramData
SET _destination=D:\ProgramData
SET /P _destination=Enter desired installation directory. Default is %_destination%. 
echo Destination: %_destination%

:name
REM Get name of package. If name is python, python2, or python3, go to python installation's code
SET /P name=Enter name of package: 
IF "%name%"=="python" (GOTO :pythonInstall) 
IF "%name%"=="python2" (GOTO :pythonInstall) 
IF "%name%"=="python3-x86_32" (GOTO :pythonInstall)
IF "%name%"=="python3" (GOTO :pythonInstall) ELSE (GOTO :install)
pause

:install
echo Not Python
pause
echo Installing %name% at %_destination%
choco %install% %name% -override -installArguments ""/D=%_destination%\%name%""
pause
SET /P again=Do you want to install another package (Y/N):
IF "%again%"=="Y" (GOTO :name)
GOTO :eof

:pythonInstall
echo PYTHON!
pause
echo Installing %name% at %_destination%
choco %install% %name% -override -installArguments ""TARGETDIR=%_destination%\%name%""
pause
SET /P again=Do you want to install another package (Y/N):
IF "%again%"=="Y" (GOTO :name)
GOTO :eof