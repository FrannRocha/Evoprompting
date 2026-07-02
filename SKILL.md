---
name: vibe
description: Metodología "VIBE promteo" de Francisco — depurar prompts por partes con el tiempo, como se comenta y refactoriza código. En un proyecto que la ADOPTÓ (ver §6), anotar es automático: cada bloque de instrucción para IA que crees o edites lleva debajo un comentario VIBE (qué hace · POR QUÉ · FUENTE · EFECTIVIDAD · CAMBIOS fechados), con la sintaxis de comentario del tipo de archivo. Invócala explícitamente con /vibe [anotar|auditar|arreglar] para vibe-promtear, revisar o completar un archivo de instrucciones de IA (SKILL.md, system prompts, reglas de CLAUDE.md, prompts de agentes/herramientas; lista completa en §2). NO se aplica a entregables que ve o recibe el cliente (copy de landing, README publicado, UI, correos).
---

# VIBE promteo — metodología portátil para instrucciones de IA

A todo prompt/instrucción que lee una IA se le pega, justo debajo, un comentario que explica para qué sirve ese bloque, por qué se eligió así, de dónde salió, qué tan bien funciona y su historial de cambios. Así un prompt **se depura por partes con el tiempo, igual que se comenta y refactoriza código**: cuando un resultado no gusta, ubicas el bloque culpable, lo editas y anotas el cambio, sin perder memoria de por qué estaba así.
<!-- VIBE · QUÉ-ES: define VIBE y su metáfora (prompt = código comentado/refactorizable). POR QUÉ: la metáfora deja claro que el comentario es para mantenimiento futuro, no decoración; resultado esperado = poder editar un prompt por partes sin reescribirlo entero. FUENTE: idea de Francisco 2026-06-25 (REGLA #1 de poweredchamba). EFECTIVIDAD: probada en chamba/poweredchamba — todos los bloques se editan por su comentario (p. ej. fix de Rockwell/MBQ en buscar.md). CAMBIOS: 2026-06-27 → extraído de poweredchamba a skill propia y portátil. -->

## 1. Regla automática (solo en proyectos que adoptaron VIBE)
Cuando trabajes **dentro de un proyecto que adoptó VIBE** (su `CLAUDE.md` o SKILL.md lo declara — ver §6), **anotar es automático y no se pide**: cada bloque que crees o edites lleva su comentario VIBE, cada vez. Fuera de un proyecto adoptado, VIBE corre **solo cuando se invoca** (`/vibe ...` o cuando Francisco lo pida). **Si la skill está cargada pero el proyecto NO la adoptó y nadie invocó `/vibe`, no anotes por tu cuenta.** Esto preserva el carácter obligatorio del original sin sobre-activarse en cualquier sesión.
<!-- VIBE · AUTOMATISMO: restaura el "automático y obligatorio" del original, pero acotado al proyecto adoptante. POR QUÉ: el alma de la REGLA #1 era que VIBE se dispara solo "cada vez, sin que te lo pidan"; pero una skill portátil no debe auto-activarse en TODO proyecto (sobre-activación). Acotarlo a "proyecto adoptante" reconcilia ambas cosas. FUENTE: REGLA #1 de poweredchamba + crítica de revisión 2026-06-27 (riesgo de over-trigger + pérdida del automatismo). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada al portar VIBE; resuelve el choque "automático vs. portátil". 2026-06-27(2) → +regla explícita "skill cargada pero proyecto no adoptante + sin invocar → no anotar solo" (cierra el último resquicio de over-trigger; crítica ronda 2 N3). -->

## 2. Cuándo SÍ y cuándo NO (la regla de alcance de Francisco)
**SÍ** — archivos que **son instrucción para una IA** y que el cliente final no ve: `SKILL.md` y modos, system prompts, definiciones de agentes/subagentes, prompts de herramientas/MCP, plantillas de prompts, reglas de `CLAUDE.md`, automatizaciones donde la IA decide, comentarios de configuración de IA.
**NO** — entregables que ve o recibe un cliente o usuario final: el copy de una landing, la UI de un producto, un correo a un cliente, el cuerpo de un documento, un README/doc que se publica. **Criterio que decide la zona gris:** lo que importa no es si el cliente lo ve *renderizado*, sino si el archivo **ES un entregable** (viaja en el código/contenido que publicas o entregas). Por eso el `index.html` de una landing **no lleva VIBE** aunque el comentario `<!-- -->` sea invisible al render; y un `README.md` público **tampoco**, aunque comparta sintaxis con un `SKILL.md` que sí lo lleva. La excepción es un *template de prompt* escrito en HTML/Markdown (eso SÍ es instrucción de IA → sí lleva VIBE). Si necesitas registrar el porqué de una decisión de diseño visible, hazlo en un archivo de notas aparte, no incrustado en el entregable.
<!-- VIBE · ALCANCE: traza la frontera "instrucción interna de IA = sí / entregable que se publica = no" con un criterio único (¿es entregable?) que cubre HTML Y Markdown. POR QUÉ: regla textual de Francisco ("donde la IA no tenga contacto directo con el cliente"); poner el criterio en "¿es entregable?" (no "¿lo ve renderizado?") cubre de un golpe landing-HTML y README-Markdown, y deja la tabla §4 como pura sintaxis. FUENTE: Francisco 2026-06-27 + crítica de revisión (ronda 1: §1 contradecía la tabla; ronda 2 N1: Markdown publicado quedaba sin la salvedad). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada al volver VIBE portátil; +resolución de la zona gris HTML-en-landing. 2026-06-27(2) → generalizada a CUALQUIER entregable (incl. README/docs Markdown) con el criterio "¿es entregable?"; la tabla §4 deja de cargar el matiz (crítica ronda 2 N1 + comentario de la tabla). -->

## 3. El formato del comentario
Justo **debajo** del bloque (nunca en sección aparte). Un "bloque" = unidad de instrucción autocontenida: por defecto una **sección `##` o una regla**. Una tabla o una función se comentan **como unidad** (no fila por fila ni línea por línea), salvo que una parte tenga peso propio. Campos, en este orden:

```
VIBE · <ETIQUETA>: <qué hace este bloque> · POR QUÉ: <razón de la elección / resultado esperado> · FUENTE: <propio | repo/URL | internet | superpowers | otro> · EFECTIVIDAD: <medida concreta | "sin medir"> · CAMBIOS: <"ninguno" | líneas AAAA-MM-DD → qué cambió y por qué>
```

- **ETIQUETA:** una o dos palabras en MAYÚSCULAS que nombren el rol del bloque (IDENTIDAD, FILTRO, ROUTER, SALIDA…).
- **POR QUÉ:** la razón de diseño y qué se perdería si se quitara — incluye el resultado esperado del bloque.
- **FUENTE:** de dónde salió la idea (trazabilidad).
- **EFECTIVIDAD:** `sin medir` al inicio; cuando haya evidencia, anótala concreta ("probada: descartó soporte" / "falló: rankeó alto un scam"). Único valor inicial válido: `sin medir` (no "nueva", no "n/a").
- **CAMBIOS:** arranca en `ninguno`; cada edición agrega una línea `AAAA-MM-DD → qué cambió y por qué`. El historial **nunca se borra**: es la memoria que evita repetir errores ya corregidos.
<!-- VIBE · FORMATO: fija los 5 campos, su orden y qué es un "bloque". POR QUÉ: campos fijos hacen los comentarios escaneables y comparables; definir "bloque" evita que auditar/anotar trabajen a granularidades distintas; fijar el valor inicial de EFECTIVIDAD evita inconsistencias. FUENTE: REGLA #1 de poweredchamba (set de campos probado) + crítica (faltaba definir "bloque" y se coló "EFECTIVIDAD: nueva"). EFECTIVIDAD: probada — el set de 5 campos se usa sin fricción en chamba/poweredchamba. CAMBIOS: 2026-06-27 → formalizado al extraer la skill; +definición de "bloque" y valor inicial canónico de EFECTIVIDAD. -->

## 4. Sintaxis de comentario por tipo de archivo (lo que hace VIBE portátil)
Elige la sintaxis de comentario del lenguaje. **Por qué importa:** para **no romper el archivo** y para que el comentario **no se ejecute, no se renderice ni viaje al cliente** — NO para esconderlo de la IA (el modelo sí lee los comentarios; eso está bien, es su memoria de mantenimiento).

| Tipo de archivo | Sintaxis VIBE |
|---|---|
| Markdown, HTML, XML, SVG | `<!-- VIBE · ... -->` |
| YAML, TOML, shell, Python, Ruby, Dockerfile, Makefile | `# VIBE · ...` |
| JS, TS, CSS, SCSS, Java, C/C++, Go, Rust | `// VIBE · ...` o `/* VIBE · ... */` |
| JSX / TSX | lógica e imports → `// ...`; dentro del `return`/markup → `{/* VIBE · ... */}` |
| `.vue` | cada bloque su sintaxis: `<template>` → `<!-- -->`, `<script>` → `//`, `<style>` → `/* */` |
| SQL | `-- VIBE · ...` |
| `.env` | el comentario inline NO es fiable (algunos parsers lo tragan al valor) → **archivo compañero** `.vibe.md` |
| JSON estricto (`package.json`, `tsconfig.json`, `settings.json`…) | **archivo compañero** `<archivo>.vibe.md` (la clave `"_vibe"` solo si es un JSON de datos tuyo SIN schema/validación) |
| Jupyter `.ipynb` | una **celda markdown** con el comentario VIBE, o archivo compañero |
| Cualquier formato sin comentarios seguros | **archivo compañero** `<archivo>.vibe.md` |

**Archivo compañero `<archivo>.vibe.md`:** una entrada por bloque, cada una con encabezado `### <ETIQUETA> — <sección o ruta del bloque>` para anclarla a su origen y que no se desincronice.

Esta tabla es **solo sintaxis**: que un archivo *pueda* llevar comentario no significa que *deba*. La decisión de SÍ/NO es de §2 (si es entregable, no lleva VIBE aunque su lenguaje lo permita).
<!-- VIBE · SINTAXIS: tabla de cómo comentar según el lenguaje + el porqué correcto. POR QUÉ: esto es lo que vuelve VIBE realmente portátil; en poweredchamba solo existía `<!-- -->`. Las celdas de JSX/.vue/.env/JSON estaban mal y romperían archivos; el "archivo compañero" necesita ancla (ETIQUETA) o se desincroniza; la tabla debe ser pura sintaxis y delegar el SÍ/NO a §2. FUENTE: propio (generalización) + crítica de revisión 2026-06-27 (JSX=`{/* */}`, .vue=3 sintaxis, .env/JSON inline rompen, "los comentarios no son invisibles al LLM"; ronda 2: separar sintaxis de alcance). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada al portar fuera de markdown; corregida tras la crítica (JSX/.vue/.env/JSON/.ipynb + ancla del compañero + porqué real). 2026-06-27(2) → tabla vuelta pura sintaxis: fusioné Markdown+HTML, saqué el matiz "landing/entregable" de la celda HTML (vive en §2), y aclaré JSX/TSX (lógica → `//`, markup → `{/* */}`). -->

## 5. El loop de mantenimiento (cómo se "depura por partes")
Cuando un resultado **no guste** o un bloque deje de servir:
1. **Ubica** el bloque culpable leyendo los comentarios VIBE (su ETIQUETA y POR QUÉ dicen qué hace cada parte).
2. **Edita** solo ese bloque (no reescribas todo el prompt).
3. **Anota** en su `CAMBIOS` una línea fechada con qué cambiaste y por qué, y actualiza `EFECTIVIDAD` si ya hay evidencia.
<!-- VIBE · MANTENIMIENTO: el ciclo ubicar→editar→anotar. POR QUÉ: es el propósito central de VIBE; conservar el historial (ver §3) evita "regresiones" de prompt. FUENTE: REGLA #1 de poweredchamba. EFECTIVIDAD: probada — en buscar.md se corrigieron Rockwell/MBQ editando solo el bloque culpable. CAMBIOS: 2026-06-27 → extraído como sección propia. -->

## 6. Modos (cómo se invoca y qué hace cada uno)
- **`anotar`** (por defecto; automático en proyecto adoptado, §1): al crear o editar un bloque, añade o actualiza su comentario VIBE.
- **`auditar`** (`/vibe auditar <archivo o skill>`): recorre los bloques (def. §3) y **reporta sin tocar nada**: bloques sin VIBE, con campos faltantes, con `CAMBIOS` sin fechar, o con valores fuera de formato (p. ej. EFECTIVIDAD inventada). Salida = lista `archivo:sección — qué le falta`.
- **`arreglar`** (`/vibe arreglar <archivo>`): tras auditar, completa y normaliza los comentarios y agrega una línea de `CAMBIOS` por bloque tocado. **Gate:** muestra el diff propuesto y **pide confirmación antes de escribir** (editar un prompt no se hace a ciegas). El gate es para `arreglar` (cambio retroactivo en lote); el `anotar` automático de §1 no lo necesita porque es parte del mismo acto de editar ese bloque.
<!-- VIBE · MODOS: define anotar/auditar/arreglar como procedimientos ejecutables, no solo nombres. POR QUÉ: la versión anterior los anunciaba sin decir cómo correrlos; auditar necesita formato de salida y arreglar necesita gate de confirmación (escribir = modificar el prompt); aclarar que el gate NO aplica al anotar al-vuelo evita la lectura contradictoria con §1. FUENTE: patrón de modos de poweredchamba + crítica de revisión (modos no operables; ronda 2 N5: tensión gate vs. automático). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → reescritos como procedimientos con salida y gate, inline (la skill es ligera; no requiere carpeta modes\). 2026-06-27(2) → +aclaración de que el gate es solo de `arreglar` (lote), no del `anotar` automático (crítica ronda 2 N5). -->

## 7. Cómo adoptar VIBE en un proyecto nuevo
Para que VIBE aplique de forma automática en un proyecto, añade a su `CLAUDE.md` (o al SKILL.md del proyecto) un bloque **autosuficiente** — que funcione aunque esta skill no esté cargada en contexto:
> **VIBE activo en este proyecto.** En todo prompt/instrucción interna que la IA lee (no en entregables que ve el cliente), agrega justo debajo de cada bloque un comentario con la sintaxis del archivo (`<!-- -->`, `#`, `//`…):
> `VIBE · ETIQUETA: qué hace · POR QUÉ: razón / resultado esperado · FUENTE: de dónde salió · EFECTIVIDAD: sin medir · CAMBIOS: AAAA-MM-DD → qué cambió`
> Al editar un bloque, agrega una línea fechada a su CAMBIOS y nunca borres el historial. Detalle completo y modos: skill `vibe`.

Eso activa el comportamiento de §1 **solo en ese proyecto**, sin sobre-activarlo en los demás. Si el proyecto ya tiene `CLAUDE.md`, agrega el bloque sin borrar lo existente.
<!-- VIBE · ADOPCIÓN: el eslabón para que VIBE sea "agregable a cualquier proyecto", con bloque autosuficiente. POR QUÉ: sin mecanismo de adopción "portátil" era teoría; y si la línea solo dice "usa la skill vibe", el automatismo depende de que el SKILL.md esté cargado (circular) — embeber el formato de 5 campos hace que VIBE funcione desde el CLAUDE.md del proyecto aunque la skill no esté en contexto. FUENTE: crítica de revisión 2026-06-27 (ronda 1: faltaba adopción; ronda 2: circularidad §1/§7 → línea autosuficiente). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada para cumplir el objetivo central (VIBE en cualquier proyecto). 2026-06-27(2) → la línea de adopción ahora es un bloque AUTOSUFICIENTE (trae el formato de 5 campos) para no depender de que la skill esté cargada (crítica ronda 2: circularidad). -->

## 8. Relación con poweredchamba / chamba (fuente de verdad)
Esta skill `vibe` es la **fuente de verdad** del formato y las reglas de VIBE. Las skills `chamba` y `poweredchamba` ya están vibe-promteadas con este mismo estándar y su REGLA #1 lo declara obligatorio; trátalas como proyectos que ya adoptaron VIBE. Si cambias el formato, cámbialo **aquí** y propágalo.

Esta misma skill se aplica VIBE a sí misma (cada bloque lleva su comentario): es el ejemplo vivo del formato.
<!-- VIBE · GOBERNANZA: declara una sola fuente de verdad y reconcilia con poweredchamba; +nota de dogfooding en una línea. POR QUÉ: existían dos definiciones de VIBE (la REGLA #1 de poweredchamba y esta skill) sin decir cuál manda → riesgo de desincronización; el dogfooding se menciona una vez en vez de una sección de relleno propia. FUENTE: crítica de revisión 2026-06-27 (choque de gobernanza + §6 dogfooding era palabrería). EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → creada; absorbió la antigua sección de dogfooding (reducida a una línea). -->
