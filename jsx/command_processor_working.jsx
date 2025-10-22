// Working version - no complex JSX calls
var allEffects = [
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

// Set effects count
window.effectsCount = allEffects.length;

// Test function
function testJSX() {
    return "JSX is working! Found " + allEffects.length + " effects";
}

// Function to get effects count
function getEffectsCount() {
    return window.effectsCount || 0;
}

// Function to find effects by name
function findEffectsByName(partialName) {
    var matches = [];
    var lowerPartial = partialName.toLowerCase();
    
    for (var i = 0; i < allEffects.length; i++) {
        if (allEffects[i].toLowerCase().indexOf(lowerPartial) !== -1) {
            matches.push(allEffects[i]);
        }
    }
    
    return matches;
}

// Main command processor
function processCommand(command) {
    try {
        var cmd = command.toLowerCase().trim();
        
        if (cmd === "test") {
            return "Plugin is working! Available commands: list effects, [effect name]";
        }
        
        if (cmd === "list effects") {
            try {
                // Save to file
                var fileName = "AE_Effects_List_" + new Date().getFullYear() + "_" + (new Date().getMonth() + 1) + "_" + new Date().getDate() + ".txt";
                var desktopPath = Folder.desktop.fsName;
                var filePath = desktopPath + "/" + fileName;
                var file = new File(filePath);
                
                if (file.open("w")) {
                    file.write("After Effects Effects List\n");
                    file.write("==========================\n");
                    file.write("Fecha: " + new Date().toString() + "\n");
                    file.write("Total effects: " + allEffects.length + "\n\n");
                    
                    for (var i = 0; i < allEffects.length; i++) {
                        file.write((i + 1) + ". " + allEffects[i] + "\n");
                    }
                    
                    file.close();
                }
                
                var effectList = allEffects.slice(0, 10).join(", ");
                if (allEffects.length > 10) {
                    effectList += "... and " + (allEffects.length - 10) + " more";
                }
                
                return "Available effects (" + allEffects.length + " total): " + effectList + "\n\nLista guardada en: " + fileName;
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
