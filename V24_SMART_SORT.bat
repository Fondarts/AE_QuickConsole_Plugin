@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V24 SMART SORT
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V24 SMART SORT...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V24 SMART SORT copiado exitosamente
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
echo INSTALACION V24 SMART SORT COMPLETA
echo ========================================
echo.
echo NUEVAS FUNCIONALIDADES EN V24:
echo - Ordenamiento inteligente en busquedas
echo - Coincidencias exactas al inicio aparecen primero
echo - Efectos que contienen el termino aparecen despues
echo - Mejor experiencia de usuario en busquedas
echo.
echo EJEMPLO:
echo - Busca "solid" y veras:
echo   1. solid black (empieza con "solid")
echo   2. solid blue (empieza con "solid")
echo   3. solid red (empieza con "solid")
echo   ...
echo   X. PSL Solid Fill (contiene "solid" pero no empieza)
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 17 comandos de creacion
echo - Barra de busqueda unificada (efectos y comandos)
echo - Ordenamiento inteligente (NUEVO)
echo - Haz click en cualquier efecto o comando para aplicarlo/ejecutarlo
echo - ENTER para aplicar el primer elemento visible
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
echo 4. Deberia mostrar "Simple Effect Scanner V24"
echo 5. Busca "solid" y veras el nuevo ordenamiento
echo.
pause

