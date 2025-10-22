@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V04 URL DECODE FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V04 URL DECODE FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V04 URL DECODE FIX copiado exitosamente
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
echo INSTALACION V04 URL DECODE FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V04:
echo - Decodifica espacios URL (%20) a espacios normales
echo - "3D%%20Camera%%20Tracker" se convierte en "3D Camera Tracker"
echo - "Brightness%%20Contrast" se convierte en "Brightness Contrast"
echo - Todos los efectos con %%20 ahora se aplican correctamente
echo - Mantiene todas las correcciones CC de V03
echo - Post-procesamiento seguro que no rompe el escaneo
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V04"
echo 5. Busca "3D Camera Tracker" (sin %%20)
echo 6. Prueba aplicar "3D Camera Tracker" - deberia funcionar!
echo.
pause
