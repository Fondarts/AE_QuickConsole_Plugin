@echo off
echo ========================================
echo   AE QuickConsole Plugin V38
echo   LABEL COMMANDS FIX
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
echo [2/4] Copying new V38 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V38 files copied successfully
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
echo   V38 CHANGELOG - LABEL COMMANDS FIX
echo ========================================
echo.
echo FIXES APPLIED:
echo.
echo 1. LABEL COMMANDS ROUTING:
echo   • Fixed label commands being treated as effects instead of layer commands
echo   • Commands like "label blue" now properly route to processLayerCommand
echo   • Fixed detection of two-word and three-word label commands
echo.
echo 2. MULTI-WORD LABEL COLORS:
echo   • Fixed "label sea foam" (three words)
echo   • Fixed "label dark green" (three words)
echo   • All single-word colors work: red, blue, green, etc.
echo.
echo 3. COMMAND DETECTION LOGIC:
echo   • Improved two-word command detection
echo   • Added proper routing for "select all", "deselect all", "untrack matte"
echo   • Fixed label command parsing and execution
echo.
echo LABEL COMMANDS NOW WORKING:
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
echo TECHNICAL FIXES:
echo   • Fixed command routing in processCommand function
echo   • Improved two-word command detection logic
echo   • Added proper handling for three-word commands
echo   • Fixed label color mapping and validation
echo   • Ensured all label commands are treated as direct commands
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V38
echo ========================================
echo.
pause
