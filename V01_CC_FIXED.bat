@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V01 CC FIXED
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V01 CC FIXED...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V01 CC FIXED copiado exitosamente
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
echo INSTALACION V01 CC FIXED COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V01 CC FIXED:
echo - Preserva prefijo "CC" en efectos CC
echo - "Composite" ahora aparece como "CC Composite"
echo - "Bubbles" ahora aparece como "CC Bubbles"
echo - Todos los efectos CC mantienen su prefijo correcto
echo - Corregido ReferenceError en variaciones de nombres
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo.
echo FUNCIONALIDADES:
echo - Barra de busqueda en tiempo real
echo - Haz click en cualquier efecto para aplicarlo
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Prueba aplicar "CC Composite" y "CC Bubbles"
echo.
pause
