@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V26 TWO STEP COMMANDS
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V26 TWO STEP COMMANDS...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V26 TWO STEP COMMANDS copiado exitosamente
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
echo INSTALACION V26 TWO STEP COMMANDS COMPLETA
echo ========================================
echo.
echo NUEVAS FUNCIONALIDADES EN V26:
echo - Comandos de dos pasos para select/solo/unselect/unsolo
echo - Solo un comando de cada tipo en la lista (no multiples)
echo - Flujo de trabajo con Enter:
echo   1. Escribe "solo" + Enter
echo   2. Escribe "1,2,4" + Enter (o Enter sin numeros para selected)
echo   3. Se ejecuta "solo 1,2,4"
echo - Interfaz mas limpia y eficiente
echo.
echo COMANDOS EN LA LISTA:
echo - Creacion: solid red, text, light, camera, null, adjustment layer
echo - Seleccion: select, solo, unselect, unsolo (solo uno de cada)
echo - Efectos: 735+ efectos de After Effects
echo.
echo COMO USAR:
echo 1. Escribe "solo" + Enter
echo 2. Escribe "1,2,4" + Enter = ejecuta "solo 1,2,4"
echo 3. O presiona Enter sin numeros = ejecuta "solo" (selected layers)
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 9 comandos (4 creacion + 4 seleccion + 1 adjustment)
echo - Barra de busqueda completamente unificada
echo - Ordenamiento inteligente (coincidencias exactas primero)
echo - Comandos de dos pasos (NUEVO)
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
echo 4. Deberia mostrar "Simple Effect Scanner V26"
echo 5. Prueba: escribe "solo" + Enter + "1,2,4" + Enter
echo.
pause

