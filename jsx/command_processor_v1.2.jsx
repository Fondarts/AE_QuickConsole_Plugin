// Command Processor v1.2 - Real Effect Scanning
// This version implements the working debug logic for effect scanning

var allEffects = null;
var csInterface = new CSInterface();

// Function to scan plugin directories (using the working debug logic)
function scanPluginDirectories() {
    var pluginEffects = [];
    var debugInfo = [];
    
    try {
        // Detect After Effects installation path automatically
        var aePath = "";
        try {
            aePath = Folder.appPackage.fsName;
            debugInfo.push("After Effects path detected: " + aePath);
        } catch (e) {
            debugInfo.push("Error detecting AE path: " + e.toString());
        }

        // Common plugin directories on Windows
        var pluginPaths = [
            aePath + "/Plug-ins/",
            "C:/Program Files/Adobe/Adobe After Effects 2025/Support Files/Plug-ins/",
            "C:/Program Files/Adobe/Adobe After Effects 2024/Support Files/Plug-ins/",
            "C:/Program Files/Adobe/Adobe After Effects 2023/Support Files/Plug-ins/",
            "C:/Program Files/Adobe/Adobe After Effects 2022/Support Files/Plug-ins/",
            "C:/Program Files/Adobe/Adobe After Effects 2021/Support Files/Plug-ins/",
            "C:/Program Files/Adobe/Adobe After Effects 2020/Support Files/Plug-ins/",
            "C:/Program Files/Adobe/Common/Plug-ins/7.0/MediaCore/",
            "C:/Program Files/Adobe/Common/Plug-ins/CC/MediaCore/",
            "C:/Program Files/Red Giant/",
            "C:/Program Files (x86)/Red Giant/",
            "C:/Program Files/Boris FX/",
            "C:/Program Files (x86)/Boris FX/",
            "C:/Program Files/GenArts/Sapphire/",
            "C:/Program Files (x86)/GenArts/Sapphire/",
            "C:/Program Files/Common Files/Adobe/Plug-Ins/",
            "C:/Program Files (x86)/Common Files/Adobe/Plug-Ins/",
            Folder.userData + "/Adobe/After Effects/",
            "C:/Program Files/Adobe/Common/Plug-ins/",
            "C:/Program Files (x86)/Adobe/Common/Plug-ins/"
        ];

        // Function to recursively scan a directory
        function scanDirectory(dir, depth) {
            if (depth > 3) return; // Limit depth to avoid infinite recursion
            
            try {
                if (dir.exists) {
                    debugInfo.push("SCANNING: " + dir.fsName);
                    var files = dir.getFiles();
                    debugInfo.push("  Found " + files.length + " items");
                    
                    for (var i = 0; i < files.length; i++) {
                        var file = files[i];
                        if (file instanceof Folder) {
                            // Recursively scan subdirectories
                            scanDirectory(file, depth + 1);
                        } else {
                            // Check if it's a plugin file
                            var fileName = file.name.toLowerCase();
                            if (fileName.indexOf(".aex") !== -1 ||
                                fileName.indexOf(".plugin") !== -1 ||
                                fileName.indexOf(".bundle") !== -1) {
                                
                                debugInfo.push("  FOUND PLUGIN: " + file.name);
                                
                                // Extract effect name from filename
                                var effectName = file.name;
                                if (effectName.indexOf(".aex") !== -1) {
                                    effectName = effectName.substring(0, effectName.indexOf(".aex"));
                                } else if (effectName.indexOf(".plugin") !== -1) {
                                    effectName = effectName.substring(0, effectName.indexOf(".plugin"));
                                } else if (effectName.indexOf(".bundle") !== -1) {
                                    effectName = effectName.substring(0, effectName.indexOf(".bundle"));
                                }
                                
                                // Clean up the name
                                effectName = effectName.replace(/_/g, " ");
                                effectName = effectName.replace(/-/g, " ");
                                effectName = effectName.replace(/%20/g, " "); // URL decode
                                
                                if (effectName && effectName !== "" && effectName.length > 1) {
                                    pluginEffects.push(effectName);
                                    debugInfo.push("  ADDED: " + effectName);
                                }
                            }
                        }
                    }
                } else {
                    debugInfo.push("NOT FOUND: " + dir.fsName);
                }
            } catch (e) {
                debugInfo.push("ERROR scanning " + dir.fsName + ": " + e.toString());
            }
        }

        // Scan all plugin directories
        for (var i = 0; i < pluginPaths.length; i++) {
            var dir = new Folder(pluginPaths[i]);
            scanDirectory(dir, 0);
        }

    } catch (e) {
        debugInfo.push("MAIN ERROR in scanPluginDirectories: " + e.toString());
    }

    return {effects: pluginEffects, debug: debugInfo};
}

