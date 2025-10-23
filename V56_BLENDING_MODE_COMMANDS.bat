@echo off
echo ========================================
echo   AE QuickConsole Plugin V56
echo   BLENDING MODE COMMANDS
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
echo [2/4] Copying new V56 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V56 files copied successfully
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
echo   V56 CHANGELOG - BLENDING MODE COMMANDS
echo ========================================
echo.
echo NEW FEATURE:
echo.
echo 1. BLENDING MODE COMMANDS ADDED:
echo   • Added 8 most common blending mode commands
echo   • Direct commands (one step) - no parameters needed
echo   • Sets blending mode for selected layers
echo   • Provides confirmation with count of layers affected
echo   • Safe operation with error handling
echo.
echo 2. BLENDING MODES AVAILABLE:
echo   • normal        → Normal blending mode
echo   • multiply      → Multiply blending mode (darkening)
echo   • screen        → Screen blending mode (lightening)
echo   • overlay       → Overlay blending mode (contrast)
echo   • soft light    → Soft Light blending mode (contrast)
echo   • hard light    → Hard Light blending mode (contrast)
echo   • add           → Add blending mode (lightening)
echo   • difference    → Difference blending mode (difference)
echo.
echo 3. COMMAND FUNCTIONALITY:
echo   • Usage: Select layers → Type blending mode command → Enter
echo   • Result: "Success: Set blending mode to [Mode] for X layers"
echo   • Behavior: Changes blending mode for selected layers
echo   • Error handling: Shows error if no layers selected
echo.
echo 4. IMPLEMENTATION DETAILS:
echo   • Uses layer.blendingMode property
echo   • Iterates through selectedLayers array
echo   • Counts successfully modified layers
echo   • Provides informative success message
echo   • Handles errors gracefully
echo.
echo 5. CODE ADDED:
echo.
echo   BLENDING MODE COMMANDS:
echo   } else if (action === "normal") {
echo       var selectedLayers = comp.selectedLayers;
echo       if (!selectedLayers || selectedLayers.length === 0) {
echo           return "Error: No layers selected. Please select layers to set blending mode.";
echo       }
echo       
echo       try {
echo           var setCount = 0;
echo           for (var n = 0; n < selectedLayers.length; n++) {
echo               var layer = selectedLayers[n];
echo               layer.blendingMode = BlendingMode.NORMAL;
echo               setCount++;
echo           }
echo           return "Success: Set blending mode to Normal for " + setCount + " layers";
echo       } catch (e) {
echo           return "Error: Could not set blending mode. " + e.toString();
echo       }
echo   }
echo.
echo   Similar implementation for: multiply, screen, overlay, soft light, hard light, add, difference
echo.
echo 6. INTEGRATION:
echo   • Added to addLayerCommands array
echo   • Added to processCommand routing logic
echo   • Added to applyEffect routing logic
echo   • Added to error message command list
echo   • Fully integrated with existing command system
echo.
echo 7. SAFETY FEATURES:
echo   • Checks for selected layers before operation
echo   • Provides clear error message if no layers selected
echo   • Uses try-catch for error handling
echo   • Counts successful operations
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
echo   • delete             → Deletes selected layers
echo   • normal             → Sets Normal blending mode (NEW!)
echo   • multiply           → Sets Multiply blending mode (NEW!)
echo   • screen             → Sets Screen blending mode (NEW!)
echo   • overlay            → Sets Overlay blending mode (NEW!)
echo   • soft light         → Sets Soft Light blending mode (NEW!)
echo   • hard light         → Sets Hard Light blending mode (NEW!)
echo   • add                → Sets Add blending mode (NEW!)
echo   • difference         → Sets Difference blending mode (NEW!)
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
echo BLENDING MODE COMMANDS (NEW):
echo   1. Select layers → Type "multiply" → Enter
echo      Expected: "Success: Set blending mode to Multiply for X layers"
echo      Behavior: Changes blending mode to Multiply for selected layers
echo.
echo   2. Select layers → Type "screen" → Enter
echo      Expected: "Success: Set blending mode to Screen for X layers"
echo      Behavior: Changes blending mode to Screen for selected layers
echo.
echo   3. Select layers → Type "overlay" → Enter
echo      Expected: "Success: Set blending mode to Overlay for X layers"
echo      Behavior: Changes blending mode to Overlay for selected layers
echo.
echo   4. Select layers → Type "soft light" → Enter
echo      Expected: "Success: Set blending mode to Soft Light for X layers"
echo      Behavior: Changes blending mode to Soft Light for selected layers
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
echo   10. Select layers → Type "delete" → Enter
echo       Expected: "Success: Deleted X layers"
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
echo   • "Success: Set blending mode to Normal for X layers" (NEW!)
echo   • "Success: Set blending mode to Multiply for X layers" (NEW!)
echo   • "Success: Set blending mode to Screen for X layers" (NEW!)
echo   • "Success: Set blending mode to Overlay for X layers" (NEW!)
echo   • "Success: Set blending mode to Soft Light for X layers" (NEW!)
echo   • "Success: Set blending mode to Hard Light for X layers" (NEW!)
echo   • "Success: Set blending mode to Add for X layers" (NEW!)
echo   • "Success: Set blending mode to Difference for X layers" (NEW!)
echo   • "Success: Deleted X layers"
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
echo   RESTART AFTER EFFECTS TO USE V56
echo ========================================
echo.
pause
