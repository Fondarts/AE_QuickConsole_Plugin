// Simple Effect Scanner V02 - Only scans 2 specific folders
var allEffects = [];
var allEffectsWithPaths = [];

// Function to scan a single folder
function scanFolder(folderPath) {
    var effects = [];
    try {
        var folder = new Folder(folderPath);
        if (folder.exists) {
            var files = folder.getFiles();
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                if (file instanceof Folder) {
                    // Skip problematic folders
                    var folderName = file.name.toLowerCase();
                    if (folderName === "keyframe" || 
                        folderName === "extensions" || 
                        folderName === "format") {
                        continue; // Skip these folders
                    }
                    
                    // Recursively scan subfolders
                    var subEffects = scanFolder(file.fsName);
                    effects = effects.concat(subEffects);
                } else {
                    // Check if it's a plugin file
                    var fileName = file.name.toLowerCase();
                    if (fileName.indexOf(".aex") !== -1) {
                        var effectName = file.name.substring(0, file.name.indexOf(".aex"));
                        effectName = effectName.replace(/_/g, " ");
                        effectName = effectName.replace(/-/g, " ");
                        if (effectName && effectName !== "" && effectName.length > 1) {
                            effects.push({
                                name: effectName,
                                path: file.fsName
                            });
                        }
                    }
                }
            }
        }
    } catch (e) {
        // Ignore errors
    }
    return effects;
}

// Scan the 2 specific folders
function scanEffects() {
    allEffects = [];
    allEffectsWithPaths = [];
    
    // Scan folder 1
    var effects1 = scanFolder("C:/Program Files/Adobe/Adobe After Effects 2025/Support Files/Plug-ins");
    allEffectsWithPaths = allEffectsWithPaths.concat(effects1);
    
    // Scan folder 2
    var effects2 = scanFolder("C:/Program Files/Adobe/Common/Plug-ins/7.0/MediaCore");
    allEffectsWithPaths = allEffectsWithPaths.concat(effects2);
    
    // Remove duplicates and sort
    var uniqueEffects = [];
    var uniqueEffectsWithPaths = [];
    for (var i = 0; i < allEffectsWithPaths.length; i++) {
        var effect = allEffectsWithPaths[i];
        var found = false;
        for (var j = 0; j < uniqueEffects.length; j++) {
            if (uniqueEffects[j] === effect.name) {
                found = true;
                break;
            }
        }
        if (!found) {
            uniqueEffects.push(effect.name);
            uniqueEffectsWithPaths.push(effect);
        }
    }
    
    // Sort by name
    uniqueEffectsWithPaths.sort(function(a, b) {
        return a.name.localeCompare(b.name);
    });
    
    allEffects = uniqueEffects.sort();
    allEffectsWithPaths = uniqueEffectsWithPaths;
    
    return allEffects;
}

// Test function
function testJSX() {
    return "JSX working - Found " + allEffects.length + " effects";
}

// Get effects count
function getEffectsCount() {
    return allEffects.length;
}

// Get effects list as string
function getEffectsList() {
    if (allEffects.length === 0) {
        return "No effects found";
    }
    return allEffects.join("\n");
}

// Apply effect to active layer
function applyEffect(effectName) {
    try {
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "Error: Please select a composition first.";
        }
        
        var layer = comp.selectedLayers[0];
        if (!layer) {
            return "Error: Please select a layer first.";
        }
        
        app.beginUndoGroup("Apply Effect: " + effectName);
        
        try {
            // Try to apply the effect
            var effect = layer.effect.addProperty(effectName);
            return "Success: Effect '" + effectName + "' applied to layer.";
        } catch (e) {
            // If the effect name doesn't work, try some variations
            var variations = [];
            
            // Create variations safely
            try {
                variations.push(effectName.replace(/\s+/g, "")); // Remove all spaces
            } catch (e1) {}
            
            try {
                variations.push(effectName.replace(/\s+/g, "_")); // Replace spaces with underscores
            } catch (e2) {}
            
            try {
                variations.push(effectName.replace(/\s+/g, "-")); // Replace spaces with hyphens
            } catch (e3) {}
            
            try {
                var variation = effectName.replace(/\s+/g, "").replace(/([A-Z])/g, " $1");
                variation = variation.replace(/^\s+|\s+$/g, ""); // Trim manually
                variations.push(variation);
            } catch (e4) {}
            
            // Try each variation
            for (var i = 0; i < variations.length; i++) {
                try {
                    var variation = variations[i];
                    if (variation && variation !== effectName && variation.length > 0) {
                        layer.effect.addProperty(variation);
                        return "Success: Effect '" + variation + "' applied to layer (variation of '" + effectName + "').";
                    }
                } catch (e5) {
                    // Continue to next variation
                }
            }
            
            return "Error: Could not apply effect '" + effectName + "' with any variation. Original error: " + e.toString();
        } finally {
            app.endUndoGroup();
        }
        
    } catch (e) {
        return "Error: " + e.toString();
    }
}

// Export effects list with paths
function exportEffectsList() {
    try {
        if (allEffectsWithPaths.length === 0) {
            return "Error: No effects found to export.";
        }
        
        var fileName = "AE_Effects_List_V01_" + new Date().getFullYear() + "_" + (new Date().getMonth() + 1) + "_" + new Date().getDate() + ".txt";
        var desktopPath = Folder.desktop.fsName;
        var filePath = desktopPath + "/" + fileName;
        var file = new File(filePath);
        
        if (file.open("w")) {
            file.write("After Effects Effects List V01\n");
            file.write("==============================\n");
            file.write("Fecha: " + new Date().toString() + "\n");
            file.write("Total effects: " + allEffectsWithPaths.length + "\n\n");
            
            for (var i = 0; i < allEffectsWithPaths.length; i++) {
                var effect = allEffectsWithPaths[i];
                file.write((i + 1) + ". " + effect.name + "\n");
                file.write("   Path: " + effect.path + "\n\n");
            }
            
            file.close();
            return "Success: Effects list exported to " + fileName + " on desktop.";
        } else {
            return "Error: Could not create export file.";
        }
        
    } catch (e) {
        return "Error exporting effects: " + e.toString();
    }
}

// Initialize scanning
scanEffects();