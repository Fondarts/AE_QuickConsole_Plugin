// CSInterface.js - Adobe CEP Extension Interface
// Simplified version for AE Quick Console Plugin

(function() {
    'use strict';
    
    function CSInterface() {
        this.THEME_COLOR_CHANGED_EVENT = "com.adobe.csxs.events.ThemeColorChanged";
        this.APPLICATION_THEME_COLOR_CHANGED_EVENT = "com.adobe.csxs.events.ApplicationThemeColorChanged";
    }
    
    CSInterface.prototype.evalScript = function(script, callback) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.evalScript(script, callback);
        } else {
            // Fallback for testing
            if (callback) callback("EvalScript error.");
        }
    };
    
    CSInterface.prototype.addEventListener = function(type, listener, obj) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.addEventListener(type, listener, obj);
        }
    };
    
    CSInterface.prototype.removeEventListener = function(type, listener, obj) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.removeEventListener(type, listener, obj);
        }
    };
    
    CSInterface.prototype.getSystemPath = function(pathType) {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getSystemPath(pathType);
        }
        return "";
    };
    
    CSInterface.prototype.getApplicationID = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getApplicationID();
        }
        return "AEFT";
    };
    
    CSInterface.prototype.getApplicationVersion = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getApplicationVersion();
        }
        return "0.0.0";
    };
    
    CSInterface.prototype.getHostEnvironment = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getHostEnvironment();
        }
        return '{"appName":"AEFT","appVersion":"0.0.0","appLocale":"en_US","appUILocale":"en_US","appId":"AEFT","isAppOnline":true,"appSkinInfo":{"baseFontFamily":"Adobe Clean","baseFontSize":11,"appBarBackgroundColor":{"red":61,"green":69,"blue":67,"alpha":255},"panelBackgroundColor":{"red":56,"green":61,"blue":61,"alpha":255},"appBarBackgroundColorSRGB":{"red":61,"green":69,"blue":67,"alpha":255},"panelBackgroundColorSRGB":{"red":56,"green":61,"blue":61,"alpha":255}}}';
    };
    
    CSInterface.prototype.closeExtension = function() {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.closeExtension();
        }
    };
    
    CSInterface.prototype.requestOpenExtension = function(extensionId, params) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.requestOpenExtension(extensionId, params);
        }
    };
    
    CSInterface.prototype.getExtensions = function(extensionIds) {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getExtensions(extensionIds);
        }
        return [];
    };
    
    CSInterface.prototype.getNetworkPreferences = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getNetworkPreferences();
        }
        return {};
    };
    
    CSInterface.prototype.setScaleFactorChangedHandler = function(handler) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setScaleFactorChangedHandler(handler);
        }
    };
    
    CSInterface.prototype.setThemeChangedHandler = function(handler) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setThemeChangedHandler(handler);
        }
    };
    
    CSInterface.prototype.setApplicationThemeChangedHandler = function(handler) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setApplicationThemeChangedHandler(handler);
        }
    };
    
    CSInterface.prototype.setPanelFlyoutMenu = function(menu) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setPanelFlyoutMenu(menu);
        }
    };
    
    CSInterface.prototype.updatePanelMenuItem = function(menuId, enabled, checked) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.updatePanelMenuItem(menuId, enabled, checked);
        }
    };
    
    CSInterface.prototype.setContextMenu = function(menu, callback) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setContextMenu(menu, callback);
        }
    };
    
    CSInterface.prototype.setContextMenuByJSON = function(menuDef, callback) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setContextMenuByJSON(menuDef, callback);
        }
    };
    
    CSInterface.prototype.requestOpenLink = function(url) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.requestOpenLink(url);
        }
    };
    
    CSInterface.prototype.getApplicationScreens = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getApplicationScreens();
        }
        return [];
    };
    
    CSInterface.prototype.getColor = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getColor();
        }
        return {red: 0, green: 0, blue: 0, alpha: 255};
    };
    
    CSInterface.prototype.setColor = function(color) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setColor(color);
        }
    };
    
    CSInterface.prototype.getMenuBounds = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getMenuBounds();
        }
        return {x: 0, y: 0, width: 0, height: 0};
    };
    
    CSInterface.prototype.setWindowTitle = function(title) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setWindowTitle(title);
        }
    };
    
    CSInterface.prototype.getWindowTitle = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getWindowTitle();
        }
        return "";
    };
    
    CSInterface.prototype.getScaleFactor = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getScaleFactor();
        }
        return 1.0;
    };
    
    CSInterface.prototype.setScaleFactorChangedHandler = function(handler) {
        if (window.__adobe_cep__) {
            window.__adobe_cep__.setScaleFactorChangedHandler(handler);
        }
    };
    
    CSInterface.prototype.getCurrentApiVersion = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getCurrentApiVersion();
        }
        return "9.0.0";
    };
    
    CSInterface.prototype.getCurrentApiVersion = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getCurrentApiVersion();
        }
        return "9.0.0";
    };
    
    CSInterface.prototype.getCurrentApiVersion = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getCurrentApiVersion();
        }
        return "9.0.0";
    };
    
    // Static methods
    CSInterface.getCurrentApiVersion = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getCurrentApiVersion();
        }
        return "9.0.0";
    };
    
    CSInterface.getCurrentApiVersion = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getCurrentApiVersion();
        }
        return "9.0.0";
    };
    
    CSInterface.getCurrentApiVersion = function() {
        if (window.__adobe_cep__) {
            return window.__adobe_cep__.getCurrentApiVersion();
        }
        return "9.0.0";
    };
    
    // Export to global scope
    window.CSInterface = CSInterface;
    
})();

