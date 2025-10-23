@echo off
echo ========================================
echo   AE QuickConsole Plugin V51
echo   PRECOMPOSE API FIX
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
echo [2/4] Copying new V51 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V51 files copied successfully
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
echo   V51 CHANGELOG - PRECOMPOSE API FIX
echo ========================================
echo.
echo CRITICAL API FIX:
echo.
echo 1. PRECOMPOSE API FIX:
echo   • Fixed precompose API call to use correct parameters
echo   • Was passing layer objects instead of layer indices
echo   • Now uses proper After Effects API as per documentation
echo   • Converts selected layers to indices before calling precompose
echo.
echo 2. PROBLEM IDENTIFIED:
echo   • Error: "Unable to call 'precompose' because of parameter 1"
echo   • Error: "Value 'AVLayer' of element 0 in the array is not a valid int"
echo   • API expects array of integers (layer indices), not layer objects
echo   • Documentation confirms: layerIndicies must be "Array of integers"
echo.
echo 3. ROOT CAUSE:
echo   • After Effects precompose API requires layer indices, not layer objects
echo   • My code was passing selectedLayers (AVLayer objects) directly
echo   • API signature: comp.layers.precompose(layerIndicies, name[, moveAllAttributes])
echo   • layerIndicies must be array of integers representing layer positions
echo.
echo 4. SOLUTION IMPLEMENTED:
echo   • Extract layer indices from selected layers before calling precompose
echo   • Convert layer objects to their index numbers
echo   • Pass array of integers to precompose API
echo   • Follow official After Effects scripting documentation
echo.
echo 5. CODE CHANGES:
echo.
echo   BEFORE (V50):
echo   try {
echo       // Precompose selected layers
echo       var newComp = comp.layers.precompose(selectedLayers, compName);
echo       return "Success: Precomposed " + selectedLayers.length + " layers into '" + compName + "'";
echo   } catch (e) {
echo       return "Error: Could not precompose layers. " + e.toString();
echo   }
echo.
echo   AFTER (V51):
echo   try {
echo       // Get layer indices from selected layers
echo       var layerIndices = [];
echo       for (var i = 0; i < selectedLayers.length; i++) {
echo           layerIndices.push(selectedLayers[i].index);
echo       }
echo       
echo       // Precompose selected layers using correct API
echo       var newComp = comp.layers.precompose(layerIndices, compName);
echo       return "Success: Precomposed " + selectedLayers.length + " layers into '" + compName + "'";
echo   } catch (e) {
echo       return "Error: Could not precompose layers. " + e.toString();
echo   }
echo.
echo 6. API DOCUMENTATION COMPLIANCE:
echo   • Function: LayerCollection.precompose()
echo   • Parameters:
echo     - layerIndicies: Array of integers (layer position indexes)
echo     - name: String (name of new CompItem)
echo     - moveAllAttributes: Boolean (optional, default true)
echo   • Usage: comp.layers.precompose(layerIndicies, name[, moveAllAttributes])
echo   • Now correctly implemented according to official documentation
echo.
echo 7. EXPECTED RESULTS:
echo   • "Success: Precomposed X layers into 'CompName'" (FINAL API FIX!)
echo   • No more "Unable to call precompose" errors
echo   • No more "Value 'AVLayer' is not a valid int" errors
echo   • Precompose command works with correct After Effects API
echo   • Proper layer index conversion and API compliance
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
echo   • precompose         → Precomposes selected layers (API FIXED!)
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
echo PRECOMPOSE COMMAND (NOW API COMPLIANT):
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
echo   • "Success: Precomposed X layers into 'CompName'" (API FIXED!)
echo   • "Success: Selected X layers"
echo   • "Success: Deselected X layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V51
echo ========================================
echo.
pause
