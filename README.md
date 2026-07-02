# VIBE Promting

> Una metodología portátil para comentar, depurar y mantener prompts de IA como código.

VIBE promting trata los prompts y instrucciones de IA como código comentado y refactorizable: cada bloque de instrucción lleva un comentario que explica **qué hace**, **por qué se eligió así**, **de dónde salió**, **qué tan bien funciona** y **su historial de cambios**. Cuando un resultado no gusta, ubicas el bloque culpable por su comentario, lo editas y anotas el cambio—sin perder memoria de por qué estaba así.

## ¿Por qué VIBE?

- **Mantenimiento a largo plazo:** los prompts se degradan o se olvida por qué se escribieron así. Los comentarios VIBE preservan la intención de diseño.
- **Depuración quirúrgica:** cuando algo falla, editas solo el bloque culpable, no rescribes todo el prompt.
- **Trazabilidad:** cada cambio queda fechado y razonado. Evita regresiones (volver a cometer un error ya corregido).
- **Reutilizable:** el formato es agnóstico del lenguaje—funciona en Markdown, Python, YAML, JavaScript, SQL, cualquier cosa.

## Instalación

### En Claude Code

Copia la carpeta `vibe/` a tu directorio de skills:

```bash
# macOS/Linux
cp -r vibe/ ~/.claude/skills/

# Windows PowerShell
Copy-Item -Recurse vibe/ $env:USERPROFILE\.claude\skills\
```

Luego invoca con `/vibe` en tu sesión.

### En otro proyecto

Si no usas Claude Code, copia solo el archivo `SKILL.md` como referencia y usa la sintaxis de comentarios que se describe en la sección **Sintaxis por archivo** de este README.

## Uso rápido

### 1. Anotar un bloque (automático en proyectos que adoptaron VIBE)

Al crear o editar un prompt o instrucción, agrega justo debajo:

```markdown
<!-- VIBE · ETIQUETA: qué hace · POR QUÉ: razón · FUENTE: propio · EFECTIVIDAD: sin medir · CAMBIOS: ninguno -->
```

### 2. Auditar un archivo

```bash
/vibe auditar <archivo o skill>
```

Reporta bloques sin VIBE, campos faltantes o historial mal fechado.

### 3. Arreglar un archivo

```bash
/vibe arreglar <archivo>
```

Completa y normaliza comentarios VIBE. Muestra el diff y pide confirmación antes de escribir.

## Formato del comentario

Justo **debajo** del bloque, con 5 campos:

```
VIBE · <ETIQUETA>: <qué hace> · POR QUÉ: <razón / resultado esperado> · FUENTE: <origen> · EFECTIVIDAD: <medida concreta o "sin medir"> · CAMBIOS: <líneas AAAA-MM-DD → cambio y razón>
```

**Campos:**

| Campo | Ejemplo | Notas |
|-------|---------|-------|
| **ETIQUETA** | IDENTIDAD, FILTRO, ROUTER, SALIDA | 1–2 palabras que nombren el rol |
| **POR QUÉ** | "evitar scams en la búsqueda" | la razón de diseño; qué se perdería si se quita |
| **FUENTE** | "propio", "chamba/buscar.md", "internet" | trazabilidad |
| **EFECTIVIDAD** | "sin medir", "probada: descartó scams" | inicia en `sin medir`; se actualiza con evidencia |
| **CAMBIOS** | "ninguno" o "2026-06-27 → fix Rockwell" | cada edición agrega una línea fechada; historial nunca se borra |

## Sintaxis de comentario por archivo

Elige la sintaxis del lenguaje para que el comentario no rompa ni se ejecute:

| Tipo | Sintaxis |
|------|----------|
| Markdown, HTML, XML, SVG | `<!-- VIBE · ... -->` |
| YAML, TOML, shell, Python, Ruby | `# VIBE · ...` |
| JS, TS, CSS, Java, Go, Rust | `// VIBE · ...` o `/* VIBE · ... */` |
| JSX / TSX | lógica → `// ...`; dentro del `return` → `{/* VIBE · ... */}` |
| SQL | `-- VIBE · ...` |
| JSON estricto | archivo compañero `<archivo>.vibe.md` |
| Archivos sin comentarios seguros | archivo compañero `<archivo>.vibe.md` |

