# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

## [2.2.1] — 2026-07-02

### Changed
- **Calificación en el chat sin barras de bloques**: el formato pasa de `📊 Dificultad: 6/10 ██████░░░░ …` a la línea limpia en negritas `📊 Dificultad: 6/10 · Prompt: 7/10` — los caracteres `░` se renderean como barras blancas en varias interfaces (feedback de Francisco; corregido con la reconstrucción de §8 editando solo el bloque culpable de `SKILL.md` §6.1). El mismo formato aplica en títulos y cuerpos de PR.

### Fixed
- Los archivos de la v2.2.0 (`statusline.sh`, `install.sh` y la regla de `evo-score`) no habían llegado a `main` porque el PR #2 se mergeó antes del último push; esta versión los incluye.

## [2.2.0] — 2026-07-02

### Added
- **Barra integrada a la UI de Claude Code** (`statusline.sh`): chips `DF N/10 · Promt M/10` en la statusline nativa, con color por rango (DF alto = rojo, prompt bien planteado = verde). La skill escribe las notas en `~/.claude/evo-score` (regla nueva en `SKILL.md` §6.1) y el script las pinta.
- **`install.sh`**: instala la skill y configura la statusline sin pisar una existente. Con `--siempre`, agrega una regla global (`~/.claude/CLAUDE.md`) para que DF/Promt se califiquen en **todos** los proyectos, aunque no usen Evoprompting — pensado para ayudar a iterar en cualquier lado.
- **Tip de iteración**: cuando Prompt ≤ 6, Claude dice en una línea cómo plantear mejor la próxima petición (en el chat y como parte del marcador permanente).

## [2.1.0] — 2026-07-02

### Added
- **Barra de calificación visible en Claude** (`SKILL.md` §6.1): al evaluar una tarea, la respuesta en el chat abre con `📊 Dificultad: N/10 ██████░░░░ · Prompt: M/10 ███████░░░` seguida de las razones de cada nota. Los PRs conservan la línea corta en el título y la barra al inicio del cuerpo. Aplica a cualquiera que instale la skill.

### Changed
- README: la sección de ejemplo ahora muestra **los dos casos** — prompt (el principal, con el ciclo completo de evolución ante feedback) y código — y documenta la barra de calificación.

## [2.0.1] — 2026-07-02

### Fixed
- **Nombre corregido: Evopromting → Evoprompting** (con la segunda "p") en todos los archivos. El comando pasa a `/evoprompting`. La URL del repo conserva el nombre histórico hasta que se renombre en GitHub (la redirección de GitHub cubre ambos).

### Changed
- Quitadas las menciones a modelos específicos (Fable 5): la skill es **agnóstica de modelo** — funciona con Claude, GPT, Gemini, DeepSeek o cualquier modelo que lea instrucciones. No hay nada que ajustar por modelo.

### Added
- **Calificación visible en PRs** (`SKILL.md` §6.1): cuando el trabajo termina en un pull request, el título y el cuerpo llevan la línea `Dificultad: N/10 · Prompt: M/10` (dificultad de la tarea + qué tan bien planteada estaba la petición). GitHub no permite poner datos propios junto a sus contadores +/− del diff; el título del PR es la misma fila de la lista, lo más cercano posible.

## [2.0.0] — 2026-07-02

### Changed
- **Renombrada VIBE → Evoprompting.** El tag de comentario pasa de `VIBE ·` a `EVO ·` y el comando de `/vibe` a `/evoprompting`. Los comentarios `VIBE ·` existentes siguen siendo válidos (v1 del formato) y se migran al editarlos, sin borrar su historial (ver `SKILL.md` §13).
- Archivos compañeros renombrados: `<archivo>.vibe.md` → `<archivo>.evo.md`.
- README corregido: la instalación ahora clona el repo a `~/.claude/skills/evoprompting` (antes indicaba copiar una carpeta `vibe/` que no existía).

### Added
- **Evaluación previa de la tarea** (`SKILL.md` §6, modo `evaluar`): ranking de dificultad 1–10 con criterios y umbrales de acción; inventario de recursos de la sesión con mapa de fortalezas de agentes (GPT → búsqueda web, DeepSeek → segunda opinión de bajo costo, Gemini → ecosistema Google); jerarquía de vía de ejecución (MCP primero → control directo con permiso → guiar).
- **Modo `mejorar`** (§7): reescribe la petición del usuario como prompt estructurado por partes (PERSONALIDAD, CONTEXTO, OBJETIVO, RESTRICCIONES, RECURSOS), cada parte anotada.
- **Reconstrucción ante feedback negativo** (§8): en vez de parchar a ciegas, derivar del feedback el prompt que sí habría producido lo que el usuario quería, y editar solo el bloque culpable con cambio fechado.
- **Puntuación de cooperación del usuario** (§9): 0/1/2 por respuesta; aviso directo cuando la falta de cooperación bloquea una tarea que la exige al 100%.
- **Honestidad brutal** (§10) como regla transversal.
- Ejemplos nuevos en `example.md`: bloque PERSONALIDAD, salida de `evaluar`, petición evoprompteada con `mejorar`, y reconstrucción ante feedback.

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

- [ ] CLI autónomo (`evoprompting-cli`) para auditar/arreglar sin depender de Claude.
- [ ] Validador de formato EVO en CI/CD.
- [ ] Integración con sistemas de control de versiones (git hooks).
