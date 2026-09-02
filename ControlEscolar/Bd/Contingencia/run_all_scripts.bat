@echo off
rem Ejecutar todos los scripts de contingencia en orden (rollback completo)
setlocal

rem Cambiar por el nombre de tu instancia a SQL Server
set "SERVER=."
set "AUTH=-E"
set "SQLCMD=sqlcmd"
set "SCRIPTS_DIR=%~dp0"
set "DB=Control_Escolar"

echo.
echo ============================
echo Ejecutando Contingencia A: Eliminar Procedimientos Almacenados
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_BD_A_SP_FJRL.sql" -b
if errorlevel 1 goto error

echo.
echo ============================
echo Ejecutando Contingencia B: Eliminar Vistas
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_BD_B_VW_FJRL.sql" -b
if errorlevel 1 goto error

echo.
echo ============================
echo Ejecutando Contingencia C: Eliminar Registros (Carga Inicial)
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_BD_C_IC_FJRL.sql" -b
if errorlevel 1 goto error

echo.
echo ============================
echo Ejecutando Contingencia D: Eliminar Tablas
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d %DB% -i "%SCRIPTS_DIR%PT01_BD_D_CT_FJRL.sql" -b
if errorlevel 1 goto error

echo.
echo ============================
echo Ejecutando Contingencia E: Eliminar Base de Datos
echo ============================

%SQLCMD% -S %SERVER% %AUTH% -d master -i "%SCRIPTS_DIR%PT01_BD_E_BD_FJRL.sql" -b
if errorlevel 1 goto error


echo.
echo ============================
echo Los scripts de contingencia se ejecutaron correctamente.
echo ============================
pause
goto end

:error
echo.
echo ============================
echo Error: Fallo en la ejecucion de los scripts de contingencia.
echo Revisa el mensaje anterior para obtener mas detalles.
echo ============================
pause

:end
endlocal
