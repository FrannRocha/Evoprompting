# Evoprompting

> Los prompts evolucionan como el código: se comentan, se depuran por partes y aprenden de cada error.

**El problema:** cuando usas IA, el primer resultado te da ~70% del trabajo en 10–15 minutos. El otro 30% lo consigues iterando a ciegas y te toma días — el ahorro de tiempo se evapora, o recortas calidad para no iterar.

**La solución:** Evoprompting trata los prompts como código comentado y refactorizable. Cada bloque de instrucción lleva un comentario que explica **qué hace**, **por qué se eligió así**, **de dónde salió**, **qué tan bien funciona** y **su historial de cambios**. Y antes de cada tarea no trivial, el modelo evalúa la dificultad, sus recursos y tu cooperación — con honestidad brutal.

Funciona con **cualquier modelo** que lea instrucciones (Claude, GPT, Gemini, DeepSeek…) y con cualquier herramienta donde escribas prompts. No hay nada que ajustar por modelo: es metodología, no código.

## Los 5 pilares

1. **Memoria por bloque** — cada parte del prompt lleva su comentario EVO. Ejemplo: la parte *"eres un arquitecto de IA con 10 años de experiencia"* se anota como `PERSONALIDAD` — sirve para fijar el rol y el nivel del modelo, y si un día falla, sabes exactamente qué tocar.
2. **Ranking de dificultad 1–10** — antes de ejecutar, el modelo puntúa la tarea (¿hay documentación?, ¿es probable resolverla?). Si es 7+, primero mejora tu petición en vez de quemar días iterando.
3. **Inventario de recursos** — ¿qué hay disponible en la sesión? MCPs, control del navegador, control remoto, y otros modelos como agentes: **GPT** para búsquedas web, **DeepSeek** como segunda opinión de bajo costo, **Gemini** para el ecosistema Google. MCP primero; si falla, control directo (siempre con tu permiso).
4. **Evolución dirigida** — si dices "está mal", el modelo no parcha a ciegas: reconstruye *el prompt que le tendrías que haber dado* para que saliera como querías, edita solo el bloque culpable y anota el cambio fechado. El error no se repite.
5. **Honestidad brutal** — si tu petición está mal planteada, te lo dice. Si la tarea es un 9/10 improbable, te lo dice antes de empezar. Si no estás cooperando con las respuestas que necesita, también te lo dice.

## Instalación

### En Claude Code

Clona este repo dentro de tu directorio de skills:

```bash
# macOS/Linux
git clone https://github.com/FrannRocha/Evoprompting.git ~/.claude/skills/evoprompting

# Windows PowerShell
git clone https://github.com/FrannRocha/Evoprompting.git $env:USERPROFILE\.claude\skills\evoprompting
```

Luego invócala con `/evoprompting` en tu sesión.

### En otra herramienta

Si no usas Claude Code, copia el contenido de `SKILL.md` a tu system prompt o archivo de reglas (CLAUDE.md, .cursorrules, etc.). El formato de comentarios funciona en cualquier lugar donde escribas prompts.

## Uso rápido

| Comando | Qué hace |
|---|---|
| `/evoprompting anotar` | Comenta el bloque que acabas de crear/editar (automático en proyectos que adoptaron la skill) |
| `/evoprompting auditar <archivo>` | Reporta bloques sin comentario, campos faltantes o historial mal fechado — sin tocar nada |
| `/evoprompting arreglar <archivo>` | Completa y normaliza comentarios; muestra el diff y pide confirmación antes de escribir |
| `/evoprompting evaluar <tarea>` | Dificultad 1–10 con razones + inventario de recursos + vía de ejecución + cooperación |
| `/evoprompting mejorar <petición>` | Reescribe tu petición como un prompt estructurado por partes, cada parte anotada |

## El formato del comentario

Justo **debajo** de cada bloque, con 5 campos:

