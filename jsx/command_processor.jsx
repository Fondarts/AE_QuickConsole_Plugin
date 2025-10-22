// Simple Effect Scanner V26 - Only scans 2 specific folders
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
                        effectName = effectName.replace(/%20/g, " "); // Decode URL spaces
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
    
    // Post-processing: Fix CC effect names
    fixCCEffectNames();
    
    // Add layer creation commands to the list
    addLayerCommands();
    
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

// Apply effect to active layer or execute command
function applyEffect(effectName) {
    try {
        // Check if this is a layer creation command
        var parts = effectName.split(" ");
        var action = parts[0].toLowerCase();
        
        if (action === "solid" || action === "text" || action === "light" || 
            action === "camera" || action === "null" || action === "adjustment") {
            // This is a layer creation command, use processCreateCommand
            return processCreateCommand(effectName);
        } else if (action === "select" || action === "unselect" || action === "solo" || action === "unsolo") {
            // This is a layer selection command that needs parameters
            return "Enter layer numbers (e.g., 1,2,4) or press Enter for selected layers";
        }
        
        // This is a regular effect, apply to layer
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

// Process layer selection commands
function processLayerCommand(command) {
    try {
        // Validate command parameter
        if (!command || typeof command !== 'string') {
            return "Error: Invalid command parameter.";
        }
        
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "Error: Please select a composition first.";
        }
        
        var layers = comp.layers;
        if (layers.length === 0) {
            return "Error: No layers in composition.";
        }
        
        // Parse command - handle trim safely
        var trimmedCommand = command.replace(/^\s+|\s+$/g, ''); // Manual trim
        if (trimmedCommand === '') {
            return "Error: Empty command.";
        }
        
        var parts = trimmedCommand.split(" ");
        var action = parts[0].toLowerCase();
        
        app.beginUndoGroup(action.charAt(0).toUpperCase() + action.substring(1) + " Layers");
        
        if (action === "select") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: select 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            // Convert to layer indices (After Effects uses 1-based indexing)
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num); // After Effects uses 1-based indexing
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            // Select specified layers (add to selection)
            for (var j = 0; j < layerIndices.length; j++) {
                layers[layerIndices[j]].selected = true;
            }
            return "Success: Selected layers " + layerNumbers;
            
        } else if (action === "unselect") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: unselect 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            // Convert to layer indices (After Effects uses 1-based indexing)
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num); // After Effects uses 1-based indexing
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            // Unselect specified layers
            for (var k = 0; k < layerIndices.length; k++) {
                layers[layerIndices[k]].selected = false;
            }
            return "Success: Unselected layers " + layerNumbers;
            
        } else if (action === "solo") {
            var layerIndices = [];
            
            if (parts.length >= 2) {
                // Solo specified layers
                var layerNumbers = parts[1];
                var numbers = layerNumbers.split(",");
                
                // Convert to layer indices (After Effects uses 1-based indexing)
                for (var i = 0; i < numbers.length; i++) {
                    var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                    var num = parseInt(numStr);
                    if (num >= 1 && num <= layers.length) {
                        layerIndices.push(num); // After Effects uses 1-based indexing
                    } else {
                        return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                    }
                }
            } else {
                // Solo selected layers
                for (var l = 0; l < layers.length; l++) {
                    if (layers[l + 1].selected) { // After Effects uses 1-based indexing
                        layerIndices.push(l + 1); // Store 1-based index
                    }
                }
                if (layerIndices.length === 0) {
                    return "Error: No layers selected. Please select layers first or specify layer numbers.";
                }
            }
            
            // Solo specified layers (hide all others) - using Adobe's Layer.solo property
            for (var m = 1; m <= layers.length; m++) {
                layers[m].solo = false; // First, unsolo all layers (1-based indexing)
            }
            for (var n = 0; n < layerIndices.length; n++) {
                layers[layerIndices[n]].solo = true; // Then solo specified layers
            }
            
            if (parts.length >= 2) {
                return "Success: Solo layers " + parts[1];
            } else {
                return "Success: Solo selected layers";
            }
            
        } else if (action === "unsolo") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: unsolo 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            // Convert to layer indices (After Effects uses 1-based indexing)
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num); // After Effects uses 1-based indexing
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            // Unsolo specified layers
            for (var o = 0; o < layerIndices.length; o++) {
                layers[layerIndices[o]].solo = false;
            }
            return "Success: Unsolo layers " + layerNumbers;
            
        } else {
            return "Error: Unknown command '" + action + "'. Use: select, unselect, solo, or unsolo";
        }
        
                } catch (e) {
        return "Error: " + e.toString();
    } finally {
        app.endUndoGroup();
    }
}

