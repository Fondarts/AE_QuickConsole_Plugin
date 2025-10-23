@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V14 FIXED LAYER COMMANDS
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V14 FIXED LAYER COMMANDS...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V14 FIXED LAYER COMMANDS copiado exitosamente
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
echo INSTALACION V14 FIXED LAYER COMMANDS COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V14:
echo - Arreglado error "startsWith is undefined"
echo - Comandos sin el simbolo + (mas simple)
echo - "solo" sin numeros hace solo de layers seleccionados
echo - Mejor manejo de errores y validacion
echo.
echo COMANDOS CORREGIDOS:
echo - select 1,5,7 = selecciona layers 1, 5, 7
echo - solo 1,3 = solo layers 1 y 3
echo - solo = solo los layers seleccionados
echo - unselect 2 = deselecciona layer 2
echo - unsolo 1 = quita solo del layer 1
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Comandos de seleccion de layers (SIN +)
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V14"
echo 5. Prueba comandos como "select 1,3" o "solo 2"
echo.
pause

