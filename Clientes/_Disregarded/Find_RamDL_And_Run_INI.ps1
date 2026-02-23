$Meta4PeoplenetPath = ""
$ErrorFlag = 0

# Comprobaciones
if ($args.Count -eq 0) {
    Write-Host "No se ha pasado un fichero de paquetes de RamDL a traspasar."
    $ErrorFlag = 1
}

# Obtenemos la ruta de instalación de Meta4 Peoplenet
$xmlFile = New-Object -ComObject Microsoft.XMLDOM
if ($xmlFile.Load("C:\ProgramData\meta4\regmeta4.xml")) {
	$clientPath = $xmlFile.SelectNodes("/HKEY_LOCAL_MACHINE/SOFTWARE/Meta4/PeopleNet/CLIENT/CLIENT")[0].getAttribute("Path")
	if ($clientPath -like "*\M4PeopleNet.exe") {
		$clientPath = $clientPath -replace "\\M4PeopleNet.exe", ""
	} elseif ($clientPath -like "*\M4Mind.exe") {
		$clientPath = $clientPath -replace "\\M4Mind.exe", ""
	}

	$ramDLApp = "RamDL.exe"
	if (Test-Path "$clientPath\M4RamDL.exe") {
		$ramDLApp = "M4RAMDL.exe"
	}

	# Resolvemos la ruta de RamDL
	$Meta4PeoplenetPath = ($clientPath + "\" + $ramDLApp);

	# Necesitamos generar una copia temporal del fichero INI para reemplazar la ruta relativa e indicar una ruta completa
	$TemporaryFile = "$($args[0]).tmp"
	$CurrentDirectory = Split-Path -Path $args[0] -Parent
	$StringToReplace = ".\"

	# Eliminamos fichero temporal
	if (Test-Path $TemporaryFile) {
		Remove-Item $TemporaryFile
	}

	# Insertamos el contenido del fichero INI pasado al temporal reemplazando las rutas relativas por el path del fichero INI pasado
	Get-Content $args[0] | ForEach-Object {
		$Line = $_
		$Line = $Line -replace [regex]::Escape($StringToReplace), $CurrentDirectory
		Add-Content -Path $TemporaryFile -Value $Line
	}

	# Ejecutamos RamDL con el fichero desatendido creado temporalmente
	Start-Process -FilePath $Meta4PeoplenetPath -ArgumentList $TemporaryFile -Wait

	# Eliminamos fichero temporal
	Remove-Item $TemporaryFile
} else {
	Write-Host "No se ha encontrado el fichero C:\ProgramData\meta4\regmeta4.xml"
}