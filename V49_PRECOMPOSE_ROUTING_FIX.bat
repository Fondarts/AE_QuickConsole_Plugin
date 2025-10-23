@echo off
echo ========================================
echo   AE QuickConsole Plugin V49
echo   PRECOMPOSE ROUTING FIX
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
echo [2/4] Copying new V49 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V49 files copied successfully
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
echo   V49 CHANGELOG - PRECOMPOSE ROUTING FIX
echo ========================================
echo.
echo BUG FIX:
echo.
echo 1. PRECOMPOSE ROUTING FIX:
echo   • Fixed precompose command routing issue
echo   • Command was being treated as effect instead of layer command
echo   • Added precompose to processCommand routing logic
echo   • Now correctly routes to processLayerCommand function
echo.
echo 2. PROBLEM IDENTIFIED:
echo   • Error: "Could not apply effect 'precompose' with any variation"
echo   • TypeError: undefined is not an object
echo   • Command was falling through to applyEffect function
echo   • Missing from processCommand routing conditions
echo.
echo 3. SOLUTION IMPLEMENTED:
echo   • Added "action === 'precompose'" to processCommand routing
echo   • Now correctly identifies precompose as layer command
echo   • Routes to processLayerCommand instead of applyEffect
echo   • Follows same pattern as other layer commands
echo.
echo 4. CODE CHANGE:
echo   BEFORE:
echo   } else if (action === "select" || action === "unselect" || action === "solo" || action === "unsolo" ||
echo              action === "hide" || action === "show" || action === "mute" || action === "unmute" ||
echo              action === "audio" || action === "lock" || action === "unlock" || action === "shy" ||
echo              action === "unshy" || action === "motion blur" || action === "3d layer" || action === "unparent" ||
echo              action === "untrack matte" || action === "deselect all" || action === "select all" ||
echo              (parts.length >= 2 && parts[0].toLowerCase() === "label")) {
echo       return processLayerCommand(command);
echo.
echo   AFTER:
echo   } else if (action === "select" || action === "unselect" || action === "solo" || action === "unsolo" ||
echo              action === "hide" || action === "show" || action === "mute" || action === "unmute" ||
echo              action === "audio" || action === "lock" || action === "unlock" || action === "shy" ||
echo              action === "unshy" || action === "motion blur" || action === "3d layer" || action === "unparent" ||
echo              action === "untrack matte" || action === "deselect all" || action === "select all" ||
echo              action === "precompose" || (parts.length >= 2 && parts[0].toLowerCase() === "label")) {
echo       return processLayerCommand(command);
echo.
echo 5. EXPECTED RESULTS:
echo   • "Success: Precomposed X layers into 'CompName'" (FIXED!)
echo   • No more "Could not apply effect" errors
echo   • Precompose command works as intended
echo   • Proper routing to layer command processor
echo.
echo COMMANDS NOW WORKING:
echo.
echo DIRECT COMMANDS (one step):
echo   • select all         → Selects all layers
echo   • deselect all       → Deselects all layers
echo   • unparent           → Removes parent from selected layers
echo   • untrack matte      → Removes track matte from selected layers
echo   • label red          → Sets red label on selected layers
echo   • label blue         → Sets blue label on selected layers
echo   • (all 16 label colors work directly)
echo   • precompose         → Precomposes selected layers (FIXED!)
echo.
echo TWO-STEP COMMANDS (command + Enter, then value + Enter):
echo   • parent to          → Enter → layer number → Enter
echo   • track matte        → Enter → layer number → Enter
echo   • scale              → Enter → percentage → Enter
echo   • opacity            → Enter → value (0-100) → Enter
echo.
echo LAYER CREATION COMMANDS:
echo   • solid red          → Creates red solid layer
echo   • solid blue         → Creates blue solid layer
echo   • text               → Creates text layer
echo   • light              → Creates light layer
echo   • camera             → Creates camera layer
echo   • null               → Creates null layer
echo   • adjustment layer   → Creates adjustment layer
echo.
echo USAGE EXAMPLES:
echo.
echo PRECOMPOSE COMMAND (NOW FIXED):
echo   1. Select multiple layers → Type "precompose" → Enter
echo      Expected: "Success: Precomposed X layers into 'Pre-comp [timestamp]'"
echo   2. Select layers → Type "precompose My Animation" → Enter
echo      Expected: "Success: Precomposed X layers into 'My Animation'"
echo   3. Select layers → Type "precompose Logo Animation" → Enter
echo      Expected: "Success: Precomposed X layers into 'Logo Animation'"
echo.
echo OTHER DIRECT COMMANDS:
echo   1. Type "select all" → Enter
echo      Expected: "Success: Selected X layers"
echo   2. Type "deselect all" → Enter
echo      Expected: "Success: Deselected X layers"
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
echo   • "Success: Precomposed X layers into 'CompName'" (FIXED!)
echo   • "Success: Selected X layers"
echo   • "Success: Deselected X layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V49
echo ========================================
echo.
pause
