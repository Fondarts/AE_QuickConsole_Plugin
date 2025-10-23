@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V13 LAYER COMMANDS
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V13 LAYER COMMANDS...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V13 LAYER COMMANDS copiado exitosamente
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
echo INSTALACION V13 LAYER COMMANDS COMPLETA
echo ========================================
echo.
echo NUEVAS FUNCIONALIDADES EN V13:
echo - Comandos de seleccion de layers:
echo   - select +1,5,7 = selecciona layers 1, 5, 7
echo   - solo +1,3 = solo layers 1 y 3
echo   - unselect +2 = deselecciona layer 2
echo   - unsolo +1 = quita solo del layer 1
echo - Campo de comandos con boton Execute
echo - Soporte para Enter para ejecutar comandos
echo - Mantiene todas las correcciones anteriores
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Comandos de seleccion de layers
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V13"
echo 5. Prueba comandos como "select +1,3" o "solo +2"
echo.
pause

