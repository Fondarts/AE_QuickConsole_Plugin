# Simple Effect Scanner V02

Un plugin para After Effects que escanea y permite aplicar efectos de manera rápida y eficiente.

## Características

- **Escaneo Automático**: Escanea automáticamente las carpetas de efectos de After Effects
- **Búsqueda en Tiempo Real**: Filtra efectos mientras escribes
- **Click para Aplicar**: Haz click en cualquier efecto para aplicarlo al layer activo
- **Exportar Lista**: Exporta la lista completa de efectos con paths a un archivo TXT
- **Interfaz Simple**: Interfaz limpia y fácil de usar

## Instalación

1. Ejecuta `V02_INSTALL.bat` como administrador
2. Cierra After Effects completamente
3. Abre After Effects
4. Ve a `Window > Extensions > Command Console`

## Uso

1. **Buscar Efectos**: Escribe en la barra de búsqueda para filtrar efectos
2. **Aplicar Efectos**: Haz click en cualquier efecto de la lista para aplicarlo
3. **Exportar Lista**: Haz click en "Export Effects List" para guardar la lista completa

## Carpetas Escaneadas

- `C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\Plug-ins\`
- `C:\Program Files\Adobe\Common\Plug-ins\7.0\MediaCore\`

## Carpetas Excluidas

- `Keyframe` - Efectos de keyframe del sistema
- `Extensions` - Extensiones del sistema
- `Format` - Formatos de archivo del sistema

## Requisitos

- Adobe After Effects 2020 o superior
- Windows 10/11
- Extensiones no firmadas habilitadas

## Versiones

- **V02**: Versión estable con todas las funcionalidades
- **V01**: Versión anterior (archivada en `old_code/`)

## Desarrollo

El plugin está desarrollado usando:
- HTML/CSS/JavaScript para la interfaz
- ExtendScript (JSX) para la comunicación con After Effects
- CEP (Common Extensibility Platform) para la integración

## Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.