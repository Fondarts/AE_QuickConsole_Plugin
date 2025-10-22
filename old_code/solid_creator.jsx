#target aftereffects

function createSolid(colorName) {
    try {
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "No active composition";
        }
        
        var colors = {
            "red": [1, 0, 0],
            "green": [0, 1, 0],
            "blue": [0, 0, 1],
            "white": [1, 1, 1],
            "black": [0, 0, 0],
            "yellow": [1, 1, 0],
            "cyan": [0, 1, 1],
            "magenta": [1, 0, 1],
            "orange": [1, 0.5, 0],
            "purple": [0.5, 0, 1]
        };
        
        var color = colors[colorName.toLowerCase()];
        if (!color) {
            return "Unknown color: " + colorName;
        }
        
        app.beginUndoGroup("Create Solid");
        var layer = comp.layers.addSolid(color, colorName + " Solid", comp.width, comp.height, 1, comp.duration);
        app.endUndoGroup();
        
        return "Created " + colorName + " solid";
        
    } catch (e) {
        return "Error: " + e.toString();
    }
}