// Process layer creation commands
function processCreateCommand(command) {
    try {
        // Validate command parameter
        if (!command || typeof command !== 'string') {
            return "Error: Invalid command parameter.";
        }
        
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "Error: Please select a composition first.";
        }
        
        // Parse command - handle trim safely
        var trimmedCommand = command.replace(/^\s+|\s+$/g, ''); // Manual trim
        if (trimmedCommand === '') {
            return "Error: Empty command.";
        }
        
        var parts = trimmedCommand.split(" ");
        var action = parts[0].toLowerCase();
        
        app.beginUndoGroup("Create " + action.charAt(0).toUpperCase() + action.substring(1));
        
        if (action === "solid") {
            var color = [1, 1, 1]; // Default white
            var name = "Solid";
            
            if (parts.length >= 2) {
                var colorName = parts[1].toLowerCase();
                
                // Define colors
                var colors = {
                    "red": [1, 0, 0],
                    "blue": [0, 0, 1],
                    "yellow": [1, 1, 0],
                    "black": [0, 0, 0],
                    "white": [1, 1, 1],
                    "purple": [0.5, 0, 0.5]
                };
                
                if (colors[colorName]) {
                    color = colors[colorName];
                    name = "Solid " + colorName.charAt(0).toUpperCase() + colorName.substring(1);
                } else if (colorName.match(/^[0-9a-fA-F]{6}$/)) {
                    // Hexadecimal color
                    var hex = colorName;
                    var r = parseInt(hex.substr(0, 2), 16) / 255;
                    var g = parseInt(hex.substr(2, 2), 16) / 255;
                    var b = parseInt(hex.substr(4, 2), 16) / 255;
                    color = [r, g, b];
                    name = "Solid #" + hex.toUpperCase();
                } else {
                    return "Error: Unknown color '" + colorName + "'. Use: red, blue, yellow, black, white, purple, or hex (e.g., 11B159)";
                }
            }
            
            // Create solid layer
            var solid = comp.layers.addSolid(color, name, comp.width, comp.height, comp.pixelAspect);
            return "Success: Created " + name + " layer";
            
        } else if (action === "text") {
            // Create text layer
            var textLayer = comp.layers.addText("Text");
            return "Success: Created text layer";
            
        } else if (action === "light") {
            // Create light layer
            var light = comp.layers.addLight("Light", [0, 0]);
            return "Success: Created light layer";
            
        } else if (action === "camera") {
            // Create camera layer
            var camera = comp.layers.addCamera("Camera", [0, 0]);
            return "Success: Created camera layer";
            
        } else if (action === "null") {
            // Create null layer
            var nullLayer = comp.layers.addNull();
            return "Success: Created null layer";
            
        } else if (action === "adjustment" || action === "adjustmentlayer") {
            // Create adjustment layer
            var adjLayer = comp.layers.addSolid([1, 1, 1], "Adjustment Layer", comp.width, comp.height, comp.pixelAspect);
            adjLayer.adjustmentLayer = true;
            return "Success: Created adjustment layer";
            
        } else {
            return "Error: Unknown create command '" + action + "'. Use: solid, text, light, camera, null, or adjustment";
        }
        
    } catch (e) {
        return "Error: " + e.toString();
    } finally {
        app.endUndoGroup();
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

// Function to fix CC effect names after scanning
function fixCCEffectNames() {
    // Known CC effects that need "CC " prefix
    var ccEffectsMap = {
        "Composite": "CC Composite",
        "Bubbles": "CC Bubbles", 
        "BallAction": "CC Ball Action",
        "Ball Action": "CC Ball Action",
        "BendIt": "CC Bend It",
        "Bend It": "CC Bend It",
        "Bender": "CC Bender",
        "Blobbylize": "CC Blobbylize",
        "Block Load": "CC Block Load",
        "Burn Film": "CC Burn Film",
        "Color Neutralizer": "CC Color Neutralizer",
        "Color Offset": "CC Color Offset",
        "Cylinder": "CC Cylinder",
        "Environment": "CC Environment",
        "Flo Motion": "CC Flo Motion",
        "Force Motion Blur": "CC Force Motion Blur",
        "Glass": "CC Glass",
        "Griddler": "CC Griddler",
        "HexTile": "CC HexTile",
        "Histogram": "CC Histogram",
        "Image Wipe": "CC Image Wipe",
        "Kaleida": "CC Kaleida",
        "Lens": "CC Lens",
        "Light Burst 2.5": "CC Light Burst 2.5",
        "Light Rays": "CC Light Rays",
        "Light Sweep": "CC Light Sweep",
        "Page Turn": "CC Page Turn",
        "Particle Systems II": "CC Particle Systems II",
        "Particle World": "CC Particle World",
        "Pixel Polly": "CC Pixel Polly",
        "Power Pin": "CC Power Pin",
        "Radial Blur": "CC Radial Blur",
        "Radial Fast Blur": "CC Radial Fast Blur",
        "Radial ScaleWipe": "CC Radial ScaleWipe",
        "RepeTile": "CC RepeTile",
        "Ripple Pulse": "CC Ripple Pulse",
        "Scale Wipe": "CC Scale Wipe",
        "Scatterize": "CC Scatterize",
        "Simple Wire Removal": "CC Simple Wire Removal",
        "Slant": "CC Slant",
        "Smear": "CC Smear",
        "Sphere": "CC Sphere",
        "Split": "CC Split",
        "Split2": "CC Split2",
        "Spotlight": "CC Spotlight",
        "Star Burst": "CC Star Burst",
        "Threshold": "CC Threshold",
        "Threshold RGB": "CC Threshold RGB",
        "Threads": "CC Threads",
        "Time Blend": "CC Time Blend",
        "Time Blend FX": "CC Time Blend FX",
        "Toner": "CC Toner",
        "Twister": "CC Twister",
        "Vector Blur": "CC Vector Blur",
        "Warpo": "CC Warpo",
        "Wave Warp": "CC Wave Warp",
        "Wide Time": "CC Wide Time",
        "Wireframe": "CC Wireframe"
    };
    
    // Additional effects that need spacing fixes
    var additionalEffectsMap = {
        "3DGlasses": "3D Glasses",
        "3DCameraTracker": "3D Camera Tracker",
        "3DGlasses": "3D Glasses",
        "AddGrain": "Add Grain",
        "ApplyColorLUT": "Apply Color Lut",
        "AuxChannelExtract": "3D Channel Extract",
        "AudioSpectrum": "Audio Spectrum",
        "AudioWaveform": "Audio Waveform",
        "AutoColor": "Auto Color",
        "AutoContrast": "Auto Contrast",
        "AutoLevels": "Auto Levels",
        "BevelAlpha": "Bevel Alpha",
        "BevelEdges": "Bevel Edges",
        "BezWarp New": "Bezier Warp",
        "Bilateral": "Bilateral Blur",
        "BilateralBlur": "Bilateral Blur",
        "BlockLoad": "CC Block Load",
        "BoxBlur": "Box Blur",
        "BurnFilm": "CC Burn Film",
        "BrightnessContrast": "Brightness & Contrast",
        "BrushStrokes": "Brush Strokes",
        "CameraLensBlur": "Camera Lens Blur",
        "CannedWarp": "CC Canned Warp",
        "ChangeColor": "Change Color",
        "ChangeToColor": "Change to Color",
        "ChannelBlur": "Channel Blur",
        "CineonEffect": "Cineon Converter",
        "Color Balance 2": "Color Balance",
        "ColorBalance": "Color Balance",
        "Color Diff": "Color Difference Key",
        "ColorDifferenceKey": "Color Difference Key",
        "Color Emboss": "Color Emboss",
        "ColorEmboss": "Color Emboss",
        "Color HLS": "Hue & Saturation",
        "ColorKey": "Color Key",
        "ColorLink": "Color Link",
        "ColorNeutralizer": "CC Color Neutralizer",
        "ColorOffset": "CC Color Offset",
        "ColorRange": "Color Range",
        "ColorShift": "Color Shift",
        "CompoundBlur": "Compound Blur",
        "CornerPin": "Corner Pin",
        "DepthMatte": "Depth Matte",
        "DepthOfField": "Depth of Field",
        "DifferenceMatte": "Difference Matte",
        "DirectionalBlur": "Directional Blur",
        "DropShadow": "Drop Shadow",
        "DustScratches": "Dust & Scratches",
        "ExpressionControls": "Expression Controls",
        "FastBlur": "Fast Blur",
        "GaussianBlur": "Gaussian Blur",
        "Glow": "Glow",
        "GradientWipe": "Gradient Wipe",
        "HueSaturation": "Hue & Saturation",
        "InnerShadow": "Inner Shadow",
        "LensFlare": "Lens Flare",
        "Levels": "Levels",
        "LinearWipe": "Linear Wipe",
        "MotionBlur": "Motion Blur",
        "Noise": "Noise",
        "NoiseHLS": "Noise HLS",
        "NoiseHLSAuto": "Noise HLS Auto",
        "Offset": "Offset",
        "OpticalCompensation": "Optical Compensation",
        "ParticlePlayground": "Particle Playground",
        "PathText": "Path Text",
        "Posterize": "Posterize",
        "RadialBlur": "Radial Blur",
        "RadialWipe": "Radial Wipe",
        "ReduceInterlaceFlicker": "Reduce Interlace Flicker",
        "Ripple": "Ripple",
        "Shatter": "Shatter",
        "Sharpen": "Sharpen",
        "ShiftChannels": "Shift Channels",
        "Spherize": "Spherize",
        "Text": "Text",
        "TimeDisplacement": "Time Displacement",
        "Tint": "Tint",
        "TurbulentDisplace": "Turbulent Displace",
        "Twirl": "Twirl",
        "UnsharpMask": "Unsharp Mask",
        "VectorPaint": "Vector Paint",
        "VenetianBlinds": "Venetian Blinds",
        "WaveWarp": "Wave Warp",
        "Wiggler": "Wiggler"
    };
    
    // Audio effects mapping (based on After Effects Plugin Match Names)
    var audioEffectsMap = {
        "Aud BT": "Bass & Treble",
        "Aud Delay": "Delay", 
        "Aud Flange": "Flange & Chorus",
        "Aud HiLo": "High-Low Pass",
        "Aud Mixer": "Stereo Mixer",
        "Aud Modulator": "Modulator",
        "Aud ParamEQ": "Parametric EQ",
        "Aud Reverb": "Reverb",
        "Aud Reverse": "Backwards",
        "Aud Tone": "Tone",
        "AudSpect": "Audio Spectrum",
        "AudWave": "Audio Waveform"
    };
    
    // Update allEffects array
    for (var i = 0; i < allEffects.length; i++) {
        var effectName = allEffects[i];
        if (ccEffectsMap[effectName]) {
            allEffects[i] = ccEffectsMap[effectName];
        } else if (additionalEffectsMap[effectName]) {
            allEffects[i] = additionalEffectsMap[effectName];
        } else if (audioEffectsMap[effectName]) {
            allEffects[i] = audioEffectsMap[effectName];
        }
    }
    
    // Update allEffectsWithPaths array
    for (var j = 0; j < allEffectsWithPaths.length; j++) {
        var effect = allEffectsWithPaths[j];
        if (ccEffectsMap[effect.name]) {
            effect.name = ccEffectsMap[effect.name];
        } else if (additionalEffectsMap[effect.name]) {
            effect.name = additionalEffectsMap[effect.name];
        } else if (audioEffectsMap[effect.name]) {
            effect.name = audioEffectsMap[effect.name];
        }
    }
}

// Add layer creation commands to the effects list
function addLayerCommands() {
    var layerCommands = [
        "solid red",
        "solid blue", 
        "solid yellow",
        "solid black",
        "solid white",
        "solid purple",
        "solid green",
        "solid orange",
        "solid pink",
        "solid cyan",
        "solid magenta",
        "solid gray",
        "text",
        "light",
        "camera",
        "null",
        "adjustment layer",
        "select",
        "solo",
        "unselect",
        "unsolo"
    ];
    
    // Add commands to the effects list
    for (var i = 0; i < layerCommands.length; i++) {
        allEffects.push(layerCommands[i]);
        allEffectsWithPaths.push({
            name: layerCommands[i],
            path: "COMMAND: " + layerCommands[i]
        });
    }
    
    // Re-sort the list
    allEffects.sort();
    allEffectsWithPaths.sort(function(a, b) {
        return a.name.localeCompare(b.name);
    });
}

// Initialize scanning
scanEffects();