@echo off
rem Ejecutar todos los scripts SQL en orden
setlocal

rem Cambiar por el nombre de tu instancia a SQL Server
set "SERVER=."
set "AUTH=-E"
set "SQLCMD=sqlcmd"
set "SCRIPTS_DIR=%~dp0"

echo.
echo ============================
echo Ejecutando Scripts 1: Crear Base de Datos
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d master -i "%SCRIPTS_DIR%PT01_01_CDB_FJRL.sql" -b
if errorlevel 1 goto error

rem Cambia por el nombre de la bd que crea tu script
set "DB=Control_Escolar"

echo.
echo ============================
echo Ejecutando Scripts 2: Crear Tablas
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_02_CT_FJRL.sql" -b
if errorlevel 1 goto error

echo.
echo ============================
echo Ejecutando Scripts 3: Carga inicial
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_03_INS_FJRL.sql" -b
if errorlevel 1 goto error

echo.
echo ============================
echo Ejecutando Scripts 4: Vistas
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_04_VW_FJRL.sql" -b
if errorlevel 1 goto error

echo.
echo ============================
echo Ejecutando Scripts 5: Procedimientos Almacenados
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_05_SP_FJRL.sql" -b
if errorlevel 1 goto error


echo.
echo ============================
echo Los scripts se ejecutaron correctamente.
echo ============================
pause
goto end

:error
echo.
echo ============================
echo Error: Fallo en la ejecucion de los scripts.
echo Revisa el mensaje anterior para obtener mas detalles.
echo ============================
pause

:end
endlocal
