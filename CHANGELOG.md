# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

## [2.0.0] — 2026-07-02

### Changed
- **Renombrada VIBE → Evopromting.** El tag de comentario pasa de `VIBE ·` a `EVO ·` y el comando de `/vibe` a `/evopromting`. Los comentarios `VIBE ·` existentes siguen siendo válidos (v1 del formato) y se migran al editarlos, sin borrar su historial (ver `SKILL.md` §13).
- Archivos compañeros renombrados: `<archivo>.vibe.md` → `<archivo>.evo.md`.
- Skill actualizada y probada con Claude Fable 5 (familia Claude 5).
- README corregido: la instalación ahora clona el repo a `~/.claude/skills/evopromting` (antes indicaba copiar una carpeta `vibe/` que no existía).

### Added
- **Evaluación previa de la tarea** (`SKILL.md` §6, modo `evaluar`): ranking de dificultad 1–10 con criterios y umbrales de acción; inventario de recursos de la sesión con mapa de fortalezas de agentes (GPT → búsqueda web, DeepSeek → segunda opinión de bajo costo, Gemini → ecosistema Google); jerarquía de vía de ejecución (MCP primero → control directo con permiso → guiar).
- **Modo `mejorar`** (§7): reescribe la petición del usuario como prompt estructurado por partes (PERSONALIDAD, CONTEXTO, OBJETIVO, RESTRICCIONES, RECURSOS), cada parte anotada.
- **Reconstrucción ante feedback negativo** (§8): en vez de parchar a ciegas, derivar del feedback el prompt que sí habría producido lo que el usuario quería, y editar solo el bloque culpable con cambio fechado.
- **Puntuación de cooperación del usuario** (§9): 0/1/2 por respuesta; aviso directo cuando la falta de cooperación bloquea una tarea que la exige al 100%.
- **Honestidad brutal** (§10) como regla transversal.
- Ejemplos nuevos en `example.md`: bloque PERSONALIDAD, salida de `evaluar`, petición evopromteada con `mejorar`, y reconstrucción ante feedback.

### Rationale
La v1 resolvía la memoria (comentarios por bloque). La v2 ataca el problema completo: el primer resultado de la IA da ~70% del trabajo en minutos y el otro 30% tomaba días de iteración a ciegas — la evaluación previa y la reconstrucción dirigida convierten esa iteración en cirugía.

## [1.0.0] — 2026-06-27

### Added
- Primera versión portátil de VIBE.
- 5 campos de comentario: ETIQUETA, POR QUÉ, FUENTE, EFECTIVIDAD, CAMBIOS.
- 3 modos: `anotar` (automático en proyectos adoptados), `auditar` (reportar), `arreglar` (lote con gate).
- Sintaxis para 13+ tipos de archivo (Markdown, Python, JS, SQL, JSON, etc.).
- Regla de **adopción autosuficiente** para activar en cualquier proyecto.
- Distinción clara entre instrucciones internas de IA (SÍ) y entregables (NO).

### Rationale
Extraída de una regla de proyecto para ser portátil y agnóstica del lenguaje. Pensada para que los prompts se comenten y refactoricen como código.

---

## Planes futuros

- [ ] CLI autónomo (`evopromting-cli`) para auditar/arreglar sin depender de Claude.
- [ ] Validador de formato EVO en CI/CD.
- [ ] Integración con sistemas de control de versiones (git hooks).
