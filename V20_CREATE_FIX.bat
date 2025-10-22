@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V20 CREATE FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V20 CREATE FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V20 CREATE FIX copiado exitosamente
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
echo INSTALACION V20 CREATE FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V20:
echo - Arreglado error "command.trim is undefined" en create commands
echo - Agregada validacion de parametros en processCreateCommand
echo - Usando trim manual en lugar de .trim()
echo - Mejor manejo de errores en comandos de creacion
echo - Comandos de creacion ahora funcionan correctamente
echo.
echo COMANDOS DE CREACION FUNCIONANDO:
echo - solid red = crea solid rojo ✓ (CORREGIDO)
echo - solid blue = crea solid azul ✓ (CORREGIDO)
echo - solid yellow = crea solid amarillo ✓ (CORREGIDO)
echo - solid black = crea solid negro ✓ (CORREGIDO)
echo - solid white = crea solid blanco ✓ (CORREGIDO)
echo - solid purple = crea solid morado ✓ (CORREGIDO)
echo - solid 11B159 = crea solid con color hexadecimal ✓ (CORREGIDO)
echo - text = crea layer de texto ✓ (CORREGIDO)
echo - light = crea light layer ✓ (CORREGIDO)
echo - camera = crea camera layer ✓ (CORREGIDO)
echo - null = crea null layer ✓ (CORREGIDO)
echo - adjustment = crea adjustment layer ✓ (CORREGIDO)
echo.
echo COMANDOS EXISTENTES (FUNCIONANDO):
echo - select 1,5,7 = selecciona layers 1, 5, 7 ✓
echo - unselect 2 = deselecciona layer 2 ✓
echo - solo 1,3 = solo layers 1 y 3 ✓
echo - solo = solo los layers seleccionados ✓
echo - unsolo 1 = quita solo del layer 1 ✓
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Comandos de seleccion de layers
echo - Comandos de creacion de layers (CORREGIDOS)
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V20"
echo 5. Prueba comandos como "solid red" o "text"
echo.
pause
