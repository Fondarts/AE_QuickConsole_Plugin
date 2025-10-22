#target aftereffects

function executeCommand(command) {
    try {
        if (!command || command.trim() === "") {
            return "No command provided";
        }
        
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "No active composition";
        }
        
        var sel = comp.selectedLayers;
        if (!sel || sel.length === 0) {
            return "No layers selected";
        }
        
        var cmd = command.toLowerCase().trim();
        
        if (cmd === "mute") {
            app.beginUndoGroup("Mute");
            for (var i = 0; i < sel.length; i++) {
                sel[i].audioEnabled = false;
            }
            app.endUndoGroup();
            return "Layers muted";
        }
        
        if (cmd === "unmute") {
            app.beginUndoGroup("Unmute");
            for (var i = 0; i < sel.length; i++) {
                sel[i].audioEnabled = true;
            }
            app.endUndoGroup();
            return "Layers unmuted";
        }
        
        if (cmd === "duplicate") {
            app.beginUndoGroup("Duplicate");
            for (var i = 0; i < sel.length; i++) {
                sel[i].duplicate();
            }
            app.endUndoGroup();
            return "Layers duplicated";
        }
        
        if (cmd === "solo") {
            app.beginUndoGroup("Solo");
            for (var i = 0; i < sel.length; i++) {
                sel[i].solo = true;
            }
            app.endUndoGroup();
            return "Layers soloed";
        }
        
        if (cmd === "unsolo") {
            app.beginUndoGroup("Unsolo");
            for (var i = 0; i < sel.length; i++) {
                sel[i].solo = false;
            }
            app.endUndoGroup();
            return "Layers unsoloed";
        }
        
        if (cmd === "reset") {
            app.beginUndoGroup("Reset Transform");
            for (var i = 0; i < sel.length; i++) {
                var layer = sel[i];
                layer.transform.anchorPoint.setValue([0, 0]);
                layer.transform.position.setValue([comp.width/2, comp.height/2]);
                layer.transform.scale.setValue([100, 100]);
                layer.transform.rotation.setValue(0);
                layer.transform.opacity.setValue(100);
            }
            app.endUndoGroup();
            return "Transform reset";
        }
        
        if (cmd === "null") {
            app.beginUndoGroup("Create Null");
            comp.layers.addNull();
            app.endUndoGroup();
            return "Null created";
        }
        
        if (cmd === "adjustment") {
            app.beginUndoGroup("Create Adjustment");
            var layer = comp.layers.addSolid([1, 1, 1], "Adjustment Layer", comp.width, comp.height, 1, comp.duration);
            layer.adjustmentLayer = true;
            app.endUndoGroup();
            return "Adjustment layer created";
        }
        
        if (cmd === "shape") {
            app.beginUndoGroup("Create Shape");
            comp.layers.addShape();
            app.endUndoGroup();
            return "Shape created";
        }
        
        if (cmd === "camera") {
            app.beginUndoGroup("Create Camera");
            comp.layers.addCamera("Camera 1", [comp.width/2, comp.height/2]);
            app.endUndoGroup();
            return "Camera created";
        }
        
        if (cmd === "light") {
            app.beginUndoGroup("Create Light");
            comp.layers.addLight("Light 1", [comp.width/2, comp.height/2]);
            app.endUndoGroup();
            return "Light created";
        }
        
        return "Unknown command: " + command;
        
    } catch (e) {
        return "Error: " + e.toString();
    }
}

