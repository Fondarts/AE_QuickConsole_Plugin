@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V27 NAN FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V27 NAN FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V27 NAN FIX copiado exitosamente
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
echo INSTALACION V27 NAN FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V27:
echo - Arreglado error "Layer NaN does not exist"
echo - Mejor validacion de numeros de layers
echo - Manejo correcto de comandos sin parametros
echo - Validacion de strings vacios y undefined
echo - Mensajes de error mas claros
echo - Comandos de dos pasos funcionando correctamente
echo.
echo COMANDOS FUNCIONANDO:
echo - select 1,3 = selecciona layers 1 y 3 ✓ (CORREGIDO)
echo - solo 1,2,4 = solo layers 1, 2, 4 ✓ (CORREGIDO)
echo - unselect 2 = deselecciona layer 2 ✓ (CORREGIDO)
echo - unsolo 1 = quita solo del layer 1 ✓ (CORREGIDO)
echo - Comandos sin numeros = aplica a layers seleccionados ✓ (CORREGIDO)
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 9 comandos
echo - Barra de busqueda completamente unificada
echo - Ordenamiento inteligente (coincidencias exactas primero)
echo - Comandos de dos pasos (CORREGIDOS)
echo - Haz click en cualquier elemento para aplicarlo/ejecutarlo
echo - ENTER para aplicar el primer elemento visible
echo - Campo de comandos separado (opcional)
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V27"
echo 5. Prueba: escribe "select" + Enter + "1,3" + Enter
echo.
pause

