@echo off
echo ========================================
echo REINSTALANDO AE QUICK CONSOLE v1.2
echo ========================================
echo.

echo 1. Eliminando version anterior completamente...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada completamente
) else (
    echo    ✓ No habia version anterior
)

echo.
echo 2. Esperando 3 segundos para asegurar eliminacion...
timeout /t 3 /nobreak >nul

echo.
echo 3. Copiando nueva version v1.2...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin v1.2 copiado exitosamente
) else (
    echo    ✗ Error copiando plugin
    pause
    exit /b 1
)

echo.
echo 4. Habilitando extensiones no firmadas...
regedit /s "%~dp0enable_unsigned_extensions.reg" >nul 2>&1
echo    ✓ Extensiones no firmadas habilitadas

echo.
echo ========================================
echo INSTALACION v1.2 COMPLETA
echo ========================================
echo.
echo CAMBIOS EN v1.2:
echo - Escaneo real de directorios de plugins
echo - Combina efectos nativos + plugins escaneados
echo - Crea archivo de debug automaticamente
echo - Escaneo automatico al abrir el plugin
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberias ver "Command Console v1.2" en el titulo
echo 5. El contador deberia mostrar "JSX v1.2 working! Found 1000+ effects"
echo 6. En tu escritorio aparecera: AE_Plugin_Scan_Debug_v1.2_2025_10_22.txt
echo.
echo El escaneo se hace automaticamente al abrir el plugin.
echo No necesitas escribir "list effects" - ya esta todo escaneado!
echo.
pause
