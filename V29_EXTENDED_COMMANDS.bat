@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V29 EXTENDED COMMANDS
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V29 EXTENDED COMMANDS...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V29 EXTENDED COMMANDS copiado exitosamente
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
echo INSTALACION V29 EXTENDED COMMANDS COMPLETA
echo ========================================
echo.
echo NUEVOS COMANDOS AGREGADOS EN V29:
echo - hide: Oculta layers (enabled = false)
echo - show: Muestra layers (enabled = true)
echo - mute: Silencia audio de layers (audioEnabled = false)
echo - unmute: Habilita audio de layers (audioEnabled = true)
echo - audio: Habilita audio de layers (audioEnabled = true)
echo - lock: Bloquea layers (locked = true)
echo - unlock: Desbloquea layers (locked = false)
echo - shy: Hace layers timidos (shy = true)
echo - unshy: Quita timidez de layers (shy = false)
echo - motion blur: Habilita motion blur (motionBlur = true)
echo - 3d layer: Habilita 3D en layers (threeDLayer = true)
echo.
echo FLUJO DE TRABAJO (DOS PASOS):
echo 1. Escribes comando + Enter (ej: "hide" + Enter)
echo 2. Campo se borra automaticamente
echo 3. Escribes numeros + Enter (ej: "1,2,4" + Enter)
echo 4. Se ejecuta comando completo (ej: "hide 1,2,4")
echo.
echo EJEMPLOS DE USO:
echo - hide 1,3,5: Oculta layers 1, 3 y 5
echo - show 2,4: Muestra layers 2 y 4
echo - mute 1,2: Silencia audio de layers 1 y 2
echo - lock 3: Bloquea layer 3
echo - shy 1,2,3: Hace timidos layers 1, 2 y 3
echo - motion blur 1,4: Habilita motion blur en layers 1 y 4
echo - 3d layer 2,3: Habilita 3D en layers 2 y 3
echo.
echo FUNCIONALIDADES COMPLETAS:
echo - Escanea 2 carpetas especificas de After Effects
echo - Encuentra 735+ efectos + 21 comandos (NUEVO)
echo - Barra de busqueda completamente unificada
echo - Ordenamiento inteligente (coincidencias exactas primero)
echo - Comandos de dos pasos con campo limpio
echo - Haz click en cualquier elemento para aplicarlo/ejecutarlo
echo - ENTER para aplicar el primer elemento visible
echo - Campo de comandos separado (opcional)
echo - Boton "Export Effects List" debajo de la lista
echo - Exporta lista completa con paths de archivos
echo - Excluye carpetas problematicas (Keyframe, Extensions, Format)
echo - Manejo seguro de errores
echo.
echo COMANDOS DISPONIBLES (21 TOTAL):
echo - select, unselect, solo, unsolo (seleccion y visibilidad)
echo - hide, show (visibilidad de layers)
echo - mute, unmute, audio (control de audio)
echo - lock, unlock (bloqueo de layers)
echo - shy, unshy (timidez de layers)
echo - motion blur (motion blur)
echo - 3d layer (3D layers)
echo - solid [color], text, light, camera, null, adjustment layer (creacion)
echo.
echo AHORA:
echo 1. CIERRA After Effects completamente
echo 2. ABRE After Effects
echo 3. Ve a Window ^> Extensions ^> Command Console
echo 4. Deberia mostrar "Simple Effect Scanner V29"
echo 5. Prueba: escribe "hide" + Enter (se borra) + "1,2,4" + Enter
echo.
pause
