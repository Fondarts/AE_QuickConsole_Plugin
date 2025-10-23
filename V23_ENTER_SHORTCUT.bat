@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V23 ENTER SHORTCUT
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V23 ENTER SHORTCUT...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V23 ENTER SHORTCUT copiado exitosamente
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
echo INSTALACION V23 ENTER SHORTCUT COMPLETA
echo ========================================
echo.
echo NUEVAS FUNCIONALIDADES EN V23:
echo - Atajo de teclado ENTER en campo de busqueda
echo - Presiona ENTER para aplicar el primer elemento visible
echo - Flujo de trabajo mas rapido y eficiente
echo - Busca y aplica con solo presionar ENTER
echo.
echo COMO USAR:
echo 1. Escribe en el campo de busqueda (ej: "solid")
echo 2. Presiona ENTER
echo 3. Se aplica automaticamente el primer elemento visible
echo.
echo EJEMPLOS:
echo - Escribe "solid" + ENTER = aplica "solid red"
echo - Escribe "text" + ENTER = aplica "text"
echo - Escribe "blur" + ENTER = aplica el primer efecto blur
echo - Escribe "light" + ENTER = aplica "light"
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 17 comandos de creacion
echo - Barra de busqueda unificada (efectos y comandos)
echo - Haz click en cualquier efecto o comando para aplicarlo/ejecutarlo
echo - ENTER para aplicar el primer elemento visible (NUEVO)
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
echo 4. Deberia mostrar "Simple Effect Scanner V23"
echo 5. Escribe "solid" y presiona ENTER
echo.
pause

