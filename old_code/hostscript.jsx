#target aftereffects
// AE Quick Console Plugin - JSX Engine
// Adapted from AE_QuickConsole_ScriptUI_v13.jsx

(function(){

function _err(msg){ 
    return "QuickConsole: " + msg; 
}

function _getComp(){
    if (!app.project || !app.project.activeItem || !(app.project.activeItem instanceof CompItem)) {
        throw "No active comp.";
    }
    return app.project.activeItem;
}

function _hexToRGB(hex){
    hex = (hex+"").replace("#","");
    if (hex.length===3) hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];
    if (hex.length!==6) return [0,0,0];
    return [parseInt(hex.substr(0,2),16)/255, parseInt(hex.substr(2,2),16)/255, parseInt(hex.substr(4,2),16)/255];
}

function _namedColorRGB(name){
    var map = {
        red:"#ff0000", green:"#00ff00", blue:"#0000ff",
        black:"#000000", white:"#ffffff", gray:"#808080", grey:"#808080",
        yellow:"#ffff00", cyan:"#00ffff", magenta:"#ff00ff",
        orange:"#ffa500", purple:"#800080", pink:"#ff69b4",
        teal:"#008080", lime:"#bfff00", navy:"#000080",
        maroon:"#800000", olive:"#808000", aqua:"#00ffff"
    };
    var hex = map[(name+"").toLowerCase()];
    return hex ? _hexToRGB(hex) : null;
}

function _labelIndex(name){
    var map = {
        "none":0, "red":1, "yellow":2, "aqua":3, "pink":4, "lavender":5, "peach":6, "seafoam":7,
        "blue":8, "green":9, "purple":10, "orange":11, "brown":12, "fuchsia":13, "cyan":14, "sand":15, "teal":16
    };
    name = (name+"").toLowerCase();
    return map.hasOwnProperty(name) ? map[name] : -1;
}

function _parseIndices(spec){
    var out=[], parts=(spec+"").split(/[\s,]+/);
    for (var i=0;i<parts.length;i++){
        var p=parts[i].trim();
        if (!p) continue;
        if (p.indexOf('-')>=0){
            var ab=p.split('-'); var a=parseInt(ab[0],10), b=parseInt(ab[1],10);
            if (!isNaN(a)&&!isNaN(b)&&b>=a){ for (var k=a;k<=b;k++) out.push(k); }
        } else {
            var n=parseInt(p,10); if (!isNaN(n)) out.push(n);
        }
    }
    return out;
}

function _looksLikeFull(q){
    var lower = q.toLowerCase().trim();
    if (!lower) return false;
    if (/^(mute|unmute|hide|show|null|adjustment|shape|camera|light|duplicate|duplicate with properties|shy|unshy|convert to 3d|unconvert|bring to front|send to back|reverse layers|solo|unsolo|toggle quality|toggle motion blur|motion blur on|motion blur off|toggle frame blending|toggle adjustment|toggle guide|add to render queue|add to media encoder|remove effects|toggle fx|enable comp shy|disable comp shy|enable comp motion blur|disable comp motion blur)$/.test(lower)) return true;
    if (/^parent\s+to\s+\d+$/.test(lower)) return true;
    if (/^track\s*matte\s*to\s*\d+(?:\s+(alpha|luma))?(?:\s+invert)?$/.test(lower)) return true;
    if (/^select\s+[\d,\-\s]+$/.test(lower)) return true;
    if (/^label\s+[a-z]+$/.test(lower)) return true;
    if (/^precomp(\s+name\s*=\s*.+)?$/.test(lower)) return true;
    if (/^solid(\s+\d+x\d+)?(\s+#[0-9a-fA-F]+)?(\s+.+)?$/.test(lower)) return true;
    if (/^solid\s+[a-z]+(\s+.+)?$/.test(lower)) return true;
    if (/^text\s+.+/.test(lower)) return true;
    if (/^(reset|center anchor|center in comp|fit to comp|fit to comp width|fit to comp height|flip horizontal|flip vertical)$/.test(lower)) return true;
    if (/^blending\s+(normal|multiply|screen|overlay|soft light|hard light|difference|exclusion|color|hue|saturation|luminosity|dissolve|darken|lighten|add|subtract|pin light|color dodge|color burn|linear dodge|linear burn)/.test(lower)) return true;
    return false;
}

// Helpers
function _selectedLayersMust(){
    var c=_getComp();
    var sel=c.selectedLayers;
    if (!sel||!sel.length) throw "No layers selected";
    return sel;
}

function _centerAnchor(layer){
    var r = layer.sourceRectAtTime(app.project.activeItem.time, false);
    var anchor = [r.left + r.width/2, r.top + r.height/2];
    try { layer.property("ADBE Transform Group").property("ADBE Anchor Point").setValue(anchor); } catch(e){}
}

function _centerInComp(layer){
    var c=_getComp();
    try {
        layer.property("ADBE Transform Group").property("ADBE Position").setValue([c.width/2, c.height/2]);
    } catch(e){}
}

function _fitToComp(layer, mode){ // mode: all|w|h
    var c=_getComp();
    try{
        var sr = layer.sourceRectAtTime(c.time,false);
        var sx = c.width / Math.max(1, sr.width);
        var sy = c.height / Math.max(1, sr.height);
        var s = 100;
        if (mode==="all"){ s = Math.min(sx, sy)*100; }
        else if (mode==="w"){ s = sx*100; }
        else if (mode==="h"){ s = sy*100; }
        layer.transform.scale.setValue([s, s]);
        _centerInComp(layer);
    }catch(e){}
}

function _flip(layer, axis){ // axis 'h' or 'v'
    try{
        var sc = layer.transform.scale.value;
        if (axis==='h') layer.transform.scale.setValue([-Math.abs(sc[0]), sc[1]]);
        else layer.transform.scale.setValue([sc[0], -Math.abs(sc[1])]);
    }catch(e){}
}

function _parseTimecode(t, comp){
    t = (t+"").trim();
    if (/^\d+(\.\d+)?$/.test(t)) return parseFloat(t); // seconds
    if (/^\d+f$/.test(t)) { var fr = parseInt(t,10); return fr/comp.frameRate; }
    // h:m:s or m:s
    var parts = t.split(':');
    var sec = 0;
    if (parts.length===2){
        sec = parseInt(parts[0],10)*60 + parseFloat(parts[1]);
    } else if (parts.length===3){
        sec = parseInt(parts[0],10)*3600 + parseInt(parts[1],10)*60 + parseFloat(parts[2]);
    } else {
        // fallback: frames if number without f
        var v = parseFloat(t); if (!isNaN(v)) return v;
        throw "Bad time format";
    }
    return sec;
}

function _blendingModeFromName(name){
    var n=(name+"").toLowerCase();
    var map={
        "normal":BlendingMode.NORMAL,
        "multiply":BlendingMode.MULTIPLY,
        "screen":BlendingMode.SCREEN,
        "overlay":BlendingMode.OVERLAY,
        "soft light":BlendingMode.SOFT_LIGHT,
        "hard light":BlendingMode.HARD_LIGHT,
        "difference":BlendingMode.DIFFERENCE,
        "exclusion":BlendingMode.EXCLUSION,
        "color":BlendingMode.COLOR,
        "hue":BlendingMode.HUE,
        "saturation":BlendingMode.SATURATION,
        "luminosity":BlendingMode.LUMINOSITY,
        "dissolve":BlendingMode.DISSOLVE,
        "darken":BlendingMode.DARKEN,
        "lighten":BlendingMode.LIGHTEN,
        "add":BlendingMode.ADD,
        "subtract":BlendingMode.SUBTRACT,
        "pin light":BlendingMode.PIN_LIGHT,
        "color dodge":BlendingMode.COLOR_DODGE,
        "color burn":BlendingMode.COLOR_BURN,
        "linear dodge":BlendingMode.LINEAR_DODGE,
        "linear burn":BlendingMode.LINEAR_BURN
    };
    return map[n] || null;
}

function runCommand(q){
    try {
        q = (q+"").trim();
        if (!q) return "No command provided";
        
        // Log the command for debugging
        $.writeln("AE Quick Console: Executing command: " + q);

        // Try effect by name first
        try {
            app.beginUndoGroup("Apply Effect by Name");
            var comp=_getComp();
            var sel=comp.selectedLayers;
            if (sel && sel.length>0){
                var ok=false;
                for (var i=0;i<sel.length;i++){
                    try{ var ad=sel[i].property("ADBE Effect Parade").addProperty(q); if (ad) ok=true; }catch(e){}
                }
                app.endUndoGroup();
                if (ok) return "Effect applied successfully";
            } else { app.endUndoGroup(); }
        } catch(e){}

        var lower = q.toLowerCase();
        var m;

        // --- New quick commands ---
        if (lower==="bring to front"){
            app.beginUndoGroup("Bring To Front");
            var sel=_selectedLayersMust();
            sel.sort(function(a,b){return a.index-b.index;});
            for (var i=0;i<sel.length;i++) sel[i].moveToBeginning();
            app.endUndoGroup(); return "Brought to front";
        }
        if (lower==="send to back"){
            app.beginUndoGroup("Send To Back");
            var sel=_selectedLayersMust();
            sel.sort(function(a,b){return b.index-a.index;});
            for (var i=0;i<sel.length;i++) sel[i].moveToEnd();
            app.endUndoGroup(); return "Sent to back";
        }
        if (lower==="reverse layers"){
            app.beginUndoGroup("Reverse Layers");
            var c=_getComp(); var sel=_selectedLayersMust();
            var idx = []; for (var i=0;i<sel.length;i++) idx.push(sel[i].index);
            idx.sort(function(a,b){return a-b;});
            for (var i=0;i<Math.floor(idx.length/2); i++){
                var top = c.layer(idx[idx.length-1-i]);
                var bottom = c.layer(idx[i]);
                top.moveBefore(bottom);
            }
            app.endUndoGroup(); return "Layers reversed";
        }
        if (lower==="reset"){
            app.beginUndoGroup("Reset Transform");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){
                var L=sel[i];
                try{
                    L.transform.anchorPoint.setValue([0,0]);
                    L.transform.position.setValue([_getComp().width/2,_getComp().height/2]);
                    L.transform.scale.setValue([100,100]);
                    L.transform.rotation.setValue(0);
                    if (L.transform.yRotation) L.transform.yRotation.setValue(0);
                    if (L.transform.xRotation) L.transform.xRotation.setValue(0);
                    L.transform.opacity.setValue(100);
                }catch(e){}
            }
            app.endUndoGroup(); return "Transform reset";
        }
        if (lower==="center anchor"){
            app.beginUndoGroup("Center Anchor");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++) _centerAnchor(sel[i]);
            app.endUndoGroup(); return "Anchor centered";
        }
        if (lower==="center in comp"){
            app.beginUndoGroup("Center In Comp");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++) _centerInComp(sel[i]);
            app.endUndoGroup(); return "Centered in comp";
        }
        if (lower==="fit to comp"){
            app.beginUndoGroup("Fit To Comp");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++) _fitToComp(sel[i], "all");
            app.endUndoGroup(); return "Fitted to comp";
        }
        if (lower==="fit to comp width"){
            app.beginUndoGroup("Fit To Comp Width");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++) _fitToComp(sel[i], "w");
            app.endUndoGroup(); return "Fitted to comp width";
        }
        if (lower==="fit to comp height"){
            app.beginUndoGroup("Fit To Comp Height");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++) _fitToComp(sel[i], "h");
            app.endUndoGroup(); return "Fitted to comp height";
        }
        if (lower==="flip horizontal"){
            app.beginUndoGroup("Flip H");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++) _flip(sel[i], 'h');
            app.endUndoGroup(); return "Flipped horizontally";
        }
        if (lower==="flip vertical"){
            app.beginUndoGroup("Flip V");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++) _flip(sel[i], 'v');
            app.endUndoGroup(); return "Flipped vertically";
        }
        if (lower==="solo" || lower==="unsolo"){
            app.beginUndoGroup("Solo");
            var sel=_selectedLayersMust();
            var on = (lower==="solo");
            for (var i=0;i<sel.length;i++) sel[i].solo = on;
            app.endUndoGroup(); return on ? "Solo enabled" : "Solo disabled";
        }
        if (lower==="toggle quality"){
            app.beginUndoGroup("Toggle Quality");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){
                sel[i].quality = (sel[i].quality===Quality.BEST) ? Quality.DRAFT : Quality.BEST;
            }
            app.endUndoGroup(); return "Quality toggled";
        }
        if (lower==="toggle motion blur" || lower==="motion blur on" || lower==="motion blur off"){
            app.beginUndoGroup("Motion Blur");
            var sel=_selectedLayersMust();
            var mode = lower;
            for (var i=0;i<sel.length;i++){
                if (mode==="toggle motion blur") sel[i].motionBlur = !sel[i].motionBlur;
                else sel[i].motionBlur = (mode==="motion blur on");
            }
            app.endUndoGroup(); return "Motion blur updated";
        }
        if (lower==="toggle frame blending"){
            app.beginUndoGroup("Frame Blending");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){ sel[i].frameBlending = !sel[i].frameBlending; }
            app.endUndoGroup(); return "Frame blending toggled";
        }
        if (lower==="toggle adjustment"){
            app.beginUndoGroup("Toggle Adjustment");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){ sel[i].adjustmentLayer = !sel[i].adjustmentLayer; }
            app.endUndoGroup(); return "Adjustment layer toggled";
        }
        if (lower==="toggle guide"){
            app.beginUndoGroup("Toggle Guide");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){ sel[i].guideLayer = !sel[i].guideLayer; }
            app.endUndoGroup(); return "Guide layer toggled";
        }
        if (lower==="add to render queue"){
            app.beginUndoGroup("Add to Render Queue");
            var c=_getComp();
            app.project.renderQueue.items.add(c);
            app.endUndoGroup(); return "Added to render queue";
        }
        if (lower==="add to media encoder"){
            app.beginUndoGroup("Add to Media Encoder");
            app.project.renderQueue.queueInAME(true);
            app.endUndoGroup(); return "Added to Media Encoder";
        }
        if (lower.indexOf("blending ")===0){
            var name = q.substr(9);
            var bm = _blendingModeFromName(name);
            if (!bm) throw "Unknown blending mode";
            app.beginUndoGroup("Set Blending");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){ sel[i].blendingMode = bm; }
            app.endUndoGroup(); return "Blending mode set to " + name;
        }
        if (lower==="remove effects"){
            app.beginUndoGroup("Remove Effects");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){
                var fx = sel[i].property("ADBE Effect Parade");
                if (!fx) continue;
                for (var k=fx.numProperties; k>=1; k--){ fx.property(k).remove(); }
            }
            app.endUndoGroup(); return "Effects removed";
        }
        if (lower==="toggle fx"){
            app.beginUndoGroup("Toggle FX");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){
                var fx = sel[i].property("ADBE Effect Parade"); if (!fx) continue;
                for (var k=1; k<=fx.numProperties; k++){ var p=fx.property(k); p.enabled = !p.enabled; }
            }
            app.endUndoGroup(); return "Effects toggled";
        }
        if (lower==="enable comp shy" || lower==="disable comp shy"){
            app.beginUndoGroup("Comp Shy");
            var c=_getComp(); c.hideShyLayers = (lower==="enable comp shy");
            app.endUndoGroup(); return "Comp shy " + (c.hideShyLayers ? "enabled" : "disabled");
        }
        if (lower==="enable comp motion blur" || lower==="disable comp motion blur"){
            app.beginUndoGroup("Comp Motion Blur");
            var c=_getComp(); c.motionBlur = (lower==="enable comp motion blur");
            app.endUndoGroup(); return "Comp motion blur " + (c.motionBlur ? "enabled" : "disabled");
        }

        // Existing commands…
        if (lower==="duplicate" || lower==="duplicate with properties"){
            app.beginUndoGroup("Duplicate");
            var comp=_getComp();
            var sel=comp.selectedLayers; if (!sel||!sel.length) throw "No layers selected";
            sel.sort(function(a,b){return a.index-b.index;});
            for (var i=0;i<sel.length;i++){ sel[i].duplicate(); }
            app.endUndoGroup(); return "Layers duplicated";
        }

        if (lower==="convert to 3d" || lower==="unconvert" || lower==="convert to 2d"){
            app.beginUndoGroup("Toggle 3D");
            var comp=_getComp();
            var sel=comp.selectedLayers; if (!sel||!sel.length) throw "No layers selected";
            var to3d = (lower==="convert to 3d");
            for (var i=0;i<sel.length;i++){ sel[i].threeDLayer = to3d ? true : false; }
            app.endUndoGroup(); return "3D " + (to3d ? "enabled" : "disabled");
        }

        // parent to N
        m = lower.match(/^parent\s+to\s+(\d+)$/);
        if (m){
            app.beginUndoGroup("Parent To");
            var comp=_getComp();
            var p=comp.layer(parseInt(m[1],10));
            if (!p) throw "Parent not found";
            var sel=comp.selectedLayers; if (!sel||!sel.length) throw "No layers selected";
            for (var i=0;i<sel.length;i++){ if (sel[i]!==p) sel[i].parent=p; }
            app.endUndoGroup(); return "Parented to layer " + m[1];
        }

        // track matte to N [alpha|luma] [invert]
        m = lower.match(/^track\s*matte\s*to\s*(\d+)(?:\s+(alpha|luma))?(?:\s+(invert))?$/);
        if (m){
            app.beginUndoGroup("Track Matte To");
            var comp=_getComp();
            var idx=parseInt(m[1],10);
            var type=(m[2]||"alpha");
            var inv = !!m[3];
            var matte=comp.layer(idx); if (!matte) throw "Matte not found";
            var sel=comp.selectedLayers; if (!sel||!sel.length) throw "No layers selected";
            var T = (type==="luma") ? (inv?TrackMatteType.LUMA_INVERTED:TrackMatteType.LUMA) : (inv?TrackMatteType.ALPHA_INVERTED:TrackMatteType.ALPHA);
            for (var i=0;i<sel.length;i++){
                var L=sel[i]; if (L.index===matte.index) continue;
                if (matte.index !== L.index-1){ matte.moveBefore(L); }
                L.trackMatteType = T;
            }
            app.endUndoGroup(); return "Track matte set";
        }

        // select 1,3-5
        m = lower.match(/^select\s+([\d,\-\s]+)$/);
        if (m){
            app.beginUndoGroup("Select Indices");
            var comp=_getComp();
            var idxs=_parseIndices(m[1]);
            for (var i=1;i<=comp.numLayers;i++) comp.layer(i).selected=false;
            for (var j=0;j<idxs.length;j++){ var L=comp.layer(idxs[j]); if (L) L.selected=true; }
            app.endUndoGroup(); return "Layers selected";
        }

        // label color
        m = lower.match(/^label\s+([a-z]+)$/);
        if (m){
            app.beginUndoGroup("Set Label");
            var comp=_getComp();
            var idx=_labelIndex(m[1]); if (idx<0) throw "Unknown label";
            var sel=comp.selectedLayers; if (!sel||!sel.length) throw "No layers selected";
            for (var i=0;i<sel.length;i++) sel[i].label=idx;
            app.endUndoGroup(); return "Label set to " + m[1];
        }

        // solid named color
        m = q.match(/^solid\s+([A-Za-z]+)(?:\s+(.+))?$/);
        if (m){
            app.beginUndoGroup("Create Solid (Named)");
            var comp=_getComp();
            var rgb = _namedColorRGB(m[1]);
            if (!rgb) throw "Unknown color name: " + m[1];
            var name = m[2] ? m[2] : ("Solid " + m[1]);
            comp.layers.addSolid(rgb, name, comp.width, comp.height, 1.0, comp.duration);
            app.endUndoGroup(); return "Solid created: " + name;
        }

        // solid WxH #hex Name
        m = q.match(/^solid(?:\s+(\d+)x(\d+))?(?:\s+(#?[0-9a-fA-F]+))?(?:\s+(.+))?$/i);
        if (m){
            app.beginUndoGroup("Create Solid");
            var comp=_getComp();
            var w=m[1]?parseInt(m[1],10):comp.width;
            var h=m[2]?parseInt(m[2],10):comp.height;
            var col=_hexToRGB(m[3]?m[3]:"#000000");
            var name=m[4]?m[4]:"Solid";
            comp.layers.addSolid(col, name, w, h, 1.0, comp.duration);
            app.endUndoGroup(); return "Solid created: " + name;
        }

        // text ...
        m = q.match(/^text\s+(.+)/i);
        if (m){
            app.beginUndoGroup("Create Text");
            var comp=_getComp();
            comp.layers.addText(m[1]);
            app.endUndoGroup(); return "Text created: " + m[1];
        }

        if (lower==="null"){
            app.beginUndoGroup("Create Null"); _getComp().layers.addNull(); app.endUndoGroup(); return "Null created";
        }
        if (lower==="adjustment"){
            app.beginUndoGroup("Create Adjustment"); var c=_getComp(); var L=c.layers.addSolid([1,1,1],"Adjustment Layer",c.width,c.height,1,c.duration); L.adjustmentLayer=true; app.endUndoGroup(); return "Adjustment layer created";
        }
        if (lower==="shape"){
            app.beginUndoGroup("Create Shape"); _getComp().layers.addShape(); app.endUndoGroup(); return "Shape created";
        }
        if (lower==="camera"){
            app.beginUndoGroup("Create Camera"); var c=_getComp(); c.layers.addCamera("Camera 1",[c.width/2,c.height/2]); app.endUndoGroup(); return "Camera created";
        }
        if (lower==="light"){
            app.beginUndoGroup("Create Light"); var c=_getComp(); c.layers.addLight("Light 1",[c.width/2,c.height/2]); app.endUndoGroup(); return "Light created";
        }

        // --- ARG MODE commands parsed from v11 ---
        m = q.match(/^rename\s+(.+)$/i);
        if (m){
            app.beginUndoGroup("Rename");
            var sel=_selectedLayersMust();
            for (var i=0;i<sel.length;i++){ sel[i].name = m[1]; }
            app.endUndoGroup(); return "Renamed to: " + m[1];
        }
        m = q.match(/^go\s*to\s*time\s+(.+)$/i);
        if (m){
            var c=_getComp();
            var t=_parseTimecode(m[1], c);
            if (t<0) t=0; if (t>c.duration) t=c.duration-1/c.frameRate;
            c.time = t; return "Time set to: " + t;
        }
        m = q.match(/^change\s*duration\s+(.+)$/i);
        if (m){
            app.beginUndoGroup("Change Duration");
            var c=_getComp();
            var d=_parseTimecode(m[1], c);
            if (d<=0) throw "Bad duration";
            c.duration = d;
            app.endUndoGroup(); return "Duration changed to: " + d;
        }
        m = q.match(/^wiggle\s*position(?:\s+(\d+(?:\.\d+)?))?(?:\s+(\d+(?:\.\d+)?))?$/i);
        if (m){
            app.beginUndoGroup("Wiggle Position");
            var sel=_selectedLayersMust();
            var f = m[1] ? parseFloat(m[1]) : 2;
            var a = m[2] ? parseFloat(m[2]) : 20;
            for (var i=0;i<sel.length;i++){
                sel[i].transform.position.expression = "wiggle(" + f + "," + a + ")";
            }
            app.endUndoGroup(); return "Wiggle applied: " + f + "Hz, " + a + "px";
        }

        return "Unknown command or effect: " + q;
        
    } catch (e) {
        return _err(e.toString());
    }
}

// Export functions for CEP
function executeCommand(command) {
    return runCommand(command);
}

function processCommand(command) {
    return runCommand(command);
}

// Make functions available globally for CSInterface
if (typeof window !== 'undefined') {
    window.runCommand = runCommand;
    window.executeCommand = executeCommand;
    window.processCommand = processCommand;
}

})();