```
EVO · <ETIQUETA>: <qué hace> · POR QUÉ: <razón / resultado esperado> · FUENTE: <origen> · EFECTIVIDAD: <medida concreta o "sin medir"> · CAMBIOS: <líneas AAAA-MM-DD → cambio y razón>
```

| Campo | Ejemplo | Notas |
|-------|---------|-------|
| **ETIQUETA** | PERSONALIDAD, FILTRO, ROUTER, SALIDA | 1–2 palabras que nombren el rol del bloque |
| **POR QUÉ** | "fija el nivel con el que trabaja el modelo" | la razón de diseño; qué se perdería si se quita |
| **FUENTE** | "propio", "docs de X", "internet" | trazabilidad |
| **EFECTIVIDAD** | "sin medir", "probada: descartó scams" | inicia en `sin medir`; se actualiza con evidencia |
| **CAMBIOS** | "ninguno" o "2026-07-02 → fix del filtro" | cada edición agrega una línea fechada; el historial **nunca se borra** |

## Sintaxis por tipo de archivo

Elige la sintaxis del lenguaje para que el comentario no rompa ni se ejecute:

| Tipo | Sintaxis |
|------|----------|
| Markdown, HTML, XML, SVG | `<!-- EVO · ... -->` |
| YAML, TOML, shell, Python, Ruby | `# EVO · ...` |
| JS, TS, CSS, Java, Go, Rust | `// EVO · ...` o `/* EVO · ... */` |
| JSX / TSX | lógica → `// ...`; dentro del `return` → `{/* EVO · ... */}` |
| SQL | `-- EVO · ...` |
| JSON estricto, `.env` | archivo compañero `<archivo>.evo.md` |
| Sin comentarios seguros | archivo compañero `<archivo>.evo.md` |

## Cuándo sí y cuándo no

✅ **SÍ** — instrucciones internas para IA: SKILL.md, system prompts, reglas de CLAUDE.md, prompts de agentes y herramientas.

❌ **NO** — entregables que ve el cliente: landing HTML, README publicado, UI, correos. Si el archivo es algo que publicas o entregas, **no lleva EVO**, aunque su lenguaje lo permita.

*Criterio:* ¿Es un entregable final? → No. ¿Es instrucción interna de IA? → Sí.

## El loop de evolución

1. **Evalúa** antes de ejecutar: dificultad 1–10, recursos, entorno, cooperación.
2. **Anota** cada bloque de prompt con su comentario EVO.
3. Cuando algo falle, **reconstruye** el prompt que sí habría funcionado ("¿qué me tendrían que haber pedido para hacerlo tal cual?").
4. **Edita solo el bloque culpable** y agrega la línea fechada a su historial.

Así el prompt mejora con cada iteración en minutos, no en días — y la calidad no se sacrifica por el tiempo.

## Adoptar Evoprompting en un proyecto

Agrega a tu `CLAUDE.md` o `SKILL.md`:

```markdown
**Evoprompting activo en este proyecto.** En todo prompt/instrucción interna que la IA lee
(no en entregables que ve el cliente), agrega debajo de cada bloque:

`EVO · ETIQUETA: qué hace · POR QUÉ: razón / resultado · FUENTE: de dónde salió · EFECTIVIDAD: sin medir · CAMBIOS: AAAA-MM-DD → qué cambió`

Al editar un bloque, agrega una línea fechada a `CAMBIOS` y nunca borres el historial.
Ante feedback negativo, reconstruye el prompt que sí habría funcionado y edita solo el
bloque culpable. Detalle: skill `evoprompting`.
```

Eso activa el automatismo **solo en ese proyecto**, sin sobre-activarlo en los demás.

## La barra de calificación

Cada vez que Claude evalúa una tarea con Evoprompting, su respuesta abre con esta barra — la ves directo en el chat, igual que ves los contadores de GitHub:

```
📊 Dificultad: 6/10 ██████░░░░ · Prompt: 7/10 ███████░░░
```

