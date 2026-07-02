# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

## [1.0.0] — 2026-06-27

### Added
- Primera versión portátil de VIBE.
- 5 campos de comentario: ETIQUETA, POR QUÉ, FUENTE, EFECTIVIDAD, CAMBIOS.
- 3 modos: `anotar` (automático en proyectos adoptados), `auditar` (reportar), `arreglar` (lote con gate).
- Sintaxis para 13+ tipos de archivo (Markdown, Python, JS, SQL, JSON, etc.).
- Regla de **adopción autosuficiente** para activar en cualquier proyecto.
- Distinción clara entre instrucciones internas de IA (SÍ) y entregables (NO).

### Rationale
Extraída de `poweredchamba/REGLA#1` para ser portátil y agnóstica del lenguaje. Pensada para que los prompts se comenten y refactoricen como código.

---

## Planes futuros

- [ ] CLI autónomo (`vibe-cli`) para auditar/arreglar sin depender de Claude.
- [ ] Validador de formato VIBE en CI/CD.
- [ ] Integración con sistemas de control de versiones (git hooks).
