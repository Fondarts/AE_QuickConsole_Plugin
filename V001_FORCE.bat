@echo off
echo ========================================
echo REINSTALANDO AE QUICK CONSOLE v1.0
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
echo 2. Esperando 2 segundos para asegurar eliminacion...
timeout /t 2 /nobreak >nul

echo.
echo 3. Copiando nueva version v1.0...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin v1.0 copiado exitosamente
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
echo INSTALACION v1.0 COMPLETA
echo ========================================
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberias ver "Command Console v1.0" en el titulo
echo 5. El contador deberia mostrar "JSX v1.0 working! Found X effects"
echo.
echo Si sigue apareciendo la version anterior:
echo - Cierra After Effects
echo - Borra manualmente: C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin
echo - Ejecuta este script de nuevo
echo.
pause
