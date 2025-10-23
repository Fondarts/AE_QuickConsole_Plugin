@echo off
echo ========================================
echo   AE QuickConsole Plugin V39
echo   LABEL ROUTING FIX
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
echo [2/4] Copying new V39 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V39 files copied successfully
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
echo   V39 CHANGELOG - LABEL ROUTING FIX
echo ========================================
echo.
echo CRITICAL FIX APPLIED:
echo.
echo 1. LABEL COMMANDS ROUTING FIX:
echo   • Fixed the core issue: label commands were still being routed to applyEffect
echo   • Changed condition from (action === "label" && parts.length >= 2)
echo   • To: (parts.length >= 2 && parts[0].toLowerCase() === "label")
echo   • This ensures label commands are properly caught and routed to processLayerCommand
echo.
echo 2. ROOT CAUSE IDENTIFIED:
echo   • When command is "label blue", action becomes "label blue" (two words)
echo   • But condition was looking for action === "label" (one word)
echo   • This caused label commands to fall through to applyEffect instead
echo   • applyEffect tried to apply "label blue" as an effect, causing the error
echo.
echo 3. TECHNICAL DETAILS:
echo   • Error: "Can not add a property with name 'label red' to this PropertyGroup"
echo   • This happened because applyEffect was trying to add "label red" as an effect
echo   • But "label red" is not an effect - it's a layer command
echo   • Now label commands are properly routed to processLayerCommand
echo.
echo LABEL COMMANDS NOW WORKING CORRECTLY:
echo.
echo SINGLE WORD COLORS:
echo   • label none         → Sin etiqueta (0)
echo   • label red          → Etiqueta roja (1)
echo   • label yellow       → Etiqueta amarilla (2)
echo   • label aqua         → Etiqueta aqua/cyan (3)
echo   • label pink         → Etiqueta rosa (4)
echo   • label lavender     → Etiqueta lavanda (5)
echo   • label peach        → Etiqueta durazno (6)
echo   • label blue         → Etiqueta azul (8)
echo   • label green        → Etiqueta verde (9)
echo   • label purple       → Etiqueta morada (10)
echo   • label orange       → Etiqueta naranja (11)
echo   • label brown        → Etiqueta marrón (12)
echo   • label fuchsia      → Etiqueta fucsia (13)
echo   • label cyan         → Etiqueta cyan (14)
echo   • label sandstone    → Etiqueta arena (15)
echo.
echo MULTI-WORD COLORS:
echo   • label sea foam     → Etiqueta verde mar (7)
echo   • label dark green   → Etiqueta verde oscuro (16)
echo.
echo USAGE EXAMPLES:
echo   1. Select layers → Type "label red" → Enter
echo   2. Select layers → Type "label blue" → Enter
echo   3. Select layers → Type "label sea foam" → Enter
echo   4. Select layers → Type "label dark green" → Enter
echo.
echo EXPECTED RESULT:
echo   • "Success: Set label 'red' for X layers"
echo   • "Success: Set label 'blue' for X layers"
echo   • "Success: Set label 'sea foam' for X layers"
echo   • "Success: Set label 'dark green' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V39
echo ========================================
echo.
pause
