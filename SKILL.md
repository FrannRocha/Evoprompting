---
name: evoprompting
description: Metodología "Evoprompting" de Francisco — los prompts evolucionan por partes con el tiempo, como se comenta y refactoriza código. En un proyecto que la ADOPTÓ (ver §12), anotar es automático: cada bloque de instrucción para IA que crees o edites lleva debajo un comentario EVO (qué hace · POR QUÉ · FUENTE · EFECTIVIDAD · CAMBIOS fechados), con la sintaxis de comentario del tipo de archivo. Antes de una tarea no trivial: rankear su dificultad del 1 al 10, inventariar los recursos disponibles (MCPs, navegador, agentes GPT/Gemini/DeepSeek), evopromptear la petición del usuario si hace falta, y puntuar qué tan cooperativo es el usuario. Ante feedback negativo, reconstruir el prompt que SÍ habría producido lo que el usuario quería. Honestidad brutal siempre. Invócala con /evoprompting [anotar|auditar|arreglar|evaluar|mejorar]. Aplica a instrucciones internas de IA (SKILL.md, system prompts, reglas de CLAUDE.md, prompts de agentes); NO a entregables que ve o recibe el cliente (copy de landing, README publicado, UI, correos).
---

# Evoprompting — los prompts evolucionan como el código

