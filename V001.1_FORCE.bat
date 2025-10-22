@echo off
echo ========================================
echo REINSTALANDO AE QUICK CONSOLE v1.1
echo ========================================
echo.

echo 1. Eliminando version anterior completamente...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada completamente
) else (
    echo    ✓ No habia version anterior
)

echo.
echo 2. Esperando 3 segundos para asegurar eliminacion...
timeout /t 3 /nobreak >nul

echo.
echo 3. Copiando nueva version v1.1...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin v1.1 copiado exitosamente
) else (
    echo    ✗ Error copiando plugin
    pause
    exit /b 1
)

echo.
echo 4. Habilitando extensiones no firmadas...
regedit /s "%~dp0enable_unsigned_extensions.reg" >nul 2>&1
echo    ✓ Extensiones no firmadas habilitadas

echo.
echo ========================================
echo INSTALACION v1.1 COMPLETA
echo ========================================
echo.
echo CAMBIOS EN v1.1:
echo - JSX ultra-simple para probar comunicacion
echo - Mejor manejo de errores en HTML
echo - Reintentos automaticos de comunicacion
echo - Logs en consola del navegador
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberias ver "Command Console v1.1" en el titulo
echo 5. El contador deberia mostrar "JSX Test: JSX v1.1 is working!"
echo.
echo Si sigue "JSX not responding...":
echo - Abre las herramientas de desarrollador (F12)
echo - Ve a la consola y mira los errores
echo - Reporta que errores aparecen
echo.
pause
