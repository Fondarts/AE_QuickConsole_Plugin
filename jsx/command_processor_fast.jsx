// Global variable to store all available effects
var allEffects = null;
var isScanning = false;
var scanProgress = 0;
var totalScanned = 0;

// CSInterface for communication with HTML
var csInterface = new CSInterface();

// Fast plugin directory scanner with real-time progress
function fastScanPluginDirectories() {
    var pluginEffects = [];
    var totalScanned = 0;
    var foundCount = 0;
    
    try {
        // Detect After Effects installation path automatically
        var aePath = "";
        try {
            aePath = Folder.appPackage.fsName;
        } catch (e) {
            // Use fallback path
        }

        // Plugin directories to scan
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

        // Fast recursive directory scanner
        function fastScanDirectory(dir, depth) {
            if (depth > 3) return; // Limit depth
            
            try {
                if (dir.exists) {
                    var files = dir.getFiles();
                    totalScanned += files.length;
                    
                    // Update progress every 10 files
                    if (totalScanned % 10 === 0) {
                        updateScanProgress(foundCount, totalScanned);
                    }
                    
                    for (var i = 0; i < files.length; i++) {
                        var file = files[i];
                        if (file instanceof Folder) {
                            fastScanDirectory(file, depth + 1);
                        } else {
                            // Check if it's a plugin file
                            var fileName = file.name.toLowerCase();
                            if (fileName.indexOf(".aex") !== -1 ||
                                fileName.indexOf(".plugin") !== -1 ||
                                fileName.indexOf(".bundle") !== -1) {
                                
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
                                    foundCount++;
                                    
                                    // Update progress every 5 found effects
                                    if (foundCount % 5 === 0) {
                                        updateScanProgress(foundCount, totalScanned);
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (e) {
                // Continue scanning other directories
            }
        }

        // Scan all plugin directories
        for (var i = 0; i < pluginPaths.length; i++) {
            var dir = new Folder(pluginPaths[i]);
            fastScanDirectory(dir, 0);
        }

    } catch (e) {
        // Continue with fallback
    }

    return pluginEffects;
}

// Update scan progress in real-time
function updateScanProgress(found, scanned) {
    try {
        csInterface.evalScript('updateStatus("Scanning... Found: ' + found + ' | Scanned: ' + scanned + '", "")');
    } catch (e) {
        // Ignore communication errors
    }
}

// Fast effects initialization with incremental loading
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
        var pluginEffects = fastScanPluginDirectories();
        
        // Add plugin effects to the list
        for (var i = 0; i < pluginEffects.length; i++) {
            if (allEffects.indexOf(pluginEffects[i]) === -1) {
                allEffects.push(pluginEffects[i]);
            }
        }
        
        // Sort the final list
        allEffects.sort();
        
        // Update final status
        updateScanProgress(allEffects.length, 0);
        
    } catch (e) {
        // Continue with known effects only
    }
    
    return allEffects;
}

// Initialize effects on script load
initializeEffects();

// Function to get effects count for HTML status update
function getEffectsCount() {
    return window.effectsCount || 0;
}

// Function to find effects by partial name match
function findEffectsByName(partialName) {
    var effects = initializeEffects(); // Use the full scanned effects list
    var matches = [];
    var lowerPartial = partialName.toLowerCase();
    
    for (var i = 0; i < effects.length; i++) {
        if (effects[i].toLowerCase().indexOf(lowerPartial) !== -1) {
            matches.push(effects[i]);
        }
    }
    
    return matches;
}

// Main command processor function
function processCommand(command) {
    try {
        var cmd = command.toLowerCase().trim();
        
        if (cmd === "test") {
            return "Plugin is working! Available commands: list effects, [effect name]";
        }
        
        if (cmd === "list effects") {
            try {
                var effects = initializeEffects(); // Use the full scanned effects list
                if (effects.length === 0) {
                    return "No effects found. Make sure you have a composition open.";
                }
                
                // Save to file
                var fileName = "AE_Effects_List_" + new Date().getFullYear() + "_" + (new Date().getMonth() + 1) + "_" + new Date().getDate() + ".txt";
                var desktopPath = Folder.desktop.fsName;
                var filePath = desktopPath + "/" + fileName;
                var file = new File(filePath);
                
                if (file.open("w")) {
                    file.write("After Effects Effects List\n");
                    file.write("==========================\n");
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
