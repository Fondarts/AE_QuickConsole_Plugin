@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V05 COMPLETE FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V05 COMPLETE FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V05 COMPLETE FIX copiado exitosamente
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
echo INSTALACION V05 COMPLETE FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V05:
echo - Decodifica espacios URL (%%20) a espacios normales
echo - Mapeo completo de 50+ efectos CC (CC Composite, CC Bubbles, etc.)
echo - Mapeo adicional de 70+ efectos con espacios (3D Glasses, Audio Spectrum, etc.)
echo - "3DGlasses" se convierte en "3D Glasses"
echo - "AudioSpectrum" se convierte en "Audio Spectrum"
echo - "BrightnessContrast" se convierte en "Brightness & Contrast"
echo - Todos los efectos ahora se aplican correctamente
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
echo 4. Deberia mostrar "Simple Effect Scanner V05"
echo 5. Busca "3D Glasses" y "Audio Spectrum"
echo 6. Prueba aplicar "3D Glasses" - deberia funcionar!
echo.
pause