- **Dificultad** — qué tan difícil es la tarea (¿hay documentación?, ¿qué probabilidad hay de resolverla con los recursos de la sesión?).
- **Prompt** — qué tan bien planteada estaba tu petición (claridad, contexto, restricciones). Sube si dejas que Claude la evoprompteé antes de ejecutar.

Si el trabajo termina en un pull request, la calificación se repite al final del título del PR y la barra al inicio de su descripción.

## Ejemplos reales

### Caso 1: en un prompt (el caso principal)

Un prompt anotado por partes. La parte de personalidad, versión 1:

```markdown
Eres un arquitecto de IA con 10 años de experiencia.
<!-- EVO · PERSONALIDAD: fija el rol y el nivel con el que trabaja el modelo. POR QUÉ: sin esto las respuestas salen genéricas, de nivel principiante. FUENTE: propio. EFECTIVIDAD: sin medir. CAMBIOS: ninguno. -->
```

El usuario da feedback: *"las respuestas salen muy teóricas, yo quiero pasos que pueda seguir"*. Evoprompting no parcha a ciegas — reconstruye el prompt que sí habría funcionado y edita **solo el bloque culpable**, dejando el porqué en el historial:

```markdown
Eres un arquitecto de IA con 10 años de experiencia implementando sistemas en producción; siempre respondes con pasos accionables, no con teoría.
<!-- EVO · PERSONALIDAD: fija rol, nivel y estilo ACCIONABLE. POR QUÉ: el rol solo daba respuestas teóricas; "en producción + pasos accionables" fuerza salidas ejecutables. FUENTE: feedback del usuario 2026-07-02. EFECTIVIDAD: falló v1 (teórica); v2 en prueba. CAMBIOS: 2026-07-02 → +"en producción" y "pasos accionables": el usuario quería instrucciones, no teoría. -->
```

El prompt evolucionó, el error quedó documentado y no se repite. Eso es Evoprompting.

### Caso 2: en código

El mismo formato funciona en cualquier lenguaje — aquí, lógica escrita por IA en Python:

```python
def filter_scams(listings):
    """Remove known phishing/scam patterns."""
    # EVO · FILTRO: bloquea URLs sospechosas y palabras clave de scam en título. POR QUÉ: redacción "garantía 100%" y URLs acortadas son marca de estafa; descartar evita reportes falsos. FUENTE: propio. EFECTIVIDAD: probada — descartó 8 scams en testing. CAMBIOS: 2026-06-27 → añadido "garantía" tras falso positivo; 2026-06-28 → mejorada regex de URLs.
    return [x for x in listings if not any(bad in x for bad in SCAM_PATTERNS)]
```

Más ejemplos (Markdown, YAML, JSX, SQL, JSON, evaluación de tareas) en [`example.md`](example.md).

## FAQ

**P: ¿Los comentarios EVO son invisibles a la IA?**
R: No, y esa es la idea. El modelo lee los comentarios — son su memoria de mantenimiento, para que entienda por qué el prompt está escrito así y dónde está parado.

**P: ¿Tenía otro nombre antes?**
R: Sí — la v1 se llamó VIBE. Los comentarios `VIBE · ...` en proyectos existentes son el mismo formato con el tag viejo: se leen igual y se migran a `EVO` al editarlos, sin borrar su historial.

**P: ¿Puedo usarlo con otras herramientas (OpenAI API, Cursor, LangChain, etc.)?**
R: Sí. La metodología es agnóstica — solo adapta la sintaxis de comentario al lenguaje.

**P: ¿Y si mi prompt es una sola línea?**
R: Una línea todavía es un bloque. Comenta debajo. Si es *muy* chica, quizá un archivo compañero `.evo.md` sea más limpio.

## Licencia

MIT — úsalo, cópialo, remixalo como quieras.

## Créditos

Idea original: Francisco (2026-06-25), nacida de la práctica de dejar comentarios en el código para que la IA sepa qué es cada cosa, para qué sirve y dónde está parada — aplicada a los prompts mismos.
