@echo off
echo ========================================
echo INSTALANDO CLICKABLE EFFECT SCANNER
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version clickable...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin copiado exitosamente
) else (
    echo    ✗ Error copiando plugin
    pause
    exit /b 1
)

echo.
echo 3. Habilitando extensiones no firmadas...
regedit /s "%~dp0enable_unsigned_extensions.reg" >nul 2>&1
echo    ✓ Extensiones no firmadas habilitadas

echo.
echo ========================================
echo INSTALACION COMPLETA
echo ========================================
echo.
echo NUEVA FUNCIONALIDAD:
echo - Haz click en cualquier efecto de la lista
echo - Se aplicara automaticamente al layer activo
echo - Mensajes de estado en tiempo real
echo.
echo COMO USAR:
echo 1. Selecciona una composicion
echo 2. Selecciona un layer
echo 3. Haz click en cualquier efecto de la lista
echo 4. El efecto se aplicara al layer
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Haz click en cualquier efecto para aplicarlo
echo.
pause
