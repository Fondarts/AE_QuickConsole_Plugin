@echo off
echo ========================================
echo INSTALANDO SEARCHABLE EFFECT SCANNER
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version con busqueda...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin copiado exitosamente
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
echo INSTALACION COMPLETA
echo ========================================
echo.
echo NUEVA FUNCIONALIDAD:
echo - Barra de busqueda en la parte superior
echo - Filtrado en tiempo real mientras escribes
echo - Haz click en cualquier efecto para aplicarlo
echo - Contador de efectos mostrados
echo.
echo COMO USAR:
echo 1. Selecciona una composicion
echo 2. Selecciona un layer
echo 3. Escribe en la barra de busqueda para filtrar
echo 4. Haz click en cualquier efecto de la lista
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Prueba la barra de busqueda y los clicks
echo.
pause
