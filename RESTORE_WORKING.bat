@echo off
echo ========================================
echo RESTAURANDO VERSION QUE FUNCIONABA
echo ========================================
echo.

echo 1. Eliminando version rota...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version rota eliminada
)

echo.
echo 2. Copiando version que funcionaba...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Version que funcionaba copiada exitosamente
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
echo RESTAURACION COMPLETA
echo ========================================
echo.
echo ESTA VERSION:
echo - Encuentra 735 efectos (como antes)
echo - Barra de busqueda funciona
echo - Click en efectos funciona
echo - Boton export funciona
echo - Excluye carpetas problematicas
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia encontrar 735 efectos otra vez
echo.
pause
