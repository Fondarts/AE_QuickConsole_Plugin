@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V22 UNIFIED LIST
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V22 UNIFIED LIST...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V22 UNIFIED LIST copiado exitosamente
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
echo INSTALACION V22 UNIFIED LIST COMPLETA
echo ========================================
echo.
echo NUEVAS FUNCIONALIDADES EN V22:
echo - Comandos de creacion integrados en la lista de efectos
echo - Busqueda unificada: efectos Y comandos en el mismo lugar
echo - Haz click en cualquier comando para ejecutarlo
echo - Filtrado en tiempo real de efectos y comandos
echo - Interfaz unificada y mas intuitiva
echo.
echo COMANDOS EN LA LISTA:
echo - solid red, solid blue, solid yellow, solid black, solid white
echo - solid purple, solid green, solid orange, solid pink, solid cyan
echo - solid magenta, solid gray
echo - text, light, camera, null, adjustment layer
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 17 comandos de creacion
echo - Barra de busqueda unificada (efectos y comandos)
echo - Haz click en cualquier efecto o comando para aplicarlo/ejecutarlo
echo - Comandos de seleccion de layers (campo separado)
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V22"
echo 5. Busca "solid red" o "text" en la lista y haz click
echo.
pause

