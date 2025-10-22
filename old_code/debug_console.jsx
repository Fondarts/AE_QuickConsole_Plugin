#target aftereffects
// Debug script to test command console functionality

(function() {
    try {
        alert("Debug script started");
        
        // Test 1: Check if we're in After Effects
        if (!app.project) {
            alert("Error: Not in After Effects");
            return;
        }
        alert("✓ After Effects detected");
        
        // Test 2: Check if we have an active composition
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            alert("Warning: No active composition. Creating test composition...");
            comp = app.project.items.addComp("Test Comp", 1920, 1080, 1, 10, 25);
            comp.openInViewer();
        }
        alert("✓ Active composition: " + comp.name);
        
        // Test 3: Check if processCommand function exists
        if (typeof processCommand === 'undefined') {
            alert("Error: processCommand function not found!");
            return;
        }
        alert("✓ processCommand function found");
        
        // Test 4: Test a simple command
        alert("Testing 'null' command...");
        var result = processCommand("null");
        alert("Result: " + result);
        
        // Test 5: Test with layers
        if (comp.numLayers > 0) {
            comp.layer(1).selected = true;
            alert("Testing 'mute' command on selected layer...");
            var result2 = processCommand("mute");
            alert("Mute result: " + result2);
        } else {
            alert("No layers in composition to test layer commands");
        }
        
        alert("Debug complete!");
        
    } catch (error) {
        alert("Debug error: " + error.toString());
    }
})();