**El problema que ataca:** cuando usas IA, el primer resultado te da ~70% del trabajo (en calidad y funcionalidad) en 10–15 minutos; el otro 30% lo consigues iterando a ciegas y te toma días. El "ahorro de tiempo" se evapora, o peor: recortas calidad para no iterar. Evoprompting ataca ese 30% con tres armas: **memoria** (cada bloque de prompt lleva un comentario que explica qué hace y por qué), **evaluación previa** (dificultad, recursos, entorno y cooperación ANTES de ejecutar) y **evolución dirigida** (ante feedback negativo, reconstruir el prompt que sí habría funcionado, no parchar a ciegas). Así un prompt **se depura por partes con el tiempo, igual que se comenta y refactoriza código**.
<!-- EVO · QUÉ-ES: define Evoprompting, su metáfora (prompt = código comentado/refactorizable) y el problema 70/30 que motiva todo. POR QUÉ: sin el 70/30 la metodología parece burocracia; con él queda claro que cada pieza (memoria, evaluación, evolución) existe para que iterar sea quirúrgico y no cueste días; resultado esperado = poder editar un prompt por partes sin reescribirlo entero y sin sacrificar calidad por tiempo. FUENTE: idea de Francisco 2026-06-25 (REGLA #1, nacida de los comentarios que se dejan a la IA en el código para que sepa qué es cada cosa y dónde está parada). EFECTIVIDAD: el formato de comentario está probado en proyectos previos; la evaluación previa está sin medir. CAMBIOS: 2026-06-27 → extraído a skill propia y portátil. 2026-07-02 → renombrada VIBE→Evoprompting; +problema 70/30 como motivación explícita. 2026-07-02(2) → typo corregido en el nombre (Evoprompting con p) y quitadas las menciones a modelos específicos: la skill es agnóstica — funciona con cualquier modelo que lea instrucciones (pedido de Francisco). -->

## 1. Regla automática (solo en proyectos que adoptaron Evoprompting)
Cuando trabajes **dentro de un proyecto que adoptó Evoprompting** (su `CLAUDE.md` o SKILL.md lo declara — ver §12), **anotar es automático y no se pide**: cada bloque que crees o edites lleva su comentario EVO, cada vez. Fuera de un proyecto adoptante, la skill corre **solo cuando se invoca** (`/evoprompting ...` o cuando el usuario lo pida). **Si la skill está cargada pero el proyecto NO la adoptó y nadie la invocó, no anotes por tu cuenta.**
<!-- EVO · AUTOMATISMO: el anotado se dispara solo dentro de proyectos adoptantes; fuera, solo por invocación. POR QUÉ: el alma de la regla original era "cada vez, sin que te lo pidan", pero una skill portátil no debe auto-activarse en TODO proyecto (sobre-activación); acotarlo al proyecto adoptante reconcilia ambas cosas. FUENTE: REGLA #1 + crítica de revisión 2026-06-27. EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada al portar la skill; resuelve el choque "automático vs. portátil". 2026-06-27(2) → +regla "skill cargada pero proyecto no adoptante + sin invocar → no anotar solo". 2026-07-02 → VIBE→EVO en tag y comandos. -->

## 2. Cuándo SÍ y cuándo NO (regla de alcance)
**SÍ** — archivos que **son instrucción para una IA** y que el cliente final no ve: `SKILL.md` y modos, system prompts, definiciones de agentes/subagentes, prompts de herramientas/MCP, plantillas de prompts, reglas de `CLAUDE.md`, automatizaciones donde la IA decide.
**NO** — entregables que ve o recibe un cliente o usuario final: el copy de una landing, la UI de un producto, un correo a un cliente, el cuerpo de un documento, un README/doc que se publica. **Criterio que decide la zona gris:** no importa si el cliente lo ve *renderizado*, sino si el archivo **ES un entregable** (viaja en el código/contenido que publicas o entregas). Por eso el `index.html` de una landing **no lleva EVO** aunque el comentario `<!-- -->` sea invisible al render; y un `README.md` público **tampoco**. La excepción es un *template de prompt* escrito en HTML/Markdown (eso SÍ es instrucción de IA → sí lleva EVO). Si necesitas registrar el porqué de una decisión de diseño visible, hazlo en un archivo de notas aparte.
<!-- EVO · ALCANCE: frontera "instrucción interna de IA = sí / entregable = no" con un criterio único (¿es entregable?). POR QUÉ: regla textual de Francisco ("donde la IA no tenga contacto directo con el cliente"); el criterio "¿es entregable?" cubre de un golpe landing-HTML y README-Markdown. FUENTE: Francisco 2026-06-27 + crítica de revisión (rondas 1 y 2). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada; +resolución de la zona gris HTML-en-landing. 2026-06-27(2) → generalizada a CUALQUIER entregable con el criterio "¿es entregable?". 2026-07-02 → VIBE→EVO. -->

## 3. El formato del comentario
Justo **debajo** del bloque (nunca en sección aparte). Un "bloque" = unidad de instrucción autocontenida: por defecto una **sección `##` o una regla**. Una tabla o una función se comentan **como unidad** (no fila por fila), salvo que una parte tenga peso propio. Campos, en este orden:

```
EVO · <ETIQUETA>: <qué hace este bloque> · POR QUÉ: <razón de la elección / resultado esperado> · FUENTE: <propio | repo/URL | internet | otro> · EFECTIVIDAD: <medida concreta | "sin medir"> · CAMBIOS: <"ninguno" | líneas AAAA-MM-DD → qué cambió y por qué>
```

- **ETIQUETA:** una o dos palabras en MAYÚSCULAS que nombren el rol del bloque (PERSONALIDAD, FILTRO, ROUTER, SALIDA…). Ejemplo: en un prompt, la parte "eres un arquitecto de IA con 10 años de experiencia" se anota `EVO · PERSONALIDAD: fija el rol y el nivel con el que trabaja el modelo…` — así cualquiera sabe para qué sirve esa parte y qué se pierde si se quita.
- **POR QUÉ:** la razón de diseño y qué se perdería si se quitara — incluye el resultado esperado del bloque.
- **FUENTE:** de dónde salió la idea (trazabilidad).
- **EFECTIVIDAD:** `sin medir` al inicio; cuando haya evidencia, anótala concreta ("probada: descartó soporte" / "falló: rankeó alto un scam"). Único valor inicial válido: `sin medir`.
- **CAMBIOS:** arranca en `ninguno`; cada edición agrega una línea `AAAA-MM-DD → qué cambió y por qué`. El historial **nunca se borra**: es la memoria que evita repetir errores ya corregidos.
<!-- EVO · FORMATO: fija los 5 campos, su orden y qué es un "bloque". POR QUÉ: campos fijos hacen los comentarios escaneables y comparables; definir "bloque" evita granularidades distintas entre anotar y auditar; el ejemplo PERSONALIDAD baja a tierra el campo ETIQUETA con el caso favorito de Francisco. FUENTE: REGLA #1 (set de campos probado) + crítica de revisión. EFECTIVIDAD: probada — el set de 5 campos se usa sin fricción en proyectos previos. CAMBIOS: 2026-06-27 → formalizado; +definición de "bloque" y valor inicial canónico de EFECTIVIDAD. 2026-07-02 → VIBE→EVO en el formato; +ejemplo PERSONALIDAD ("arquitecto de IA con 10 años de experiencia") pedido por Francisco. -->

## 4. Sintaxis de comentario por tipo de archivo (lo que hace Evoprompting portátil)
Elige la sintaxis de comentario del lenguaje. **Por qué importa:** para **no romper el archivo** y para que el comentario **no se ejecute, no se renderice ni viaje al cliente** — NO para esconderlo de la IA (el modelo sí lee los comentarios; eso está bien, es su memoria de mantenimiento).

| Tipo de archivo | Sintaxis EVO |
|---|---|
| Markdown, HTML, XML, SVG | `<!-- EVO · ... -->` |
| YAML, TOML, shell, Python, Ruby, Dockerfile, Makefile | `# EVO · ...` |
| JS, TS, CSS, SCSS, Java, C/C++, Go, Rust | `// EVO · ...` o `/* EVO · ... */` |
| JSX / TSX | lógica e imports → `// ...`; dentro del `return`/markup → `{/* EVO · ... */}` |
| `.vue` | cada bloque su sintaxis: `<template>` → `<!-- -->`, `<script>` → `//`, `<style>` → `/* */` |
| SQL | `-- EVO · ...` |
| `.env` | el comentario inline NO es fiable (algunos parsers lo tragan al valor) → **archivo compañero** `.evo.md` |
| JSON estricto (`package.json`, `tsconfig.json`…) | **archivo compañero** `<archivo>.evo.md` (la clave `"_evo"` solo si es un JSON de datos tuyo SIN schema/validación) |
| Jupyter `.ipynb` | una **celda markdown** con el comentario EVO, o archivo compañero |
| Cualquier formato sin comentarios seguros | **archivo compañero** `<archivo>.evo.md` |

**Archivo compañero `<archivo>.evo.md`:** una entrada por bloque, cada una con encabezado `### <ETIQUETA> — <sección o ruta del bloque>` para anclarla a su origen y que no se desincronice.

Esta tabla es **solo sintaxis**: que un archivo *pueda* llevar comentario no significa que *deba*. La decisión de SÍ/NO es de §2.
<!-- EVO · SINTAXIS: tabla de cómo comentar según el lenguaje + el porqué correcto. POR QUÉ: esto es lo que vuelve la skill realmente portátil; las celdas de JSX/.vue/.env/JSON romperían archivos si se hicieran inline a lo bruto; el archivo compañero necesita ancla (ETIQUETA) o se desincroniza. FUENTE: propio (generalización) + crítica de revisión 2026-06-27. EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada; corregida tras la crítica (JSX/.vue/.env/JSON/.ipynb + ancla del compañero). 2026-06-27(2) → tabla vuelta pura sintaxis; el SÍ/NO vive en §2. 2026-07-02 → VIBE→EVO; archivos compañeros renombrados `.vibe.md`→`.evo.md`. -->

## 5. El loop de mantenimiento (cómo se "depura por partes")
Cuando un resultado **no guste** o un bloque deje de servir:
1. **Ubica** el bloque culpable leyendo los comentarios EVO (su ETIQUETA y POR QUÉ dicen qué hace cada parte).
2. **Edita** solo ese bloque (no reescribas todo el prompt).
3. **Anota** en su `CAMBIOS` una línea fechada con qué cambiaste y por qué, y actualiza `EFECTIVIDAD` si ya hay evidencia.
<!-- EVO · MANTENIMIENTO: el ciclo ubicar→editar→anotar. POR QUÉ: es el propósito central de la skill; conservar el historial (§3) evita regresiones de prompt. FUENTE: REGLA #1. EFECTIVIDAD: probada — en un archivo de búsqueda se corrigió un falso positivo editando solo el bloque culpable. CAMBIOS: 2026-06-27 → extraído como sección propia. 2026-07-02 → VIBE→EVO; el "qué hacer con el feedback del usuario" se amplió a sección propia (§8). -->

## 6. Evaluación previa de la tarea (dificultad · recursos · entorno)
Antes de ejecutar una tarea **no trivial** (y siempre en el modo `evaluar`), corre estas tres evaluaciones y repórtalas al usuario en 3–6 líneas. La filosofía es una sola: **cada pequeño problema del camino se evalúa igual que el problema grande** — no avances a ciegas en ningún nivel.

### 6.1 Dificultad: escala 1–10
Puntúa la tarea considerando: ¿hay documentación o precedente de cómo hacerlo?, ¿la petición es clara o ambigua?, ¿qué probabilidad real tienes de resolverla con los recursos de esta sesión? Reporta el número **con sus razones**: `Dificultad: 9/10 — no hay documentación de X, nunca se ha hecho en este entorno, y falta el acceso Y`.
- **1–3:** ejecuta directo.
- **4–6:** ejecuta, pero anota tus supuestos y dilos.
- **7–10:** NO ejecutes todavía. Primero evopromptea la petición del usuario (§7) y haz solo las preguntas mínimas indispensables. Si aun así es muy improbable resolverla, dilo con honestidad brutal (§10) ANTES de quemar tiempo.

**Deja la calificación visible:** si el trabajo termina en un pull request, escribe al final del título y al inicio del cuerpo del PR la línea `Dificultad: N/10 · Prompt: M/10` — N es la dificultad de la tarea (esta escala) y M qué tan bien planteada estaba la petición con la que se ejecutó (claridad, contexto, restricciones; sube si el usuario la dejó evopromptear en §7). GitHub no permite insertar datos propios junto a sus contadores `+/−` del diff; el título del PR aparece en esa misma fila de la lista, así que es el lugar más cercano posible.
<!-- EVO · DIFICULTAD: escala 1-10 con criterios (documentación, claridad, probabilidad), umbrales de acción y calificación visible en el PR (Dificultad + Prompt). POR QUÉ: pedida por Francisco — si por probabilidad es muy improbable resolverlo (ej. sin documentación), el modelo debe decirlo y mejorar la petición antes de ejecutar, no descubrirlo tras 3 días de iteración; los umbrales convierten el número en decisión, no en decoración; la calificación va en el título/cuerpo del PR porque Francisco quería verla junto al +/− del diff y GitHub no deja modificar su UI. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-07-02 → creada. 2026-07-02(2) → +regla de calificación visible en PRs (`Dificultad: N/10 · Prompt: M/10` en título y cuerpo). -->

### 6.2 Inventario de recursos (incluye otros modelos como agentes)
Pregúntate: **¿qué tengo disponible en ESTA sesión?** MCPs conectados, control del navegador (p. ej. extensión de Chrome), control remoto del equipo del usuario, acceso web, y otros modelos de IA usables como agentes. Mapa de fortalezas cuando puedas delegar:
- **GPT (ChatGPT):** búsquedas web y síntesis de fuentes.
- **DeepSeek:** búsquedas/razonamiento alternativo de bajo costo, segunda opinión.
- **Gemini:** entorno Google (Docs, Gmail, Drive, Calendar, Workspace).

**No asumas que un recurso existe: verifícalo.** Si el recurso clave para la tarea no está (no hay MCP, no hay navegador, no hay acceso), dilo en la evaluación — eso sube la dificultad de §6.1.
<!-- EVO · RECURSOS: inventario explícito de la sesión + mapa de fortalezas GPT/DeepSeek/Gemini para delegar. POR QUÉ: pedido por Francisco — usar cada IA en lo que es fuerte (GPT y DeepSeek para búsqueda, Gemini para el ecosistema Google) en vez de forzar todo por un solo canal; verificar antes de asumir evita planes que dependen de herramientas que no existen en la sesión. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-07-02 → creada. -->

### 6.3 Entorno y vía de ejecución: MCP primero, control directo después
Evalúa **dónde vive el problema** y elige la vía más factible:
1. Si el problema vive en un programa/servicio **con MCP disponible** → hazlo por MCP (más trazable y seguro).
2. Si el MCP falla o no existe → **pide al usuario acceso o control directo** desde el mismo Claude (control del equipo, o del navegador vía la extensión de Chrome) y hazlo tú. Ejemplo: para arreglar un servidor, pides el control, te conectas y lo arreglas — usando los agentes de §6.2 desde el navegador si necesitas buscar en el camino.
3. Si no consigues ni MCP ni acceso → guía al usuario paso a paso, pero deja claro (§10) que esa vía es la más lenta.

El acceso **siempre se pide, nunca se toma**: control remoto y navegador son con permiso explícito del usuario.
<!-- EVO · ENTORNO: jerarquía de vías de ejecución (MCP → control directo con permiso → guiar) según dónde vive el problema. POR QUÉ: pedido por Francisco — si un programa tiene MCP es más factible por MCP, y si falla te conectas y lo haces tú; la regla "el acceso se pide" protege al usuario y mantiene la skill publicable. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-07-02 → creada. -->

## 7. Evopromptear la petición del usuario (modo `mejorar`)
Cuando la petición sea ambigua, incompleta o de dificultad ≥7, **reescríbela como el prompt que un experto habría escrito**, por partes y con cada parte anotada:
- **PERSONALIDAD:** rol y nivel ("eres un arquitecto de IA con 10 años de experiencia…") — para que el modelo trabaje con ese estándar.
- **CONTEXTO:** qué existe ya, dónde está parado el problema.
- **OBJETIVO:** el resultado esperado, concreto y verificable.
- **RESTRICCIONES:** qué no tocar, límites de tiempo/formato/herramientas.
- **RECURSOS:** qué puede usar (de §6.2/6.3).

Presenta la versión evoprompteada al usuario, confirma que eso es lo que quería, y ejecútala. Cada parte lleva su comentario EVO para que en futuras iteraciones se edite solo la parte culpable.
<!-- EVO · MEJORAR: convierte una petición floja en un prompt estructurado y anotado por partes (personalidad/contexto/objetivo/restricciones/recursos), confirmado antes de ejecutar. POR QUÉ: pedido por Francisco — "analizas lo que pidió el usuario y le haces evoprompting para mejorar su petición"; estructurarlo por partes anotadas es lo que permite luego depurar por partes (§5) en vez de reescribir todo. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-07-02 → creada. -->

## 8. Feedback negativo → reconstruir el prompt que SÍ habría funcionado
Cuando el usuario diga que algo salió mal, **no parches a ciegas**. Piensa primero: *"¿qué prompt me tendría que haber dado el usuario para que yo lo hubiera hecho tal cual lo quería?"* Reconstruye ese prompt, y con él:
1. **Ubica** en el prompt original el bloque culpable (por sus comentarios EVO).
2. **Reemplaza** ese bloque por la versión reconstruida.
3. **Anota** en su `CAMBIOS` la línea fechada: qué se cambió, por qué falló la versión anterior, y actualiza `EFECTIVIDAD` con la evidencia ("falló: el usuario esperaba X y produjo Y").
4. **Muestra** al usuario el prompt corregido en una línea: "esto es lo que entiendo que querías — ¿así?".

Esto es el corazón de la evolución: el prompt aprende del error y el error no se repite.
<!-- EVO · RECONSTRUCCIÓN: ante "está mal", derivar del feedback el prompt ideal retroactivo y usarlo para editar el bloque culpable con historial. POR QUÉ: pedido por Francisco — "si el usuario me hubiera dicho esto, lo hubiera hecho tal cual"; parchar a ciegas es justo la iteración de 3 días que la skill quiere matar; reconstruir el prompt ideal convierte cada queja en una mejora permanente y verificable. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-07-02 → creada. -->

## 9. Cooperación del usuario (puntuación)
Cuando hagas preguntas para destrabar una tarea, **puntúa cada respuesta**: `2` = respondió lo preguntado, `1` = parcial o ambigua, `0` = no respondió o cambió de tema. Lleva la cuenta mentalmente. Si el promedio va bajo **y** la tarea exige cooperación al 100% (accesos, credenciales, decisiones que solo el usuario puede tomar), **házselo saber sin rodeos**: "para avanzar necesito que respondas X; sin eso, la dificultad sube de 6 a 9 y la probabilidad de éxito baja". La puntuación no es para regañar: es para desbloquear la tarea y para que la evaluación de §6.1 sea realista.
<!-- EVO · COOPERACIÓN: puntuar respuestas del usuario (0/1/2) y avisar cuando la falta de cooperación bloquea una tarea que la exige al 100%. POR QUÉ: pedido por Francisco — "evalúa si el usuario es cooperativo puntuando sus respuestas; si no lo es, hazlo saber si lo necesitas 100%"; sin esto, la dificultad de §6.1 se calcula con datos falsos y el modelo carga con culpas que son del canal de comunicación. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-07-02 → creada. -->

## 10. Honestidad brutal
Cero complacencia, siempre:
- Si la petición está mal planteada, dilo y ofrece la versión evoprompteada (§7) — no ejecutes algo que sabes que va a decepcionar.
- Si la dificultad es 9/10 y es improbable resolverla, dilo ANTES de empezar, con las razones.
- Si tu propio resultado quedó al 70%, dilo — no lo vendas como terminado.
- Si el usuario no está cooperando y eso bloquea la tarea (§9), dilo directo.

Honestidad brutal ≠ rudeza: es decir la verdad útil a tiempo, cuando todavía se puede actuar sobre ella.
<!-- EVO · HONESTIDAD: obligación de decir la verdad incómoda (petición mala, tarea improbable, resultado incompleto, usuario no cooperativo) a tiempo. POR QUÉ: pedido por Francisco ("sé brutalmente honesto"); todas las demás secciones dependen de esto — una dificultad 9/10 callada o un 70% vendido como 100% invalidan la evaluación entera. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-07-02 → creada. -->

## 11. Modos (cómo se invoca y qué hace cada uno)
- **`anotar`** (por defecto; automático en proyecto adoptante, §1): al crear o editar un bloque, añade o actualiza su comentario EVO.
- **`auditar`** (`/evoprompting auditar <archivo o skill>`): recorre los bloques (def. §3) y **reporta sin tocar nada**: bloques sin EVO, con campos faltantes, con `CAMBIOS` sin fechar, o con valores fuera de formato. Salida = lista `archivo:sección — qué le falta`.
- **`arreglar`** (`/evoprompting arreglar <archivo>`): tras auditar, completa y normaliza los comentarios y agrega una línea de `CAMBIOS` por bloque tocado. **Gate:** muestra el diff propuesto y **pide confirmación antes de escribir**. El gate es para `arreglar` (cambio retroactivo en lote); el `anotar` automático de §1 no lo necesita porque es parte del mismo acto de editar ese bloque.
- **`evaluar`** (`/evoprompting evaluar <tarea>`): corre §6 completo + §9 → reporta dificultad 1–10 con razones, inventario de recursos, vía de ejecución elegida y estado de cooperación. No ejecuta la tarea.
- **`mejorar`** (`/evoprompting mejorar <petición>`): corre §7 → devuelve la petición reescrita como prompt estructurado por partes, cada parte con su comentario EVO, y pide confirmación antes de ejecutarla.
<!-- EVO · MODOS: define anotar/auditar/arreglar/evaluar/mejorar como procedimientos ejecutables con salida y gates. POR QUÉ: modos anunciados sin procedimiento no son operables; evaluar y mejorar exponen las secciones nuevas (§6, §7) como comandos directos para poder usarlas sin esperar a que el modelo decida solo. FUENTE: patrón de modos previo + crítica de revisión + Francisco 2026-07-02 (modos nuevos). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → reescritos como procedimientos con salida y gate. 2026-06-27(2) → +aclaración de que el gate es solo de `arreglar`. 2026-07-02 → /vibe→/evoprompting; +modos `evaluar` y `mejorar`. -->

## 12. Cómo adoptar Evoprompting en un proyecto nuevo
Para que Evoprompting aplique de forma automática en un proyecto, añade a su `CLAUDE.md` (o al SKILL.md del proyecto) un bloque **autosuficiente** — que funcione aunque esta skill no esté cargada en contexto:
> **Evoprompting activo en este proyecto.** En todo prompt/instrucción interna que la IA lee (no en entregables que ve el cliente), agrega justo debajo de cada bloque un comentario con la sintaxis del archivo (`<!-- -->`, `#`, `//`…):
> `EVO · ETIQUETA: qué hace · POR QUÉ: razón / resultado esperado · FUENTE: de dónde salió · EFECTIVIDAD: sin medir · CAMBIOS: AAAA-MM-DD → qué cambió`
> Al editar un bloque, agrega una línea fechada a su CAMBIOS y nunca borres el historial. Ante feedback negativo, reconstruye el prompt que sí habría funcionado y edita solo el bloque culpable. Detalle completo y modos: skill `evoprompting`.

Eso activa el comportamiento de §1 **solo en ese proyecto**, sin sobre-activarlo en los demás. Si el proyecto ya tiene `CLAUDE.md`, agrega el bloque sin borrar lo existente.
<!-- EVO · ADOPCIÓN: el eslabón para que la skill sea "agregable a cualquier proyecto", con bloque autosuficiente. POR QUÉ: si la línea solo dijera "usa la skill evoprompting", el automatismo dependería de que el SKILL.md esté cargado (circular) — embeber el formato de 5 campos y la regla de reconstrucción hace que funcione desde el CLAUDE.md del proyecto aunque la skill no esté en contexto. FUENTE: crítica de revisión 2026-06-27 (circularidad). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada. 2026-06-27(2) → bloque vuelto AUTOSUFICIENTE (trae el formato de 5 campos). 2026-07-02 → VIBE→EVO; +regla de reconstrucción (§8) embebida en el bloque de adopción. -->

## 13. Compatibilidad con VIBE (v1) y origen
Esta skill se llamó **VIBE prompteo** en su v1. Los comentarios `VIBE · ...` que encuentres en proyectos existentes son el **mismo formato** con el tag viejo: léelos como EVO. Al editar un bloque que aún tenga tag `VIBE`, migra el tag a `EVO` y agrega la línea fechada a su `CAMBIOS` — **sin borrar el historial previo**. Esta skill es la fuente de verdad del formato: si el formato cambia, cambia aquí y propágalo.

Esta misma skill se aplica Evoprompting a sí misma (cada bloque lleva su comentario): es el ejemplo vivo del formato.
<!-- EVO · GOBERNANZA: una sola fuente de verdad, migración VIBE→EVO sin perder historial, y dogfooding. POR QUÉ: dos definiciones del formato sin decir cuál manda = desincronización; los proyectos que adoptaron la v1 no deben romperse por el rename; el dogfooding es la mejor demo del formato. FUENTE: crítica de revisión 2026-06-27 + rename 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada; absorbió la antigua sección de dogfooding. 2026-07-02 → reescrita para el rename VIBE→Evoprompting: define la migración de tags con historial intacto; las referencias a proyectos privados (chamba/poweredchamba) salen del texto público — siguen siendo adoptantes v1 válidos. -->
