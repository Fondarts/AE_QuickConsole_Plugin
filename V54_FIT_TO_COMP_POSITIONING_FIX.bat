@echo off
echo ========================================
echo   AE QuickConsole Plugin V54
echo   FIT TO COMP POSITIONING FIX
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
echo [2/4] Copying new V54 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V54 files copied successfully
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
echo   V54 CHANGELOG - FIT TO COMP FIX
echo ========================================
echo.
echo CRITICAL FIX:
echo.
echo 1. FIT TO COMP POSITIONING FIX:
echo   • Fixed fit to comp command behavior
echo   • Now scales AND centers layer in composition
echo   • Proper scaling to fit composition dimensions
echo   • Automatic centering after scaling
echo   • Complete fit to comp functionality
echo.
echo 2. PROBLEM IDENTIFIED:
echo   • Previous version only scaled the layer correctly
echo   • Layer was not positioned in center of composition
echo   • User reported: "escala correctamente el layer pero no posiciona bien"
echo   • Need to add positioning after scaling
echo.
echo 3. ROOT CAUSE:
echo   • Command only modified scale property
echo   • Did not modify position property
echo   • Layer stayed in original position after scaling
echo   • Need to center layer in composition after scaling
echo.
echo 4. SOLUTION IMPLEMENTED:
echo   • Get composition dimensions (width, height)
echo   • Calculate scale to fit composition (uniform scaling)
echo   • Set scale property
echo   • Calculate center position (compWidth/2, compHeight/2)
echo   • Set position property to center
echo   • Layer is now scaled AND centered
echo.
echo 5. CODE CHANGES:
echo.
echo   BEFORE (V53) - INCOMPLETE:
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
echo   AFTER (V54) - COMPLETE:
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
echo               var transform = layer.property("Transform");
echo               var scale = transform.property("Scale");
echo               var position = transform.property("Position");
echo               
echo               if (scale && position) {
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
echo                   // Set scale
echo                   scale.setValue([uniformScale, uniformScale]);
echo                   
echo                   // Center layer in composition
echo                   var centerX = compWidth / 2;
echo                   var centerY = compHeight / 2;
echo                   position.setValue([centerX, centerY]);
echo                   
echo                   fittedCount++;
echo               }
echo           }
echo           return "Success: Fitted and centered " + fittedCount + " layers to composition";
echo       } catch (e) {
echo           return "Error: Could not fit layers to composition. " + e.toString();
echo       }
echo   }
echo.
echo 6. TECHNICAL EXPLANATION:
echo   • Step 1: Get composition dimensions (compWidth, compHeight)
echo   • Step 2: Get layer dimensions (layerWidth, layerHeight)
echo   • Step 3: Calculate uniform scale to fit composition
echo   • Step 4: Set scale property to calculated value
echo   • Step 5: Calculate center position (compWidth/2, compHeight/2)
echo   • Step 6: Set position property to center
echo   • Result: Layer is scaled to fit AND centered in composition
echo.
echo 7. EXPECTED BEHAVIOR:
echo   • Layer scales to fit composition dimensions
echo   • Layer is positioned in center of composition
echo   • Uniform scaling maintains aspect ratio
echo   • Complete fit to comp functionality
echo   • Professional layer fitting behavior
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
echo   • fit to comp        → Fits AND centers selected layers to composition (FIXED!)
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
echo FIT TO COMP COMMAND (NOW FIXED):
echo   1. Select layers → Type "fit to comp" → Enter
echo      Expected: "Success: Fitted and centered X layers to composition"
echo      Behavior: Layer scales to fit composition AND centers in composition
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
echo   • "Success: Fitted and centered X layers to composition" (FIXED BEHAVIOR!)
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
echo   RESTART AFTER EFFECTS TO USE V54
echo ========================================
echo.
pause