**Archivo compañero:** para archivos que no soportan comentarios (JSON, `.env`), crea `<archivo>.vibe.md`:

```markdown
### ETIQUETA — sección o ruta

VIBE · ETIQUETA: qué hace · POR QUÉ: razón · ...
```

## Cuándo sí y cuándo no

✅ **SÍ** — instrucciones internas para IA (SKILL.md, system prompts, reglas de CLAUDE.md, prompts de agentes).

❌ **NO** — entregables que ve el cliente (landing HTML, README publicado, UI, correos). Si es un archivo que publicas o entregas, **no lleva VIBE**, aunque su lenguaje lo permita.

*Criterio:* ¿Es un entregable final? → No VIBE. ¿Es instrucción interna de IA? → Sí VIBE.

## Adoptar VIBE en un proyecto nuevo

Agrega a tu `CLAUDE.md` o `SKILL.md`:

```markdown
**VIBE activo en este proyecto.** En todo prompt/instrucción interna que la IA lee (no en entregables que ve el cliente), agrega debajo de cada bloque:

`VIBE · ETIQUETA: qué hace · POR QUÉ: razón / resultado · FUENTE: de dónde salió · EFECTIVIDAD: sin medir · CAMBIOS: AAAA-MM-DD → qué cambió`

Al editar un bloque, agrega una línea fechada a `CAMBIOS` y nunca borres el historial. Detalle: skill `vibe`.
```

Eso activa el automatismo **solo en ese proyecto**, sin sobre-activar en los demás.

## Ejemplo real

```python
# Sistema de filtro para descartar scams
def filter_scams(listings):
    """Remove known phishing/scam patterns."""
    # VIBE · FILTRO: bloquea URLs sospechosas y palabras clave de scam en título. POR QUÉ: redacción "garantía 100%" y URLs acortadas son marca de estafa; descartar evita reportes falsos. FUENTE: chamba/buscar.md. EFECTIVIDAD: probada — descartó 8 scams en testing. CAMBIOS: 2026-06-27 → añadido "garantía" tras falso positivo; 2026-06-28 → mejorada regex de URLs.
    return [x for x in listings if not any(bad in x for bad in SCAM_PATTERNS)]
```

## Loop de mantenimiento

1. **Ubica** el bloque culpable leyendo los comentarios VIBE.
2. **Edita** solo ese bloque (no reescribas todo).
3. **Anota** en su `CAMBIOS` qué cambiaste y por qué (fecha + razón).

Así, los prompts se depuran por partes—como se comenta y refactoriza código.

## Relación con poweredchamba

Esta skill `vibe` es la **fuente de verdad** del formato. Si trabajas con `chamba` o `poweredchamba`, ya está vibe-promteado y declara VIBE como obligatorio. Trátalas como proyectos adoptados.

## FAQ

**P: ¿Los comentarios VIBE son invisibles a la IA?**  
R: No. El modelo lee los comentarios (es su memoria de mantenimiento). Eso está bien—**para** que la IA entienda por qué el prompt está escrito así.

**P: ¿Cuándo uso `/vibe` vs. solo comentar a mano?**  
R: En proyectos que adoptaron VIBE (lo dice su CLAUDE.md), los comentarios son **automáticos**—no hace falta invocar `/vibe`. Invoca `/vibe` para auditar (`/vibe auditar`), arreglar en lote (`/vibe arreglar`), o en proyectos que no la adoptaron.

**P: ¿Puedo usarlo en prompts de otras herramientas (OpenAI API, LangChain, etc.)?**  
R: Sí. VIBE es agnóstico—la metodología y el formato funcionan en cualquier lugar donde escribas prompts. Solo adaptá la sintaxis de comentario al lenguaje.

**P: ¿Y si mi prompt es una sola línea?**  
R: Una línea todavía es un bloque. Comenta debajo. Si es *muy* chica, quizá un archivo compañero `.vibe.md` sea más limpio.

## Licencia

MIT — úsalo, cópialo, remixalo como quieras.

## Créditos

Idea original: Francisco (2026-06-25), basada en la práctica de comentar y refactorizar código.
