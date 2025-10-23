@echo off
echo ========================================
echo   AE QuickConsole Plugin V43
echo   SELECT ALL NaN FIX
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
echo [2/4] Copying new V43 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V43 files copied successfully
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
echo   V43 CHANGELOG - SELECT ALL NaN FIX
echo ========================================
echo.
echo CRITICAL FIX APPLIED:
echo.
echo 1. SELECT ALL NaN ERROR FIX:
echo   • Fixed "Layer NaN does not exist" error in select all command
echo   • Root cause: Array indexing mismatch (1-based vs 0-based)
echo   • Problem: layers[sa] where sa goes from 1 to layers.length
echo   • Solution: layers[sa - 1] to convert 1-based to 0-based indexing
echo   • Now select all works without NaN errors
echo.
echo 2. DESELECT ALL NaN ERROR FIX:
echo   • Fixed "Layer NaN does not exist" error in deselect all command
echo   • Same root cause: Array indexing mismatch
echo   • Problem: layers[da] where da goes from 1 to layers.length
echo   • Solution: layers[da - 1] to convert 1-based to 0-based indexing
echo   • Now deselect all works without NaN errors
echo.
echo 3. TECHNICAL EXPLANATION:
echo   • After Effects layers collection uses 1-based indexing in UI
echo   • But JavaScript arrays use 0-based indexing internally
echo   • When looping from 1 to layers.length, we were accessing:
echo     - layers[1], layers[2], ..., layers[layers.length]
echo   • But valid indices are: layers[0], layers[1], ..., layers[layers.length-1]
echo   • layers[layers.length] is undefined, causing NaN error
echo   • Fix: Use layers[sa-1] to convert 1-based loop to 0-based access
echo.
echo 4. BEFORE AND AFTER:
echo.
echo BEFORE (V42 - BROKEN):
echo   for (var sa = 1; sa <= layers.length; sa++) {
echo       layers[sa].selected = true;  // ERROR: layers[layers.length] is undefined
echo   }
echo   Result: "Layer NaN does not exist. Composition has 11 layers."
echo.
echo AFTER (V43 - FIXED):
echo   for (var sa = 1; sa <= layers.length; sa++) {
echo       layers[sa - 1].selected = true;  // CORRECT: Convert to 0-based indexing
echo   }
echo   Result: "Success: Selected all 11 layers"
echo.
echo COMMANDS NOW WORKING CORRECTLY:
echo.
echo DIRECT COMMANDS (one step):
echo   • select all         → Selects all layers (NO MORE NaN ERROR)
echo   • deselect all       → Deselects all layers (NO MORE NaN ERROR)
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
echo      Expected: "Success: Selected all X layers"
echo   2. Type "deselect all" → Enter
echo      Expected: "Success: Deselected all layers"
echo   3. Select layers → Type "unparent" → Enter
echo      Expected: "Success: Unparented X layers"
echo   4. Select layers → Type "label red" → Enter
echo      Expected: "Success: Set label 'red' for X layers"
echo.
echo TWO-STEP COMMANDS:
echo   1. Select layers → Type "scale" → Enter → Type "150" → Enter
echo      Expected: "Success: Set scale to 150% for X layers"
echo   2. Select layers → Type "opacity" → Enter → Type "75" → Enter
echo      Expected: "Success: Set opacity to 75% for X layers"
echo   3. Select layers → Type "parent to" → Enter → Type "3" → Enter
echo      Expected: "Success: Parented X layers to layer 3"
echo.
echo EXPECTED RESULTS:
echo   • "Success: Selected all X layers" (NO MORE NaN ERROR)
echo   • "Success: Deselected all layers" (NO MORE NaN ERROR)
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V43
echo ========================================
echo.
pause
