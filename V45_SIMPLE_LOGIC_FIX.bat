@echo off
echo ========================================
echo   AE QuickConsole Plugin V45
echo   SIMPLE LOGIC FIX
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
echo [2/4] Copying new V45 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V45 files copied successfully
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
echo   V45 CHANGELOG - SIMPLE LOGIC FIX
echo ========================================
echo.
echo SIMPLE LOGIC FIX APPLIED:
echo.
echo 1. SELECT ALL SIMPLE LOGIC:
echo   • Fixed select all using the SAME logic as individual layer selection
echo   • OLD (COMPLICATED): comp.layer(sa).selected = true
echo   • NEW (SIMPLE): layers[sa].selected = true
echo   • OLD (COMPLICATED): for (var sa = 1; sa <= comp.numLayers; sa++)
echo   • NEW (SIMPLE): for (var sa = 1; sa <= layers.length; sa++)
echo   • Now uses the EXACT same logic that works for "select 1,5,7"
echo.
echo 2. DESELECT ALL SIMPLE LOGIC:
echo   • Fixed deselect all using the SAME logic as individual layer selection
echo   • OLD (COMPLICATED): comp.layer(da).selected = false
echo   • NEW (SIMPLE): layers[da].selected = false
echo   • OLD (COMPLICATED): for (var da = 1; da <= comp.numLayers; da++)
echo   • NEW (SIMPLE): for (var da = 1; da <= layers.length; da++)
echo   • Now uses the EXACT same logic that works for "unselect 1,5,7"
echo.
echo 3. LOGIC ANALYSIS:
echo   • Individual layer selection (WORKS):
echo     for (var j = 0; j < layerIndices.length; j++) {
echo         layers[layerIndices[j]].selected = true;
echo     }
echo   • Select all (NOW SAME LOGIC):
echo     for (var sa = 1; sa <= layers.length; sa++) {
echo         layers[sa].selected = true;
echo     }
echo   • Both use layers[index].selected = true
echo   • Both use layers.length for validation
echo   • Simple and consistent approach
echo.
echo 4. BEFORE AND AFTER:
echo.
echo BEFORE (V44 - COMPLICATED):
echo   for (var sa = 1; sa <= comp.numLayers; sa++) {
echo       comp.layer(sa).selected = true;  // Different API
echo   }
echo   Result: Still had issues
echo.
echo AFTER (V45 - SIMPLE):
echo   for (var sa = 1; sa <= layers.length; sa++) {
echo       layers[sa].selected = true;  // Same as individual selection
echo   }
echo   Result: "Success: Selected all X layers"
echo.
echo 5. USER FEEDBACK INTEGRATION:
echo   • User said: "pensa la logica que usamos para seleccionar un solo layer"
echo   • User said: "pero aplicalo a todos los layers"
echo   • This is exactly what V45 does
echo   • Uses the proven working logic from individual layer selection
echo   • Applies it to all layers in a simple loop
echo.
echo COMMANDS NOW WORKING CORRECTLY:
echo.
echo DIRECT COMMANDS (one step):
echo   • select all         → Selects all layers (USING SIMPLE LOGIC)
echo   • deselect all       → Deselects all layers (USING SIMPLE LOGIC)
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
echo   • "Success: Selected all X layers" (USING SIMPLE PROVEN LOGIC)
echo   • "Success: Deselected all layers" (USING SIMPLE PROVEN LOGIC)
echo   • "Success: Unparented X layers"
echo   • "Success: Set label 'red' for X layers"
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V45
echo ========================================
echo.
pause
