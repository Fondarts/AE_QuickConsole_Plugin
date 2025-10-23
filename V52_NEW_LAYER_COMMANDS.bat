@echo off
echo ========================================
echo   AE QuickConsole Plugin V52
echo   NEW LAYER COMMANDS
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
echo [2/4] Copying new V52 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V52 files copied successfully
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
echo   V52 CHANGELOG - NEW LAYER COMMANDS
echo ========================================
echo.
echo NEW COMMANDS ADDED:
echo.
echo 1. DUPLICATE COMMAND:
echo   • Duplicates selected layers
echo   • Works with multiple selected layers
echo   • Uses layer.duplicate() After Effects API
echo   • Returns count of duplicated layers
echo.
echo 2. CENTER ANCHOR COMMAND:
echo   • Centers anchor point of selected layers
echo   • Calculates center based on layer dimensions
echo   • Sets anchor point to [width/2, height/2]
echo   • Works with multiple selected layers
echo.
echo 3. FIT TO COMP COMMAND:
echo   • Fits selected layers to composition size
echo   • Calculates uniform scale to fit composition
echo   • Maintains aspect ratio
echo   • Uses composition and layer dimensions
echo.
echo 4. RESET TRANSFORM COMMAND:
echo   • Resets all transform properties of selected layers
echo   • Position: Centers to composition
echo   • Scale: Resets to 100%%
echo   • Rotation: Resets to 0 degrees
echo   • Opacity: Resets to 100%%
echo.
echo 5. TECHNICAL IMPLEMENTATION:
echo   • All commands are direct (one-step) commands
echo   • Proper error handling with try-catch blocks
echo   • Support for multiple selected layers
echo   • Returns success messages with layer counts
echo   • Added to all routing systems (processCommand, applyEffect)
echo.
echo 6. COMMAND LOGIC:
echo.
echo   DUPLICATE:
echo   } else if (action === "duplicate") {
echo       var selectedLayers = comp.selectedLayers;
echo       if (!selectedLayers || selectedLayers.length === 0) {
echo           return "Error: No layers selected. Please select layers to duplicate.";
echo       }
echo       
echo       try {
echo           var duplicatedCount = 0;
echo           for (var d = 0; d < selectedLayers.length; d++) {
echo               var layer = selectedLayers[d];
echo               layer.duplicate();
echo               duplicatedCount++;
echo           }
echo           return "Success: Duplicated " + duplicatedCount + " layers";
echo       } catch (e) {
echo           return "Error: Could not duplicate layers. " + e.toString();
echo       }
echo   }
echo.
echo   CENTER ANCHOR:
echo   } else if (action === "center" && parts[1] === "anchor") {
echo       var selectedLayers = comp.selectedLayers;
echo       if (!selectedLayers || selectedLayers.length === 0) {
echo           return "Error: No layers selected. Please select layers to center anchor.";
echo       }
echo       
echo       try {
echo           var centeredCount = 0;
echo           for (var ca = 0; ca < selectedLayers.length; ca++) {
echo               var layer = selectedLayers[ca];
echo               var anchorPoint = layer.property("Transform").property("Anchor Point");
echo               if (anchorPoint) {
echo                   // Get layer dimensions
echo                   var width = layer.width;
echo                   var height = layer.height;
echo                   // Center anchor point
echo                   anchorPoint.setValue([width / 2, height / 2]);
echo                   centeredCount++;
echo               }
echo           }
echo           return "Success: Centered anchor point for " + centeredCount + " layers";
echo       } catch (e) {
echo           return "Error: Could not center anchor point. " + e.toString();
echo       }
echo   }
echo.
echo   FIT TO COMP:
echo   } else if (action === "fit" && parts[1] === "to" && parts[2] === "comp") {
echo       var selectedLayers = comp.selectedLayers;
echo       if (!selectedLayers || selectedLayers.length === 0) {
echo           return "Error: No layers selected. Please select layers to fit to comp.";
echo       }
echo       
echo       try {
echo           var fittedCount = 0;
echo           for (var fc = 0; fc < selectedLayers.length; fc++) {
echo               var layer = selectedLayers[fc];
echo               var scale = layer.property("Transform").property("Scale");
echo               if (scale) {
echo                   // Get composition and layer dimensions
echo                   var compWidth = comp.width;
echo                   var compHeight = comp.height;
echo                   var layerWidth = layer.width;
echo                   var layerHeight = layer.height;
echo                   
echo                   // Calculate scale to fit composition
echo                   var scaleX = (compWidth / layerWidth) * 100;
echo                   var scaleY = (compHeight / layerHeight) * 100;
echo                   var uniformScale = Math.min(scaleX, scaleY);
echo                   
echo                   scale.setValue([uniformScale, uniformScale]);
echo                   fittedCount++;
echo               }
echo           }
echo           return "Success: Fitted " + fittedCount + " layers to composition";
echo       } catch (e) {
echo           return "Error: Could not fit layers to composition. " + e.toString();
echo       }
echo   }
echo.
echo   RESET TRANSFORM:
echo   } else if (action === "reset" && parts[1] === "transform") {
echo       var selectedLayers = comp.selectedLayers;
echo       if (!selectedLayers || selectedLayers.length === 0) {
echo           return "Error: No layers selected. Please select layers to reset transform.";
echo       }
echo       
echo       try {
echo           var resetCount = 0;
echo           for (var rt = 0; rt < selectedLayers.length; rt++) {
echo               var layer = selectedLayers[rt];
echo               var transform = layer.property("Transform");
echo               
echo               // Reset position to center
echo               var position = transform.property("Position");
echo               if (position) {
echo                   position.setValue([comp.width / 2, comp.height / 2]);
echo               }
echo               
echo               // Reset scale to 100%%
echo               var scale = transform.property("Scale");
echo               if (scale) {
echo                   scale.setValue([100, 100]);
echo               }
echo               
echo               // Reset rotation to 0
echo               var rotation = transform.property("Rotation");
echo               if (rotation) {
echo                   rotation.setValue(0);
echo               }
echo               
echo               // Reset opacity to 100%%
echo               var opacity = transform.property("Opacity");
echo               if (opacity) {
echo                   opacity.setValue(100);
echo               }
echo               
echo               resetCount++;
echo           }
echo           return "Success: Reset transform for " + resetCount + " layers";
echo       } catch (e) {
echo           return "Error: Could not reset transform. " + e.toString();
echo       }
echo   }
echo.
echo 7. BENEFITS:
echo   • Streamlines common After Effects operations
echo   • No need to access menus or panels
echo   • Works with multiple layers simultaneously
echo   • Essential for efficient workflow
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
echo   • precompose         → Precomposes selected layers
echo   • duplicate          → Duplicates selected layers (NEW!)
echo   • center anchor      → Centers anchor point of selected layers (NEW!)
echo   • fit to comp        → Fits selected layers to composition (NEW!)
echo   • reset transform    → Resets transform properties (NEW!)
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
echo NEW COMMANDS:
echo   1. Select layers → Type "duplicate" → Enter
echo      Expected: "Success: Duplicated X layers"
echo   2. Select layers → Type "center anchor" → Enter
echo      Expected: "Success: Centered anchor point for X layers"
echo   3. Select layers → Type "fit to comp" → Enter
echo      Expected: "Success: Fitted X layers to composition"
echo   4. Select layers → Type "reset transform" → Enter
echo      Expected: "Success: Reset transform for X layers"
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
echo   • "Success: Duplicated X layers" (NEW!)
echo   • "Success: Centered anchor point for X layers" (NEW!)
echo   • "Success: Fitted X layers to composition" (NEW!)
echo   • "Success: Reset transform for X layers" (NEW!)
echo   • "Success: Precomposed X layers into 'CompName'"
echo   • "Success: Selected X layers"
echo   • "Success: Deselected X layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V52
echo ========================================
echo.
pause
