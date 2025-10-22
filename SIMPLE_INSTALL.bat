@echo off
echo ========================================
echo INSTALANDO SIMPLE EFFECT SCANNER
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version simple...
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
echo ESTE PLUGIN SIMPLE:
echo - Solo escanea 2 carpetas especificas
echo - Muestra la lista de efectos en la ventana
echo - No hace nada mas
echo.
echo CARPETAS ESCANEADAS:
echo - C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\Plug-ins
echo - C:\Program Files\Adobe\Common\Plug-ins\7.0\MediaCore
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberias ver la lista de efectos en la ventana
echo.
pause
