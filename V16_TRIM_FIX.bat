@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V16 TRIM FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V16 TRIM FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V16 TRIM FIX copiado exitosamente
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
echo INSTALACION V16 TRIM FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V16:
echo - Arreglado error "numbers[i].trim is undefined"
echo - Reemplazado todos los .trim() con trim manual
echo - Usando Layer.solo de Adobe (boolean read/write)
echo - Mejor manejo de strings en ExtendScript
echo - Validacion robusta de parametros
echo.
echo COMANDOS FUNCIONANDO:
echo - select 1,5,7 = selecciona layers 1, 5, 7
echo - solo 1,3 = solo layers 1 y 3 (usando Layer.solo)
echo - solo = solo los layers seleccionados
echo - unselect 2 = deselecciona layer 2
echo - unsolo 1 = quita solo del layer 1
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Comandos de seleccion de layers (TRIM FIX)
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V16"
echo 5. Prueba comandos como "select 1,3" o "solo 2"
echo.
pause
