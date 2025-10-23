@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V03 POST-PROCESSING
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V03 POST-PROCESSING...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V03 POST-PROCESSING copiado exitosamente
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
echo INSTALACION V03 POST-PROCESSING COMPLETA
echo ========================================
echo.
echo NUEVA SOLUCION V03:
echo - NO modifica la logica de escaneo (no se rompe)
echo - Post-procesamiento: corrige nombres CC DESPUES del escaneo
echo - "Composite" se convierte en "CC Composite"
echo - "Bubbles" se convierte en "CC Bubbles"
echo - Lista completa de 50+ efectos CC mapeados
echo - Los efectos CC ahora se aplicaran correctamente
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V03"
echo 5. Busca "CC Composite" y "CC Bubbles" en la lista
echo 6. Prueba aplicar "CC Composite" - deberia funcionar!
echo.
pause

