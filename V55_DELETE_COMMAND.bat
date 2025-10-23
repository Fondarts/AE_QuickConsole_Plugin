@echo off
echo ========================================
echo   AE QuickConsole Plugin V55
echo   DELETE COMMAND
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
echo [2/4] Copying new V55 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V55 files copied successfully
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
echo   V55 CHANGELOG - DELETE COMMAND
echo ========================================
echo.
echo NEW FEATURE:
echo.
echo 1. DELETE COMMAND ADDED:
echo   • Added delete command to remove selected layers
echo   • Direct command (one step) - no parameters needed
echo   • Removes selected layers from composition
echo   • Provides confirmation with count of deleted layers
echo   • Safe deletion with error handling
echo.
echo 2. COMMAND FUNCTIONALITY:
echo   • Command: delete
echo   • Usage: Select layers → Type "delete" → Enter
echo   • Result: "Success: Deleted X layers"
echo   • Behavior: Removes selected layers from composition
echo   • Error handling: Shows error if no layers selected
echo.
echo 3. IMPLEMENTATION DETAILS:
echo   • Uses layer.remove() method
echo   • Iterates through selectedLayers array
echo   • Counts successfully deleted layers
echo   • Provides informative success message
echo   • Handles errors gracefully
echo.
echo 4. CODE ADDED:
echo.
echo   NEW DELETE COMMAND:
echo   } else if (action === "delete") {
echo       var selectedLayers = comp.selectedLayers;
echo       if (!selectedLayers || selectedLayers.length === 0) {
echo           return "Error: No layers selected. Please select layers to delete.";
echo       }
echo       
echo       try {
echo           var deletedCount = 0;
echo           for (var d = 0; d < selectedLayers.length; d++) {
echo               var layer = selectedLayers[d];
echo               layer.remove();
echo               deletedCount++;
echo           }
echo           return "Success: Deleted " + deletedCount + " layers";
echo       } catch (e) {
echo           return "Error: Could not delete layers. " + e.toString();
echo       }
echo   }
echo.
echo 5. INTEGRATION:
echo   • Added to addLayerCommands array
echo   • Added to processCommand routing logic
echo   • Added to applyEffect routing logic
echo   • Added to error message command list
echo   • Fully integrated with existing command system
echo.
echo 6. SAFETY FEATURES:
echo   • Checks for selected layers before deletion
echo   • Provides clear error message if no layers selected
echo   • Uses try-catch for error handling
echo   • Counts successful deletions
echo   • Informative success message
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
echo   • precompose         → Precomposes selected layers
echo   • duplicate          → Duplicates selected layers
echo   • center anchor      → Centers anchor point WITHOUT moving layer
echo   • fit to comp        → Fits AND centers selected layers to composition
echo   • reset transform    → Resets transform properties
echo   • delete             → Deletes selected layers (NEW!)
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
echo DELETE COMMAND (NEW):
echo   1. Select layers → Type "delete" → Enter
echo      Expected: "Success: Deleted X layers"
echo      Behavior: Removes selected layers from composition
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
echo   5. Select layers → Type "precompose" → Enter
echo      Expected: "Success: Precomposed X layers into 'Pre-comp [timestamp]'"
echo   6. Select layers → Type "duplicate" → Enter
echo      Expected: "Success: Duplicated X layers"
echo   7. Select layers → Type "center anchor" → Enter
echo      Expected: "Success: Centered anchor point for X layers"
echo   8. Select layers → Type "fit to comp" → Enter
echo      Expected: "Success: Fitted and centered X layers to composition"
echo   9. Select layers → Type "reset transform" → Enter
echo      Expected: "Success: Reset transform for X layers"
echo.
echo TWO-STEP COMMANDS:
echo   1. Select layers → Type "scale" → Enter → Type "150" → Enter
echo      Expected: "Success: Set scale to 150%% for X layers"
echo   2. Select layers → Type "opacity" → Enter → Type "75" → Enter
echo      Expected: "Success: Set opacity to 75%% for X layers"
echo   3. Select layers → Type "parent to" → Enter → Type "3" → Enter
echo      Expected: "Success: Parented X layers to layer 3"
echo.
echo EXPECTED RESULTS:
echo   • "Success: Deleted X layers" (NEW COMMAND!)
echo   • "Success: Fitted and centered X layers to composition"
echo   • "Success: Centered anchor point for X layers"
echo   • "Success: Duplicated X layers"
echo   • "Success: Reset transform for X layers"
echo   • "Success: Precomposed X layers into 'CompName'"
echo   • "Success: Selected X layers"
echo   • "Success: Deselected X layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V55
echo ========================================
echo.
pause
