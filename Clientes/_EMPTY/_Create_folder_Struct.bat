@echo OFF
chcp 65001

TITLE Bienvenid@ %USERNAME%
MODE con:cols=80 lines=40

:inicio
SET /a var=0
cls
echo ------------------------------------------------------------------------------
echo  1    Crear estructura valoración 
echo  2    Crear estructura traspaso (Deployment MULTITENANT)
echo  3    Crear estructura database (Artemis)
echo  4    Crear estructura database (Deployment)
echo  5    Crear estructura website (Artemis)
echo  6    Crear estructura website (Deployment)
echo  7    Crear estructura database+website (Artemis) 
echo  8    Crear estructura database+website (Deployment) 
echo  9    Abrir transfer_user 
echo.
echo  0    Salir
echo ------------------------------------------------------------------------------
echo.

SET /p var= ^> Seleccione una opcion [0-9]:

if "%var%"=="0" (
    goto salir
) else if "%var%"=="9" (
    goto abrir_transfer_user
) else (
    goto creacion
)

::Mensaje de error, validación cuando se selecciona una opción fuera de rango
echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto :inicio

:abrir_transfer_user
    ".\_Structure\Script Transfer User.txt"
    goto salir

:creacion
    if "%var%"=="1" (
        set Val="VAL "
    )
    set File=Counter

    ::set Build=
    ::    for /f "delims=*" %%a in (%File%) do (
    ::      set version=%%a
    ::      set Build=!Build!!version!
    ::    )
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
        copy ".\_Structure\YYYYMMDD - Solucion propuesta.docx" .\Valoracion\
        
        goto salir
    )
    
    copy "..\..\Meta4_Transfer.xlsb" .\"Meta4_Transfer_"%Counter%"_"%date:~6,4%%date:~3,2%%date:~0,2%".xlsb"
    
    :: set "copyBlank_="
    set "deliverMDB_="
    set "deliverESS_="
    set "deliverMDBESS_="
    set "dirM4database="
    set "dirM4databasePEOPLENET="
    set "dirM4website="
    set "dirM4websitePEOPLENET="
    
    if "%var%"=="3" (
        :: set copyBlank_=1
        set deliverMDB_=1
        set dirM4database=1
    )
    if "%var%"=="4" (
        :: set copyBlank_=1
        set deliverMDB_=1
        set dirM4database=1
        set dirM4databasePEOPLENET=1
    )
    if "%var%"=="5" (
        set deliverESS_=1
        set dirM4website=1
    )
    if "%var%"=="6" (
        set deliverESS_=1
        set dirM4website=1
        set dirM4websitePEOPLENET=1
    )
    
    if "%var%"=="7" (
        :: set copyBlank_=1
        set deliverMDBESS_=1
        set dirM4database=1
        set dirM4website=1
    )
    if "%var%"=="8" (
        :: set copyBlank_=1
        set deliverMDBESS_=1
        set dirM4database=1
        set dirM4databasePEOPLENET=1
        set dirM4website=1
        set dirM4websitePEOPLENET=1
    )
    
    
    :: IF defined copyBlank_ copy ..\Blank_M4T_MDB.mdb .\"M4T_MDB.mdb"
    IF defined deliverMDB_ set sDeliveryPath=".\delivery.mdb_"%date:~6,4%%date:~3,2%%date:~0,2%
    IF defined deliverESS_ set sDeliveryPath=".\delivery.ess_"%date:~6,4%%date:~3,2%%date:~0,2%
    IF defined deliverMDBESS_ set sDeliveryPath=".\delivery.mdb_ess_"%date:~6,4%%date:~3,2%%date:~0,2%
    
    IF defined sDeliveryPath (
        MkDir %sDeliveryPath%
        cd %sDeliveryPath%
        
        IF defined dirM4database MkDir ".\m4database\"
        IF defined dirM4databasePEOPLENET MkDir ".\m4database\PEOPLENET\"
        IF defined dirM4website MkDir ".\m4website\"
        IF defined dirM4websitePEOPLENET MkDir ".\m4website\PEOPLENET\"
    )
    
    if "%var%"=="2" MkDir ".\Capturas_Traspaso"
    if "%var%"=="2" MkDir ".\Documentación"
    if "%var%"=="2" MkDir ".\Pruebas"
    
    
:salir
    @cls&exit 

