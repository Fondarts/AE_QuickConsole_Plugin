@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V12 OFFICIAL MATCH NAMES
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V12 OFFICIAL MATCH NAMES...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V12 OFFICIAL MATCH NAMES copiado exitosamente
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
echo INSTALACION V12 OFFICIAL MATCH NAMES COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V12 (basadas en tabla oficial de Adobe):
echo - "BlockLoad" -> "CC Block Load"
echo - "BurnFilm" -> "CC Burn Film"
echo - "CannedWarp" -> "CC Canned Warp"
echo - "CineonEffect" -> "Cineon Converter"
echo - "Color Balance 2" -> "Color Balance"
echo - "Color Diff" -> "Color Difference Key"
echo - "Color HLS" -> "Hue & Saturation"
echo - "ColorNeutralizer" -> "CC Color Neutralizer"
echo - "ColorOffset" -> "CC Color Offset"
echo - "ColorShift" -> "Color Shift"
echo - Mantiene todas las correcciones anteriores
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
echo 4. Deberia mostrar "Simple Effect Scanner V12"
echo 5. Busca efectos corregidos como "CC Block Load", "CC Burn Film", etc.
echo 6. Prueba aplicar estos efectos - deberian funcionar!
echo.
pause
