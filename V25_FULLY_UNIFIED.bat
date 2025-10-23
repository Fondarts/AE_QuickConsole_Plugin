@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V25 FULLY UNIFIED
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V25 FULLY UNIFIED...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V25 FULLY UNIFIED copiado exitosamente
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
echo INSTALACION V25 FULLY UNIFIED COMPLETA
echo ========================================
echo.
echo NUEVAS FUNCIONALIDADES EN V25:
echo - Comandos de seleccion integrados en la lista
echo - select 1, select 2, select 3, select 4, select 5
echo - solo 1, solo 2, solo 3, solo 4, solo 5, solo selected
echo - unselect 1, unselect 2, unselect 3, unselect 4, unselect 5
echo - unsolo 1, unsolo 2, unsolo 3, unsolo 4, unsolo 5
echo - Interfaz completamente unificada
echo - Todo desde la misma barra de busqueda
echo.
echo COMANDOS EN LA LISTA:
echo - Creacion: solid red, text, light, camera, null, adjustment layer
echo - Seleccion: select 1-5, solo 1-5, solo selected, unselect 1-5, unsolo 1-5
echo - Efectos: 735+ efectos de After Effects
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 42 comandos (creacion + seleccion)
echo - Barra de busqueda completamente unificada
echo - Ordenamiento inteligente (coincidencias exactas primero)
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
echo 4. Deberia mostrar "Simple Effect Scanner V25"
echo 5. Busca "select" o "solo" y haz click
echo.
pause

