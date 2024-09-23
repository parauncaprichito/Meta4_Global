@echo OFF

TITLE Bienvenid@ %USERNAME%
MODE con:cols=80 lines=40

:inicio
SET /a var=0
cls
echo ------------------------------------------------------------------------------
echo  1    Crear estructura valoracion  
echo  2    Crear estructura database (Artemis)
echo  3    Crear estructura database (Deployment)
echo  4    Crear estructura website (Artemis)
echo  5    Crear estructura website (Deployment)
echo  6    Crear estructura database+website (Artemis) 
echo  7    Crear estructura database+website (Deployment) 
echo.
echo  0    Salir
echo ------------------------------------------------------------------------------
echo.

SET /p var= ^> Seleccione una opcion [0-7]:

if "%var%"=="0" (
    goto salir
) else goto creacion

::Mensaje de error, validación cuando se selecciona una opción fuera de rango
echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto:inicio


:creacion
	if "%var%"=="1" (
        set Val="VAL "
    )
    set File=Counter

	::set Build=
	::	for /f "delims=*" %%a in (%File%) do (
	::	  set version=%%a
	::	  set Build=!Build!!version!
	::	)
	::ECHO %version%
	::set /A Counter=%version%
	
	set /p Build=<%File%
	::ECHO :::: %Build%
	
    set /A Counter=%Build%
	::echo ::%Counter%
    set /A Counter=Counter+1
	::echo :::%Counter%
	
    echo %Counter% > %File%
	

    SET Counter=000000%Counter%
    SET Counter=%Counter:~-6%

	:: echo %var%

    set Folder=%Counter%" - "%date:~6,4%%date:~3,2%%date:~0,2%"_Caso_XXXXXXXX "%Val%"DESCRIPCION"
	:: echo %Folder%
	
    MkDir %Folder%
    cd %Folder%
	
	if "%var%"=="1" (
        MkDir ".\Requerimientos\"
        copy ..\Valoracion.docx .\Valoracion\
		
		goto salir
    )
	
	copy ..\Meta4_Transfer.xlsb .\"Meta4_Transfer_"%Counter%".xlsb"
	
    
	if "%var%"=="2" (
		set sDeliveryPath=".\delivery.mdb_"%date:~6,4%%date:~3,2%%date:~0,2%
		copy ..\Blank_M4T_MDB.mdb .\"M4T_MDB.mdb"
	)
    if "%var%"=="3" (
		set sDeliveryPath=".\delivery.mdb_"%date:~6,4%%date:~3,2%%date:~0,2%
		copy ..\Blank_M4T_MDB.mdb .\"M4T_MDB.mdb"
	)
    
    if "%var%"=="4" (
		set sDeliveryPath=".\delivery.ess_"%date:~6,4%%date:~3,2%%date:~0,2%
	)
    if "%var%"=="5" (
		set sDeliveryPath=".\delivery.ess_"%date:~6,4%%date:~3,2%%date:~0,2%
	)
    
	if "%var%"=="6" (
		set sDeliveryPath=".\delivery.mdb_ess_"%date:~6,4%%date:~3,2%%date:~0,2%
        copy ..\Blank_M4T_MDB.mdb .\"M4T_MDB.mdb"
	)
	if "%var%"=="7" (
		set sDeliveryPath=".\delivery.mdb_ess_"%date:~6,4%%date:~3,2%%date:~0,2%
        copy ..\Blank_M4T_MDB.mdb .\"M4T_MDB.mdb"
	)
	
    
	MkDir %sDeliveryPath%
	cd %sDeliveryPath%
	
	if "%var%"=="2" (
        MkDir ".\m4database\"
    )
    if "%var%"=="3" (
        MkDir ".\m4database\"
        MkDir ".\m4database\PEOPLENET\"
        ::MkDir ".\m4script\"
		::MkDir ".\m4script\_ID_SCHEME_\"
    )
	if "%var%"=="4" (
        MkDir ".\m4website\"
    )
    if "%var%"=="5" (
        MkDir ".\m4website\"
        MkDir ".\m4website\PEOPLENET\"
    )
	if "%var%"=="6" (
		MkDir ".\m4database\"
		MkDir ".\m4website\"
	)
    if "%var%"=="7" (
        MkDir ".\m4database\"
        MkDir ".\m4database\PEOPLENET\"
		MkDir ".\m4website\"
        MkDir ".\m4website\PEOPLENET\"
		::MkDir ".\m4script\"
		::MkDir ".\m4script\_ID_SCHEME_\"
	)
    
	
	
:salir
	@cls&exit 

