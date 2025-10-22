@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V03 SMART CC FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V03 SMART CC FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V03 SMART CC FIX copiado exitosamente
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
echo INSTALACION V03 SMART CC FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V03 SMART CC FIX:
echo - Solucion inteligente para efectos CC
echo - Detecta patron "CC" + letra mayuscula
echo - "CCComposite" se convierte en "CC Composite"
echo - "CCBubbles" se convierte en "CC Bubbles"
echo - Solo afecta efectos que realmente necesitan el espacio
echo - No rompe efectos que ya tienen formato correcto
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V03"
echo 5. Busca "CC Composite" y "CC Bubbles" en la lista
echo.
pause
