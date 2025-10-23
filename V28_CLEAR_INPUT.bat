@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V28 CLEAR INPUT
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V28 CLEAR INPUT...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V28 CLEAR INPUT copiado exitosamente
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
echo INSTALACION V28 CLEAR INPUT COMPLETA
echo ========================================
echo.
echo NUEVAS FUNCIONALIDADES EN V28:
echo - Campo de entrada se borra automaticamente
echo - Flujo de trabajo mas limpio y claro
echo - Cuando escribes "select" + Enter:
echo   - Se borra "select" del campo
echo   - Solo queda el cursor para escribir numeros
echo - Lo mismo para "solo", "unselect", "unsolo"
echo - Interfaz mas intuitiva y eficiente
echo.
echo FLUJO DE TRABAJO MEJORADO:
echo 1. Escribes "select" + Enter
echo 2. Campo se borra automaticamente
echo 3. Escribes "1,2,4" + Enter
echo 4. Se ejecuta "select 1,2,4"
echo.
echo FUNCIONALIDADES:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 9 comandos
echo - Barra de busqueda completamente unificada
echo - Ordenamiento inteligente (coincidencias exactas primero)
echo - Comandos de dos pasos con campo limpio (NUEVO)
echo - Haz click en cualquier elemento para aplicarlo/ejecutarlo
echo - ENTER para aplicar el primer elemento visible
echo - Campo de comandos separado (opcional)
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V28"
echo 5. Prueba: escribe "select" + Enter (se borra) + "1,2,4" + Enter
echo.
pause

