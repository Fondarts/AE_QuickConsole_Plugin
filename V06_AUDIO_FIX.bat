@echo off
echo ========================================
echo INSTALANDO EFFECT SCANNER V06 AUDIO FIX
echo ========================================
echo.

echo 1. Eliminando version anterior...
if exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo    ✓ Version anterior eliminada
)

echo.
echo 2. Copiando version V06 AUDIO FIX...
xcopy "%~dp0*" "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\AE_QuickConsole_Plugin\" /E /I /Y >nul
if %ERRORLEVEL% EQU 0 (
    echo    ✓ Plugin V06 AUDIO FIX copiado exitosamente
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
echo INSTALACION V06 AUDIO FIX COMPLETA
echo ========================================
echo.
echo CORRECCIONES EN V06:
echo - Mapeo completo de efectos de audio (12 efectos)
echo - "Aud BT" se convierte en "Bass & Treble"
echo - "Aud Delay" se convierte en "Delay"
echo - "Aud Flange" se convierte en "Flange & Chorus"
echo - "Aud HiLo" se convierte en "High-Low Pass"
echo - "Aud Mixer" se convierte en "Stereo Mixer"
echo - "Aud Modulator" se convierte en "Modulator"
echo - "Aud ParamEQ" se convierte en "Parametric EQ"
echo - "Aud Reverb" se convierte en "Reverb"
echo - "Aud Reverse" se convierte en "Backwards"
echo - "Aud Tone" se convierte en "Tone"
echo - "AudSpect" se convierte en "Audio Spectrum"
echo - "AudWave" se convierte en "Audio Waveform"
echo - Mantiene todas las correcciones anteriores (CC, espacios, URL decode)
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
echo 4. Deberia mostrar "Simple Effect Scanner V06"
echo 5. Busca "Bass & Treble" y "Stereo Mixer"
echo 6. Prueba aplicar efectos de audio - deberian funcionar!
echo.
pause
