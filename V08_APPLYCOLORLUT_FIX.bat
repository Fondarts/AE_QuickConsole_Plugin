@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V08 APPLYCOLORLUT FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V08 APPLYCOLORLUT FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V08 APPLYCOLORLUT FIX copiado exitosamente
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
echo INSTALACION V08 APPLYCOLORLUT FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V08:
echo - Agrega "ApplyColorLUT" -> "Apply Color Lut" al mapeo
echo - "ApplyColorLUT" ahora se convierte en "Apply Color Lut"
echo - Mantiene todas las correcciones anteriores:
echo   - Efectos CC (CC Composite, CC Bubbles, etc.)
echo   - Efectos de audio (Bass & Treble, Stereo Mixer, etc.)
echo   - Efectos con espacios (3D Glasses, Audio Spectrum, etc.)
echo   - Add Grain, AddGrain -> Add Grain
echo   - Decodificacion URL (%%20 -> espacios)
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
echo 4. Deberia mostrar "Simple Effect Scanner V08"
echo 5. Busca "Apply Color Lut" (con espacios y Lut en minuscula)
echo 6. Prueba aplicar "Apply Color Lut" - deberia funcionar!
echo.
pause
