@echo off
echo ========================================
echo REINSTALANDO AE QUICK CONSOLE
echo ========================================
echo.

REM Get the current directory
set "CURRENT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

REM After Effects extensions folder
set "AE_EXTENSIONS=%APPDATA%\Adobe\CEP\extensions"

echo 1. Eliminando version anterior...
if exist "%AE_EXTENSIONS%\%PLUGIN_NAME%" (
    rmdir /s /q "%AE_EXTENSIONS%\%PLUGIN_NAME%"
    echo    ✓ Version anterior eliminada
) else (
    echo    ✓ No hay version anterior
)

echo.
echo 2. Copiando nueva version...
if exist "%CURRENT_DIR%" (
    xcopy "%CURRENT_DIR%" "%AE_EXTENSIONS%\%PLUGIN_NAME%" /E /I /Y
    echo    ✓ Plugin copiado a: %AE_EXTENSIONS%\%PLUGIN_NAME%
) else (
    echo    ✗ Error: No se encontro la carpeta del plugin
    pause
    exit /b 1
)

echo.
echo 3. Habilitando extensiones no firmadas...
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.9" /v "PlayerDebugMode" /t REG_SZ /d "1" /f >nul 2>&1
echo    ✓ Extensiones no firmadas habilitadas

echo.
echo ========================================
echo INSTALACION COMPLETA
echo ========================================
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Prueba el comando: null
echo.
echo Si sigue apareciendo "Command Console with Settings":
echo - Cierra After Effects
echo - Borra la carpeta: %AE_EXTENSIONS%\%PLUGIN_NAME%
echo - Ejecuta este script de nuevo
echo.
pause
