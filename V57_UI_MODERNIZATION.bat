@echo off
echo ========================================
echo   AE QuickConsole Plugin V57
echo   UI MODERNIZATION
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
echo [2/4] Copying new V57 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V57 files copied successfully
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
echo   V57 CHANGELOG - UI MODERNIZATION
echo ========================================
echo.
echo MAJOR UI REDESIGN:
echo.
echo 1. COMPLETE UI MODERNIZATION:
echo   • Redesigned interface to match Command Launcher Pro
echo   • Modern dark theme with professional appearance
echo   • Window frame with title bar and close button
echo   • Improved typography and spacing
echo   • Enhanced visual hierarchy
echo.
echo 2. NEW WINDOW STRUCTURE:
echo   • Title bar: "Command Launcher V57"
echo   • Header section with app title and rocket icon
echo   • Navigation tabs for different modes
echo   • Modern search bar with blue border
echo   • Professional results table layout
echo   • Status bar and export section
echo.
echo 3. NAVIGATION TABS ADDED:
echo   • 🔍 Search tab - Search mode
echo   • 📋 List tab - Show all effects and commands
echo   • ⭐ Favorites tab - Show favorite items (ACTIVE)
echo   • 📊 Stats tab - Show statistics
echo   • Interactive tab switching
echo.
echo 4. IMPROVED SEARCH BAR:
echo   • Modern design with blue border (#007acc)
echo   • Black background for better contrast
echo   • Star icon for adding to favorites
echo   • Improved focus states and transitions
echo   • Better placeholder text
echo.
echo 5. PROFESSIONAL RESULTS TABLE:
echo   • Table layout with proper headers
echo   • Three columns: Comando, Tipo, Info
echo   • Color-coded type badges:
echo     - Green badges for Effects
echo     - Blue badges for Commands
echo     - Orange badges for Layer creation
echo   • Star icons for favorite items
echo   • Recent commands tracking
echo   • Improved hover effects
echo.
echo 6. ENHANCED FEATURES:
echo   • Favorites system with star icons
echo   • Recent commands tracking (last 10)
echo   • Type detection and categorization
echo   • Improved status messages
echo   • Better error handling
echo   • Professional scrollbar styling
echo.
echo 7. VISUAL IMPROVEMENTS:
echo   • Consistent color scheme
echo   • Better contrast and readability
echo   • Smooth transitions and animations
echo   • Professional spacing and padding
echo   • Modern button designs
echo   • Improved typography
echo.
echo 8. FUNCTIONALITY ENHANCEMENTS:
echo   • Tab-based navigation system
echo   • Favorites management
echo   • Recent commands history
echo   • Type-based categorization
echo   • Improved search experience
echo   • Better status feedback
echo.
echo COMMANDS STILL WORKING:
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
echo   • normal             → Sets Normal blending mode
echo   • multiply           → Sets Multiply blending mode
echo   • screen             → Sets Screen blending mode
echo   • overlay            → Sets Overlay blending mode
echo   • soft light         → Sets Soft Light blending mode
echo   • hard light         → Sets Hard Light blending mode
echo   • add                → Sets Add blending mode
echo   • difference         → Sets Difference blending mode
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
echo NEW UI FEATURES:
echo.
echo 1. NAVIGATION TABS:
echo   • Click 🔍 for search mode
echo   • Click 📋 to show all effects and commands
echo   • Click ⭐ for favorites (currently active)
echo   • Click 📊 for statistics
echo.
echo 2. FAVORITES SYSTEM:
echo   • Click star icon next to search bar to add current search to favorites
echo   • Favorite items show with ⭐ star icon
echo   • Favorites tab shows only your favorite items
echo.
echo 3. RECENT COMMANDS:
echo   • Recently used commands are tracked
echo   • Show as "Reciente 1", "Reciente 2", etc.
echo   • Last 10 commands are remembered
echo.
echo 4. TYPE CATEGORIZATION:
echo   • Effects: Green badges
echo   • Commands: Blue badges
echo   • Layer creation: Orange badges
echo   • Automatic type detection
echo.
echo 5. IMPROVED SEARCH:
echo   • Modern search bar with blue border
echo   • Better visual feedback
echo   • Star icon for favorites
echo   • Improved placeholder text
echo.
echo USAGE EXAMPLES:
echo.
echo NEW UI FEATURES:
echo   1. Click ⭐ tab to see favorites
echo   2. Search for "multiply" → Click star icon to add to favorites
echo   3. Click 📊 tab to see statistics
echo   4. Click 📋 tab to see all effects and commands
echo   5. Use improved search bar with better visual feedback
echo.
echo EXISTING FUNCTIONALITY:
echo   1. Type "multiply" → Enter (applies multiply blending mode)
echo   2. Type "select all" → Enter (selects all layers)
echo   3. Type "solid red" → Enter (creates red solid layer)
echo   4. Click any effect in the table to apply it
echo   5. Use Enter key to apply first visible result
echo.
echo EXPECTED RESULTS:
echo   • Modern, professional interface
echo   • Better visual organization
echo   • Improved user experience
echo   • All existing functionality preserved
echo   • New favorites and recent commands features
echo   • Professional table layout with type badges
echo   • Enhanced navigation with tabs
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V57
echo ========================================
echo.
pause
