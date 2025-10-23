@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V30 PARSING FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V30 PARSING FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V30 PARSING FIX copiado exitosamente
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
echo INSTALACION V30 PARSING FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V30:
echo - Arreglado parsing para comandos de dos palabras
echo - "motion blur" ahora funciona correctamente
echo - "3d layer" ahora funciona correctamente
echo - Eliminado error "Layer NaN does not exist"
echo - Parsing mejorado para comandos complejos
echo.
echo COMANDOS DE DOS PALABRAS CORREGIDOS:
echo - motion blur 1,2,3: Habilita motion blur en layers 1, 2 y 3
echo - 3d layer 1,2,3: Habilita 3D en layers 1, 2 y 3
echo.
echo FLUJO DE TRABAJO (DOS PASOS):
echo 1. Escribes comando + Enter (ej: "motion blur" + Enter)
echo 2. Campo se borra automaticamente
echo 3. Escribes numeros + Enter (ej: "1,2,4" + Enter)
echo 4. Se ejecuta comando completo (ej: "motion blur 1,2,4")
echo.
echo TODOS LOS COMANDOS FUNCIONANDO:
echo - select, unselect, solo, unsolo (seleccion y visibilidad)
echo - hide, show (visibilidad de layers)
echo - mute, unmute, audio (control de audio)
echo - lock, unlock (bloqueo de layers)
echo - shy, unshy (timidez de layers)
echo - motion blur (motion blur) - CORREGIDO
echo - 3d layer (3D layers) - CORREGIDO
echo - solid [color], text, light, camera, null, adjustment layer (creacion)
echo.
echo FUNCIONALIDADES COMPLETAS:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 21 comandos
echo - Barra de busqueda completamente unificada
echo - Ordenamiento inteligente (coincidencias exactas primero)
echo - Comandos de dos pasos con campo limpio
echo - Parsing mejorado para comandos complejos (NUEVO)
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
echo 4. Deberia mostrar "Simple Effect Scanner V30"
echo 5. Prueba: escribe "motion blur" + Enter (se borra) + "1,2,4" + Enter
echo 6. Prueba: escribe "3d layer" + Enter (se borra) + "1,2,4" + Enter
echo.
pause
