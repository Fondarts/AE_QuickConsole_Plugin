@echo off
echo ========================================
echo   AE QuickConsole Plugin V50
echo   PRECOMPOSE APPLYEFFECT FIX
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
echo [2/4] Copying new V50 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V50 files copied successfully
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
echo   V50 CHANGELOG - PRECOMPOSE APPLYEFFECT FIX
echo ========================================
echo.
echo CRITICAL BUG FIX:
echo.
echo 1. PRECOMPOSE APPLYEFFECT FIX:
echo   • Fixed precompose command in applyEffect function
echo   • Command was still being treated as effect in applyEffect
echo   • Added precompose to applyEffect layer command detection
echo   • Added specific precompose handling in applyEffect
echo.
echo 2. PROBLEM IDENTIFIED:
echo   • Error: "Could not apply effect 'precompose' with any variation"
echo   • Error: "Can not add a property with name 'precompose' to this PropertyGroup"
echo   • Command was reaching applyEffect function despite processCommand fix
echo   • applyEffect function had its own layer command detection logic
echo   • Missing precompose from applyEffect layer command list
echo.
echo 3. ROOT CAUSE:
echo   • processCommand was correctly routing to processLayerCommand
echo   • BUT applyEffect function also had layer command detection
echo   • applyEffect was intercepting precompose before it reached processLayerCommand
echo   • Double routing system caused the issue
echo.
echo 4. SOLUTION IMPLEMENTED:
echo   • Added "action === 'precompose'" to applyEffect layer command detection
echo   • Added specific precompose case in applyEffect function
echo   • Now applyEffect correctly routes precompose to processLayerCommand
echo   • Triple protection: processCommand + applyEffect + direct routing
echo.
echo 5. CODE CHANGES:
echo.
echo   A. APPLYEFFECT LAYER COMMAND DETECTION:
echo   BEFORE:
echo   } else if (action === "select" || action === "unselect" || action === "solo" || action === "unsolo" ||
echo              action === "hide" || action === "show" || action === "mute" || action === "unmute" ||
echo              action === "audio" || action === "lock" || action === "unlock" || action === "shy" ||
echo              action === "unshy" || effectName === "motion blur" || effectName === "3d layer" ||
echo              effectName === "parent to" || effectName === "track matte" || action === "scale" || action === "opacity" ||
echo              (parts.length >= 2 && parts[0].toLowerCase() === "label")) {
echo.
echo   AFTER:
echo   } else if (action === "select" || action === "unselect" || action === "solo" || action === "unsolo" ||
echo              action === "hide" || action === "show" || action === "mute" || action === "unmute" ||
echo              action === "audio" || action === "lock" || action === "unlock" || action === "shy" ||
echo              action === "unshy" || effectName === "motion blur" || effectName === "3d layer" ||
echo              effectName === "parent to" || effectName === "track matte" || action === "scale" || action === "opacity" ||
echo              action === "precompose" || (parts.length >= 2 && parts[0].toLowerCase() === "label")) {
echo.
echo   B. APPLYEFFECT PRECOMPOSE HANDLING:
echo   ADDED:
echo   } else if (action === "precompose") {
echo       // Handle precompose directly in applyEffect
echo       return processLayerCommand(effectName);
echo   }
echo.
echo 6. TRIPLE PROTECTION SYSTEM:
echo   • Level 1: processCommand routing (V49 fix)
echo   • Level 2: applyEffect layer command detection (V50 fix)
echo   • Level 3: applyEffect direct precompose handling (V50 fix)
echo   • Ensures precompose NEVER reaches effect application logic
echo.
echo 7. EXPECTED RESULTS:
echo   • "Success: Precomposed X layers into 'CompName'" (FINAL FIX!)
echo   • No more "Could not apply effect" errors
echo   • No more "Can not add a property" errors
echo   • Precompose command works perfectly
echo   • Proper routing through all protection layers
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
echo   • precompose         → Precomposes selected layers (FINAL FIX!)
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
echo PRECOMPOSE COMMAND (NOW FINALLY FIXED):
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
echo   • "Success: Precomposed X layers into 'CompName'" (FINAL FIX!)
echo   • "Success: Selected X layers"
echo   • "Success: Deselected X layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V50
echo ========================================
echo.
pause
