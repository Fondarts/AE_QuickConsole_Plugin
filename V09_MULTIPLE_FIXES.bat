@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V09 MULTIPLE FIXES
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V09 MULTIPLE FIXES...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V09 MULTIPLE FIXES copiado exitosamente
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
echo INSTALACION V09 MULTIPLE FIXES COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V09:
echo - Agrega "AuxChannelExtract" -> "3D Channel Extract"
echo - Corrige efectos CC que fallaban:
echo   - "BallAction" -> "CC Ball Action"
echo   - "BendIt" -> "CC Bend It"
echo - Mantiene todas las correcciones anteriores:
echo   - Efectos CC (CC Composite, CC Bubbles, etc.)
echo   - Efectos de audio (Bass & Treble, Stereo Mixer, etc.)
echo   - Efectos con espacios (3D Glasses, Audio Spectrum, etc.)
echo   - Add Grain, Apply Color Lut
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
echo 4. Deberia mostrar "Simple Effect Scanner V09"
echo 5. Busca "3D Channel Extract", "CC Ball Action", "CC Bend It"
echo 6. Prueba aplicar estos efectos - deberian funcionar!
echo.
pause
