@echo off
echo ========================================
echo   AE QuickConsole Plugin V37
echo   COMMAND LOGIC FIX
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
echo [2/4] Copying new V37 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V37 files copied successfully
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
echo   V37 CHANGELOG - COMMAND LOGIC FIX
echo ========================================
echo.
echo FIXES APPLIED:
echo.
echo 1. UNPARENT COMMAND:
echo   • Now works as DIRECT command (no two-step)
echo   • Select layers → Type "unparent" → Enter
echo   • Immediately removes parent from selected layers
echo.
echo 2. OPACITY & SCALE COMMANDS:
echo   • Now properly clear input field for value entry
echo   • Select layers → Type "opacity" → Enter → Type "50" → Enter
echo   • Select layers → Type "scale" → Enter → Type "150" → Enter
echo   • Input field clears after first Enter
echo.
echo 3. SELECT ALL & DESELECT ALL:
echo   • Now work as DIRECT commands (no two-step)
echo   • Type "select all" → Enter (selects all layers)
echo   • Type "deselect all" → Enter (deselects all layers)
echo.
echo 4. LABEL COMMANDS:
echo   • Now work as DIRECT commands (no two-step)
echo   • Select layers → Type "label red" → Enter
echo   • Select layers → Type "label blue" → Enter
echo   • All 16 label colors work directly
echo.
echo COMMAND TYPES SUMMARY:
echo.
echo DIRECT COMMANDS (one step):
echo   • unparent, untrack matte
echo   • select all, deselect all
echo   • label none, label red, label blue, etc. (all 16 colors)
echo   • select 1,2,3, solo 1, hide 1, show 1, etc.
echo   • solid red, text, light, camera, null, adjustment
echo.
echo TWO-STEP COMMANDS (command + Enter, then value + Enter):
echo   • parent to → Enter → layer number → Enter
echo   • track matte → Enter → layer number → Enter
echo   • scale → Enter → percentage → Enter
echo   • opacity → Enter → value (0-100) → Enter
echo.
echo USAGE EXAMPLES:
echo.
echo DIRECT COMMANDS:
echo   1. Select layers → "unparent" → Enter
echo   2. "select all" → Enter
echo   3. Select layers → "label red" → Enter
echo   4. "solid blue" → Enter
echo.
echo TWO-STEP COMMANDS:
echo   1. Select layers → "scale" → Enter → "150" → Enter
echo   2. Select layers → "opacity" → Enter → "75" → Enter
echo   3. Select layers → "parent to" → Enter → "3" → Enter
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V37
echo ========================================
echo.
pause
