@echo off
echo ========================================
echo   AE QuickConsole Plugin V42
echo   SELECT ALL FIX
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
echo [2/4] Copying new V42 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V42 files copied successfully
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
echo   V42 CHANGELOG - SELECT ALL FIX
echo ========================================
echo.
echo FIXES APPLIED:
echo.
echo 1. SELECT ALL COMMAND FIX:
echo   • Fixed select all command asking for numeric values
echo   • Added specific handling for "select all" in applyEffect function
echo   • Now select all works as a direct command (one step)
echo   • Usage: Type "select all" → Enter (selects all layers)
echo.
echo 2. DESELECT ALL COMMAND FIX:
echo   • Fixed deselect all command asking for numeric values
echo   • Added specific handling for "deselect all" in applyEffect function
echo   • Now deselect all works as a direct command (one step)
echo   • Usage: Type "deselect all" → Enter (deselects all layers)
echo.
echo 3. ROOT CAUSE IDENTIFIED:
echo   • select all and deselect all were being caught by action === "select"
echo   • But they were falling through to the generic "Enter layer numbers" message
echo   • This caused them to be treated as two-step commands
echo   • Now they are handled specifically before reaching the generic message
echo.
echo 4. TECHNICAL IMPLEMENTATION:
echo   • Added specific checks for "select all" and "deselect all" in applyEffect
echo   • These commands now call processLayerCommand directly
echo   • No more generic "Enter layer numbers" message for these commands
echo   • They work as direct commands like they should
echo.
echo COMMANDS NOW WORKING CORRECTLY:
echo.
echo DIRECT COMMANDS (one step):
echo   • select all         → Selects all layers
echo   • deselect all       → Deselects all layers
echo   • unparent           → Removes parent from selected layers
echo   • untrack matte      → Removes track matte from selected layers
echo   • label red          → Sets red label on selected layers
echo   • label blue         → Sets blue label on selected layers
echo   • (all 16 label colors work directly)
echo.
echo TWO-STEP COMMANDS (command + Enter, then value + Enter):
echo   • parent to          → Enter → layer number → Enter
echo   • track matte        → Enter → layer number → Enter
echo   • scale              → Enter → percentage → Enter
echo   • opacity            → Enter → value (0-100) → Enter
echo.
echo USAGE EXAMPLES:
echo.
echo DIRECT COMMANDS:
echo   1. Type "select all" → Enter
echo   2. Type "deselect all" → Enter
echo   3. Select layers → Type "unparent" → Enter
echo   4. Select layers → Type "label red" → Enter
echo.
echo TWO-STEP COMMANDS:
echo   1. Select layers → Type "scale" → Enter → Type "150" → Enter
echo   2. Select layers → Type "opacity" → Enter → Type "75" → Enter
echo   3. Select layers → Type "parent to" → Enter → Type "3" → Enter
echo.
echo EXPECTED RESULTS:
echo   • "Success: Selected all X layers"
echo   • "Success: Deselected all layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V42
echo ========================================
echo.
pause
