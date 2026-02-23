@echo OFF

Set bError=0

::Comprobaciones
IF %1.==. (
    echo No se ha pasado un fichero de paquetes de RamDL a traspasar.
	pause
    Set bError=1
)

if %bError%==1 Goto END


cmd /c powershell.exe ".\Find_RamDL_And_Run_INI.ps1" %1


:END