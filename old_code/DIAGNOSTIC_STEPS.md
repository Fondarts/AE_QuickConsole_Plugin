# Pasos de Diagnóstico para AE Quick Console

## Paso 1: Verificar la Instalación

1. **Abre After Effects**
2. **Ve a Window > Extensions**
3. **¿Aparece "Command Console with Settings"?**
   - ✅ SÍ: Continúa al Paso 2
   - ❌ NO: El plugin no está instalado correctamente

## Paso 2: Verificar la Carga del Plugin

1. **Abre el plugin** (Window > Extensions > Command Console with Settings)
2. **Abre la consola de After Effects** (Window > Info)
3. **En el plugin, escribe "test" y presiona Enter**
4. **¿Qué mensaje aparece en la barra de estado del plugin?**
   - ✅ "Test command executed successfully!" = Plugin funciona
   - ❌ "Error: Script execution failed" = Problema de comunicación
   - ❌ "Error: No response from JSX" = JSX no se carga

## Paso 3: Verificar la Consola de After Effects

1. **En la consola de After Effects, busca estos mensajes:**
   - "AE Quick Console: JSX script loaded successfully"
   - "AE Quick Console: processCommand function available: true"
2. **¿Aparecen estos mensajes?**
   - ✅ SÍ: El JSX se carga correctamente
   - ❌ NO: El JSX no se está cargando

## Paso 4: Probar Comandos Básicos

1. **Crea una nueva composición** (Ctrl+N)
2. **Agrega una capa** (cualquier archivo de video/imagen)
3. **Selecciona la capa**
4. **En el plugin, prueba estos comandos:**
   - `test` - Debería mostrar "Test command executed successfully!"
   - `null` - Debería crear una capa null
   - `mute` - Debería silenciar la capa seleccionada

## Paso 5: Verificar Extensiones No Firmadas

1. **Ejecuta el archivo `enable_unsigned_extensions.reg`**
2. **Reinicia After Effects**
3. **Prueba nuevamente**

## Paso 6: Usar la Versión Simple

Si nada funciona, prueba la versión simple:

1. **Copia el archivo `manifest_simple.xml` y renómbralo a `manifest.xml`**
2. **Reinicia After Effects**
3. **Busca "Command Console Simple Test" en Extensions**
4. **Prueba los comandos básicos**

## Mensajes de Error Comunes

### "Error: Script execution failed"
- El archivo JSX no se está cargando
- Verifica que el archivo existe en la carpeta correcta
- Verifica que las extensiones no firmadas están habilitadas

### "Error: No response from JSX"
- La función processCommand no existe
- El archivo JSX tiene errores de sintaxis
- Verifica la consola de After Effects para errores

### "Error: No active composition"
- Crea una composición antes de usar comandos
- Algunos comandos requieren una composición activa

### "Error: No layers selected"
- Selecciona capas antes de usar comandos de capas
- Algunos comandos requieren capas seleccionadas

## Archivos de Diagnóstico

- `debug_console.jsx` - Script de diagnóstico completo
- `simple_test.jsx` - Versión simplificada del procesador
- `manifest_simple.xml` - Manifest para la versión simple

## Solución Rápida

Si nada funciona, ejecuta este script en After Effects:

```javascript
// Ejecuta esto en la consola de After Effects (Window > Info)
app.project.items.addComp("Test", 1920, 1080, 1, 10, 25);
alert("Composición de prueba creada. Ahora prueba el plugin.");
```
