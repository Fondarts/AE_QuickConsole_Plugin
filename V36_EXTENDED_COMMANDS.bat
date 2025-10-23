@echo off
echo ========================================
echo   AE QuickConsole Plugin V36
echo   EXTENDED COMMANDS
echo ========================================
echo.

echo [1/4] Removing previous version...
if exist "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo ✓ Previous version removed
) else (
    echo ✓ No previous version found
)

echo.
echo [2/4] Copying new V36 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V36 files copied successfully
) else (
    echo ✗ Error copying files
    pause
    exit /b 1
)

echo.
echo [3/4] Enabling unsigned extensions...
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.11" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.12" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.13" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
echo ✓ Unsigned extensions enabled

echo.
echo [4/4] Installation complete!
echo.
echo ========================================
echo   V36 CHANGELOG - EXTENDED COMMANDS
echo ========================================
echo.
echo NEW COMMANDS ADDED:
echo.
echo PARENT/TRACK MATTE:
echo   • unparent           → Quita parent de capas seleccionadas
echo   • untrack matte      → Quita track matte de capas seleccionadas
echo.
echo SELECTION:
echo   • select all         → Selecciona todas las capas
echo   • deselect all       → Deselecciona todas las capas
echo.
echo LABELS (16 colores):
echo   • label none         → Sin etiqueta (0)
echo   • label red          → Etiqueta roja (1)
echo   • label yellow       → Etiqueta amarilla (2)
echo   • label aqua         → Etiqueta aqua/cyan (3)
echo   • label pink         → Etiqueta rosa (4)
echo   • label lavender     → Etiqueta lavanda (5)
echo   • label peach        → Etiqueta durazno (6)
echo   • label sea foam     → Etiqueta verde mar (7)
echo   • label blue         → Etiqueta azul (8)
echo   • label green        → Etiqueta verde (9)
echo   • label purple       → Etiqueta morada (10)
echo   • label orange       → Etiqueta naranja (11)
echo   • label brown        → Etiqueta marrón (12)
echo   • label fuchsia      → Etiqueta fucsia (13)
echo   • label cyan         → Etiqueta cyan (14)
echo   • label sandstone    → Etiqueta arena (15)
echo   • label dark green   → Etiqueta verde oscuro (16)
echo.
echo TRANSFORM:
echo   • scale 50           → Establece escala a 50%%
echo   • scale 200          → Establece escala a 200%%
echo   • opacity 50         → Establece opacidad a 50%%
echo   • opacity 0          → Establece opacidad a 0%%
echo.
echo USAGE EXAMPLES:
echo   1. Select layers → Type "unparent" → Enter
echo   2. Select layers → Type "label red" → Enter
echo   3. Type "select all" → Enter
echo   4. Select layers → Type "scale" → Enter → Type "150" → Enter
echo   5. Select layers → Type "opacity" → Enter → Type "75" → Enter
echo.
echo FEATURES:
echo   • All commands work with multiple selected layers
echo   • Two-step commands for scale and opacity (command + Enter, then value + Enter)
echo   • Direct commands for unparent, untrack matte, select all, deselect all, labels
echo   • Proper error handling and success messages
echo   • Undo support for all operations
echo.
echo TOTAL COMMANDS NOW AVAILABLE: 50+
echo   • Layer creation: solid, text, light, camera, null, adjustment
echo   • Layer manipulation: select, solo, hide, show, mute, lock, etc.
echo   • Parent/Track Matte: parent to, track matte, unparent, untrack matte
echo   • Selection: select all, deselect all
echo   • Labels: 16 different colors
echo   • Transform: scale, opacity
echo   • Effects: 700+ effects from After Effects
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V36
echo ========================================
echo.
pause