// Auto-scan effects on startup
function initializeEffects() {
    if (allEffects !== null) {
        return allEffects;
    }
    
    // Start with known effects for immediate availability
    allEffects = [
        "3D Camera Tracker", "3D Glasses", "Add Grain", "Audio Spectrum", "Audio Waveform", 
        "Auto Color", "Auto Contrast", "Auto Levels", "Beam", "Bevel Alpha", "Bevel Edges", 
        "Bilateral Blur", "Box Blur", "Brightness & Contrast", "Brush Strokes", "Bulge", 
        "Camera Lens Blur", "Cartoon", "CC Ball Action", "CC Bend It", "CC Bender", 
        "CC Blobbylize", "CC Block Load", "CC Burn Film", "CC Color Neutralizer", 
        "CC Color Offset", "CC Composite", "CC Cylinder", "CC Environment", "CC Flo Motion", 
        "CC Force Motion Blur", "CC Glass", "CC Griddler", "CC HexTile", "CC Histogram", 
        "CC Image Wipe", "CC Kaleida", "CC Lens", "CC Light Burst 2.5", "CC Light Rays", 
        "CC Light Sweep", "CC Page Turn", "CC Particle Systems II", "CC Particle World", 
        "CC Pixel Polly", "CC Power Pin", "CC Radial Blur", "CC Radial Fast Blur", 
        "CC Radial ScaleWipe", "CC RepeTile", "CC Ripple Pulse", "CC Scale Wipe", 
        "CC Scatterize", "CC Simple Wire Removal", "CC Slant", "CC Smear", "CC Sphere", 
        "CC Split", "CC Split2", "CC Spotlight", "CC Star Burst", "CC Threshold", 
        "CC Threshold RGB", "CC Threads", "CC Time Blend", "CC Time Blend FX", "CC Toner", 
        "CC Twister", "CC Vector Blur", "CC Warpo", "CC Wave Warp", "CC Wide Time", 
        "CC Wireframe", "Cell Pattern", "Change Color", "Change to Color", "Channel Blur", 
        "Checkerboard", "Circle", "Color Balance", "Color Difference Key", "Color Emboss", 
        "Color Key", "Color Link", "Color Range", "Colorama", "Compound Blur", "Corner Pin", 
        "Crop", "Cryptomatte", "Curves", "Depth Matte", "Depth of Field", "Difference Matte", 
        "Directional Blur", "Distort", "Drop Shadow", "Dust & Scratches", "Echo", "Ellipse", 
        "Emboss", "Equalize", "Exposure", "Expression Controls", "Extract", "EXtractoR", 
        "Fast Box Blur", "Fill", "Find Edges", "Fractal", "Fractal Noise", "Gaussian Blur", 
        "Glow", "Grid", "Grow Bounds", "Hue/Saturation", "ID Matte", "IDentifier", 
        "Inner/Outer Key", "Invert", "Key Cleaner", "Keylight (1.2)", "Leave Color", 
        "Lens Distortion", "Lens Flare", "Levels", "Linear Color Key", "Luma Key", 
        "Lumetri Color", "Magnify", "Match Grain", "Matte Choker", "Median", "Mesh Warp", 
        "Mirror", "Mosaic", "Motion Tile", "Noise", "Noise Alpha", "Noise HLS", 
        "Noise HLS Auto", "Offset", "Optics Compensation", "Paint Bucket", "Parametric EQ", 
        "Photo Filter", "Pixel Motion Blur", "Polar Coordinates", "Posterize", 
        "Posterize Time", "PS Arbitrary Map", "Radial Blur", "Radial Shadow", "Radio Waves", 
        "Ramp", "Rectangle", "Refine Hard Matte", "Refine Matte", "Refine Soft Matte", 
        "Remove Grain", "Reshape", "Ripple", "Rolling Shutter Repair", "Roughen Edges", 
        "Scribble", "Scatter", "Shadow/Highlight", "Sharpen", "Simple Choker", "Smear", 
        "Spherize", "Spill Suppressor", "Stroke", "Strobe Light", "Stylize", "Texturize", 
        "Threshold", "Time Difference", "Time Displacement", "Timewarp", "Tint", "Tone", 
        "Transform", "Tritone", "Turbulent Displace", "Turbulent Noise", "Twirl", 
        "Ultra Key", "Unsharp Mask", "Vegas", "Vibrance", "Warp", "Wave Warp", "Write-on"
    ];
    
    // Now scan for additional plugins and add them
    try {
        var scanResult = scanPluginDirectories();
        var pluginEffects = scanResult.effects;
        var debugInfo = scanResult.debug;
        
        // Add plugin effects to the list
        for (var i = 0; i < pluginEffects.length; i++) {
            if (allEffects.indexOf(pluginEffects[i]) === -1) {
                allEffects.push(pluginEffects[i]);
            }
        }
        
        // Sort the final list
        allEffects.sort();
        
        // Save debug info to file
        try {
            var debugFileName = "AE_Plugin_Scan_Debug_v1.2_" + new Date().getFullYear() + "_" + (new Date().getMonth() + 1) + "_" + new Date().getDate() + ".txt";
            var desktopPath = Folder.desktop.fsName;
            var debugFilePath = desktopPath + "/" + debugFileName;
            var debugFile = new File(debugFilePath);
            
            if (debugFile.open("w")) {
                debugFile.write("After Effects Plugin Scan Debug v1.2\n");
                debugFile.write("====================================\n");
                debugFile.write("Fecha: " + new Date().toString() + "\n");
                debugFile.write("Plugin effects encontrados: " + pluginEffects.length + "\n");
                debugFile.write("Known effects: " + (allEffects.length - pluginEffects.length) + "\n");
                debugFile.write("Total effects: " + allEffects.length + "\n\n");
                
                debugFile.write("DETALLE DEL ESCANEO:\n");
                debugFile.write("===================\n");
                for (var j = 0; j < debugInfo.length; j++) {
                    debugFile.write(debugInfo[j] + "\n");
                }
                
                debugFile.write("\nFINAL EFFECTS LIST:\n");
                debugFile.write("===================\n");
                for (var k = 0; k < allEffects.length; k++) {
                    debugFile.write((k + 1) + ". " + allEffects[k] + "\n");
                }
                
                debugFile.close();
            }
        } catch (e) {
            // Debug file creation failed
        }
        
    } catch (e) {
        // Continue with known effects only
    }
    
    return allEffects;
}

