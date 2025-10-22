# AE Quick Console Plugin

## Versión Final - Funcional

Este es el plugin de consola de comandos para After Effects que funciona correctamente.

## Archivos Principales

- **`command_console.html`** - Interfaz principal del plugin
- **`jsx/command_processor.jsx`** - Procesador de comandos
- **`CSXS/manifest.xml`** - Configuración del plugin
- **`css/style.css`** - Estilos de la interfaz
- **`js/lib/CSInterface.js`** - Librería de comunicación con After Effects

## Comandos Disponibles

### Crear Elementos (no requieren capas seleccionadas):
- `null` - Crear capa null
- `adjustment` - Crear capa de ajuste
- `shape` - Crear capa de forma
- `camera` - Crear cámara
- `light` - Crear luz

### Operaciones de Capas (requieren capas seleccionadas):
- `mute` - Silenciar capas
- `unmute` - Activar capas
- `solo` - Solo capas
- `unsolo` - Unsolo capas
- `duplicate` - Duplicar capas
- `delete` - Eliminar capas
- `hide` - Ocultar capas
- `show` - Mostrar capas
- `reset` - Resetear transformaciones

### Efectos:
- Cualquier nombre de efecto de After Effects (ej: `Gaussian Blur`, `Glow`, `Keylight`, etc.)
- **Búsqueda inteligente**: Si no encuentra el efecto exacto, busca efectos similares
- **Comando especial**: `list effects` - Muestra todos los efectos disponibles

### Comandos Especiales:
- **`list effects`** - Escanea y muestra todos los efectos instalados en After Effects

## Instalación

1. Copia la carpeta `AE_QuickConsole_Plugin` a `%APPDATA%\Adobe\CEP\extensions\`
2. Ejecuta `enable_unsigned_extensions.reg` (en la carpeta old_code)
3. Reinicia After Effects
4. Ve a `Window > Extensions > Command Console`

## Carpeta old_code

Contiene todos los archivos de versiones anteriores, scripts de instalación, y código que no funcionaba. Se mantiene como respaldo.

## Características Nuevas

🔍 **ESCANEO AUTOMÁTICO DE EFECTOS**
- Detecta automáticamente todos los efectos instalados
- Búsqueda inteligente por nombre parcial
- Sugerencias de efectos similares si no encuentra el exacto
- Comando `list effects` para ver todos los efectos disponibles

## Estado

✅ **FUNCIONANDO CORRECTAMENTE**
- Plugin básico sin configuraciones
- Comandos simples y efectivos
- Interfaz limpia y funcional
- **NUEVO**: Escaneo automático de todos los efectos instalados
