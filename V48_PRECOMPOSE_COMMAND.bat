@echo off
echo ========================================
echo   AE QuickConsole Plugin V48
echo   PRECOMPOSE COMMAND
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
echo [2/4] Copying new V48 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V48 files copied successfully
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
echo   V48 CHANGELOG - PRECOMPOSE COMMAND
echo ========================================
echo.
echo NEW COMMAND ADDED:
echo.
echo 1. PRECOMPOSE COMMAND:
echo   • Added new "precompose" command to layer commands
echo   • Precomposes selected layers into a new composition
echo   • Supports custom composition names
echo   • Works with multiple selected layers
echo   • Essential After Effects workflow command
echo.
echo 2. USAGE EXAMPLES:
echo   • Select layers → Type "precompose" → Enter
echo     Result: Creates "Pre-comp [timestamp]" composition
echo   • Select layers → Type "precompose My Animation" → Enter
echo     Result: Creates "My Animation" composition
echo   • Select layers → Type "precompose Logo Animation" → Enter
echo     Result: Creates "Logo Animation" composition
echo.
echo 3. TECHNICAL IMPLEMENTATION:
echo   • Uses comp.layers.precompose() After Effects API
echo   • Automatically generates unique names with timestamp
echo   • Supports custom names from user input
echo   • Error handling for failed precompose operations
echo   • Returns success message with layer count and comp name
echo.
echo 4. COMMAND LOGIC:
echo   if (action === "precompose") {
echo       var selectedLayers = comp.selectedLayers;
echo       if (!selectedLayers || selectedLayers.length === 0) {
echo           return "Error: No layers selected. Please select layers to precompose.";
echo       }
echo       
echo       // Get the name for the new composition
echo       var compName = "Pre-comp " + (new Date().getTime());
echo       if (parts.length >= 2) {
echo           compName = parts.slice(1).join(" "); // Join all parts after "precompose"
echo       }
echo       
echo       try {
echo           // Precompose selected layers
echo           var newComp = comp.layers.precompose(selectedLayers, compName);
echo           return "Success: Precomposed " + selectedLayers.length + " layers into '" + compName + "'";
echo       } catch (e) {
echo           return "Error: Could not precompose layers. " + e.toString();
echo       }
echo   }
echo.
echo 5. BENEFITS:
echo   • Streamlines workflow - no need to go to Layer menu
echo   • Quick precompose with custom names
echo   • Works with multiple layers at once
echo   • Essential for complex animations
echo   • Saves time in production
echo.
echo COMMANDS NOW AVAILABLE:
echo.
echo DIRECT COMMANDS (one step):
echo   • select all         → Selects all layers
echo   • deselect all       → Deselects all layers
echo   • unparent           → Removes parent from selected layers
echo   • untrack matte      → Removes track matte from selected layers
echo   • label red          → Sets red label on selected layers
echo   • label blue         → Sets blue label on selected layers
echo   • (all 16 label colors work directly)
echo   • precompose         → Precomposes selected layers (NEW!)
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
echo PRECOMPOSE COMMAND:
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
echo   • "Success: Precomposed X layers into 'CompName'" (NEW PRECOMPOSE COMMAND)
echo   • "Success: Selected X layers"
echo   • "Success: Deselected X layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V48
echo ========================================
echo.
pause