// Initialize effects immediately
initializeEffects();

// Set effects count
window.effectsCount = allEffects ? allEffects.length : 0;

// Test function
function testJSX() {
    return "JSX v1.2 working! Found " + (allEffects ? allEffects.length : 0) + " effects";
}

// Function to get effects count
function getEffectsCount() {
    return window.effectsCount || 0;
}

// Function to find effects by name
function findEffectsByName(partialName) {
    var effects = allEffects || [];
    var matches = [];
    var lowerPartial = partialName.toLowerCase();
    
    for (var i = 0; i < effects.length; i++) {
        if (effects[i].toLowerCase().indexOf(lowerPartial) !== -1) {
            matches.push(effects[i]);
        }
    }
    
    return matches;
}

// Main command processor
function processCommand(command) {
    try {
        var cmd = command.toLowerCase().trim();
        
        if (cmd === "test") {
            return "Plugin v1.2 is working! Found " + (allEffects ? allEffects.length : 0) + " effects. Available commands: list effects, [effect name]";
        }
        
        if (cmd === "list effects") {
            try {
                var effects = allEffects || [];
                if (effects.length === 0) {
                    return "No effects found.";
                }
                
                // Save to file
                var fileName = "AE_Effects_List_v1.2_" + new Date().getFullYear() + "_" + (new Date().getMonth() + 1) + "_" + new Date().getDate() + ".txt";
                var desktopPath = Folder.desktop.fsName;
                var filePath = desktopPath + "/" + fileName;
                var file = new File(filePath);
                
                if (file.open("w")) {
                    file.write("After Effects Effects List v1.2\n");
                    file.write("===============================\n");
                    file.write("Fecha: " + new Date().toString() + "\n");
                    file.write("Total effects: " + effects.length + "\n\n");
                    
                    for (var i = 0; i < effects.length; i++) {
                        file.write((i + 1) + ". " + effects[i] + "\n");
                    }
                    
                    file.close();
                }
                
                var effectList = effects.slice(0, 10).join(", ");
                if (effects.length > 10) {
                    effectList += "... and " + (effects.length - 10) + " more";
                }
                
                return "Available effects (" + effects.length + " total, auto-scanned on startup): " + effectList + "\n\nLista guardada en: " + fileName;
            } catch (e) {
                return "Error listing effects: " + e.toString();
            }
        }
        
        // Try to apply effect
        var matches = findEffectsByName(command);
        if (matches.length > 0) {
            try {
                var comp = app.project.activeItem;
                if (!comp || !(comp instanceof CompItem)) {
                    return "Please select a composition first.";
                }
                
                var layer = comp.selectedLayers[0];
                if (!layer) {
                    return "Please select a layer first.";
                }
                
                app.beginUndoGroup("Apply Effect: " + matches[0]);
                
                try {
                    layer.effect.addProperty(matches[0]);
                    return "Effect '" + matches[0] + "' applied successfully!";
                } catch (e) {
                    return "Effect found but could not be applied: " + e.toString();
                } finally {
                    app.endUndoGroup();
                }
                
            } catch (e) {
                return "Error applying effect: " + e.toString();
            }
        } else {
            return "Effect '" + command + "' not found. Try 'list effects' to see available effects.";
        }
        
    } catch (e) {
        return "Error processing command: " + e.toString();
    }
}
