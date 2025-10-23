@echo off
echo ========================================
echo   AE QuickConsole Plugin V53
echo   CENTER ANCHOR FIX
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
echo [2/4] Copying new V53 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V53 files copied successfully
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
echo   V53 CHANGELOG - CENTER ANCHOR FIX
echo ========================================
echo.
echo CRITICAL FIX:
echo.
echo 1. CENTER ANCHOR LOGIC FIX:
echo   • Fixed center anchor command behavior
echo   • Now moves anchor point to center WITHOUT moving layer visually
echo   • Compensates position to maintain layer in same visual location
echo   • Proper anchor point centering without layer displacement
echo.
echo 2. PROBLEM IDENTIFIED:
echo   • Previous version moved the layer when centering anchor point
echo   • After Effects automatically adjusts position when anchor changes
echo   • User wanted anchor to move to center but layer to stay in place
echo   • Need to compensate position change to maintain visual position
echo.
echo 3. ROOT CAUSE:
echo   • When anchor point changes, After Effects adjusts layer position
echo   • This causes the layer to move visually on screen
echo   • Need to calculate the difference and compensate position
echo   • Must adjust position by the same amount as anchor point change
echo.
echo 4. SOLUTION IMPLEMENTED:
echo   • Get current anchor point and position values
echo   • Calculate new anchor point (center of layer)
echo   • Calculate difference between old and new anchor points
echo   • Set new anchor point
echo   • Adjust position to compensate for anchor point change
echo   • Layer stays in same visual location
echo.
echo 5. CODE CHANGES:
echo.
echo   BEFORE (V52) - INCORRECT:
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
echo   AFTER (V53) - CORRECT:
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
echo               var transform = layer.property("Transform");
echo               var anchorPoint = transform.property("Anchor Point");
echo               var position = transform.property("Position");
echo               
echo               if (anchorPoint && position) {
echo                   // Get current anchor point and position
echo                   var currentAnchor = anchorPoint.value;
echo                   var currentPosition = position.value;
echo                   
echo                   // Get layer dimensions
echo                   var width = layer.width;
echo                   var height = layer.height;
echo                   
echo                   // Calculate new anchor point (center of layer)
echo                   var newAnchor = [width / 2, height / 2];
echo                   
echo                   // Calculate the difference
echo                   var anchorDiff = [newAnchor[0] - currentAnchor[0], newAnchor[1] - currentAnchor[1]];
echo                   
echo                   // Set new anchor point
echo                   anchorPoint.setValue(newAnchor);
echo                   
echo                   // Adjust position to compensate for anchor point change
echo                   var newPosition = [currentPosition[0] + anchorDiff[0], currentPosition[1] + anchorDiff[1]];
echo                   position.setValue(newPosition);
echo                   
echo                   centeredCount++;
echo               }
echo           }
echo           return "Success: Centered anchor point for " + centeredCount + " layers";
echo       } catch (e) {
echo           return "Error: Could not center anchor point. " + e.toString();
echo       }
echo   }
echo.
echo 6. TECHNICAL EXPLANATION:
echo   • Step 1: Get current anchor point and position values
echo   • Step 2: Calculate new anchor point (width/2, height/2)
echo   • Step 3: Calculate difference: newAnchor - currentAnchor
echo   • Step 4: Set new anchor point to center
echo   • Step 5: Adjust position: currentPosition + anchorDiff
echo   • Result: Anchor point is centered, layer stays in same visual location
echo.
echo 7. EXPECTED BEHAVIOR:
echo   • Anchor point moves to center of layer
echo   • Layer stays in exact same visual position
echo   • No visual displacement of the layer
echo   • Proper anchor point centering
echo   • Maintains layer's visual appearance
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
echo   • center anchor      → Centers anchor point WITHOUT moving layer (FIXED!)
echo   • fit to comp        → Fits selected layers to composition
echo   • reset transform    → Resets transform properties
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
echo CENTER ANCHOR COMMAND (NOW FIXED):
echo   1. Select layers → Type "center anchor" → Enter
echo      Expected: "Success: Centered anchor point for X layers"
echo      Behavior: Anchor point moves to center, layer stays in same visual position
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
echo   7. Select layers → Type "fit to comp" → Enter
echo      Expected: "Success: Fitted X layers to composition"
echo   8. Select layers → Type "reset transform" → Enter
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
echo   • "Success: Centered anchor point for X layers" (FIXED BEHAVIOR!)
echo   • "Success: Duplicated X layers"
echo   • "Success: Fitted X layers to composition"
echo   • "Success: Reset transform for X layers"
echo   • "Success: Precomposed X layers into 'CompName'"
echo   • "Success: Selected X layers"
echo   • "Success: Deselected X layers"
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V53
echo ========================================
echo.
pause
