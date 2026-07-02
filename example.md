# Ejemplos de Evoprompting

Este archivo muestra cómo usar Evoprompting en diferentes contextos.

## Ejemplo 1: Instrucción en Markdown

```markdown
## Sección de búsqueda de empleo

Filtra ofertas que sean demasiado junior o con tech stack incompatible.

<!-- EVO · FILTRO: descarta ofertas donde la skill requerida < años de experiencia del usuario. POR QUÉ: evita postulaciones a posiciones por debajo del nivel, que generan rechazos automáticos. FUENTE: feedback de un reclutador (falso positivo previo). EFECTIVIDAD: probada — redujo rechazos en 3 ciclos. CAMBIOS: 2026-06-27 → añadido requisito de certificación; 2026-06-28 → relajado a diplomados (feedback). -->
```

## Ejemplo 2: La parte de personalidad de un prompt

```markdown
Eres un arquitecto de IA con 10 años de experiencia en sistemas de agentes.

<!-- EVO · PERSONALIDAD: fija el rol y el nivel con el que trabaja el modelo. POR QUÉ: sin esto las respuestas salen genéricas, de nivel principiante; con el rol, el modelo asume el estándar de un experto y justifica decisiones de arquitectura. FUENTE: propio. EFECTIVIDAD: probada — respuestas con trade-offs en vez de listas genéricas. CAMBIOS: ninguno. -->
```

## Ejemplo 3: Instrucción en Python

```python
def validate_email(email):
    """Check if email matches expected format."""
    # EVO · VALIDACIÓN: regex de email con RFC 5322 simplificado. POR QUÉ: prevenir inyecciones en forms; lenient pero con tope. FUENTE: propio (probado contra 10k direcciones públicas). EFECTIVIDAD: sin medir. CAMBIOS: ninguno.
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None
```

## Ejemplo 4: System prompt en YAML

```yaml
system:
  role: "job coach"
  # EVO · IDENTIDAD: responde como coach de carrera específico al usuario, no genérico. POR QUÉ: la personalización evita consejos boilerplate que no aplican a su perfil. FUENTE: feedback de sesión 2026-06-20. EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → añadida la región geográfica.

  directives:
    - "speak in Spanish (es-MX accent)"
    # EVO · IDIOMA: español mexicano. POR QUÉ: el usuario es nativo; reduce fricción mental. FUENTE: propio. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.
```

## Ejemplo 5: Archivo compañero para JSON

`package.json`:
```json
{
  "name": "evoprompting-example",
  "version": "1.0.0",
  "description": "Evoprompting skill"
}
```

`package.json.evo.md`:
```markdown
### VERSIÓN — version field

EVO · SEMVER: sigue semantic versioning (MAJOR.MINOR.PATCH). POR QUÉ: facilita picking de bugs críticos sin obligar a usuarios a saltar menores. FUENTE: standard npm. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.

### DESCRIPCIÓN — description field

EVO · LEGIBILIDAD: breve, clara, sin adjetivos. POR QUÉ: aparece en npm search; debe enganchar sin venderse. FUENTE: propio. EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → quitado "revolucionario".
```

## Ejemplo 6: JSX con EVO

```jsx
export function SkillCard({ skill, onSelect }) {
  // EVO · RENDERING: muestra tarjeta de skill con estado (favorita/descartada). POR QUÉ: UI táctil vs. lista de texto; aumenta engagement. FUENTE: feedback de UI/UX. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.

  return (
    <div className="skill-card">
      {/* EVO · FAVORITA: ícono toggle muestra si está en cartera. POR QUÉ: feedback visual de estado → menos clicks. FUENTE: Nielsen heuristics (visibilidad). EFECTIVIDAD: probada — 60% menos errores en selection. CAMBIOS: ninguno. */}
      <button onClick={() => onSelect(skill.id)}>
        ⭐ {skill.name}
      </button>
    </div>
  );
}
```

## Ejemplo 7: SQL con EVO

```sql
-- EVO · ÍNDICE: acelera búsquedas por skill_id. POR QUÉ: queries en cartera se hacen 100x/día; sin índice, son O(n). FUENTE: análisis de slow query log. EFECTIVIDAD: probada — query de 3.2s → 15ms. CAMBIOS: 2026-06-15 → creado.
CREATE INDEX idx_jobs_skill_id ON jobs(skill_id);
```

## Ejemplo 8: `/evoprompting evaluar` — evaluación previa de una tarea

Petición del usuario: *"arréglame el servidor de correo, está caído"*

Salida esperada del modo `evaluar`:

```
Dificultad: 8/10 — no sé qué servidor es, no hay logs a la vista, y no tengo acceso a la máquina.
Recursos en esta sesión: sin MCP del servidor; hay control de navegador; sin control remoto (habría que pedirlo).
Vía de ejecución: no hay MCP → pediré control remoto del equipo; si buscas del lado del error, delego la búsqueda web a GPT desde el navegador.
Cooperación: necesito 3 datos al 100%: (1) sistema operativo y software de correo, (2) desde cuándo falla, (3) acceso o control remoto. Sin el punto 3 la dificultad sube a 10.
```

## Ejemplo 9: `/evoprompting mejorar` — evopromptear una petición

Petición original: *"hazme un bot para mi negocio"*

Versión evoprompteada (cada parte anotada para poder depurarla por separado después):

```markdown
Eres un arquitecto de IA con 10 años de experiencia en chatbots de atención al cliente.
<!-- EVO · PERSONALIDAD: fija rol y nivel. POR QUÉ: sin esto el resultado sale genérico. FUENTE: skill evoprompting §7. EFECTIVIDAD: sin medir. CAMBIOS: ninguno. -->

Contexto: negocio de comida a domicilio en Monterrey; los clientes preguntan por WhatsApp horarios, menú y estado de su pedido.
<!-- EVO · CONTEXTO: dónde está parado el problema. POR QUÉ: sin contexto el bot resuelve el negocio equivocado. FUENTE: respuestas del usuario en evaluar. EFECTIVIDAD: sin medir. CAMBIOS: ninguno. -->

Objetivo: bot de WhatsApp que responda esas 3 preguntas y escale a humano todo lo demás.
<!-- EVO · OBJETIVO: resultado concreto y verificable. POR QUÉ: "un bot" no es medible; 3 preguntas + escalamiento sí. FUENTE: modo mejorar. EFECTIVIDAD: sin medir. CAMBIOS: ninguno. -->

Restricciones: presupuesto $0 en APIs de pago; el dueño no sabe programar (todo debe quedar documentado paso a paso).
<!-- EVO · RESTRICCIONES: límites que descartan soluciones. POR QUÉ: evita proponer stacks que el usuario no puede pagar ni mantener. FUENTE: respuestas del usuario. EFECTIVIDAD: sin medir. CAMBIOS: ninguno. -->
```

## Ejemplo 10: Feedback negativo → reconstrucción del prompt

El usuario dice: *"el bot responde muy formal, mis clientes son jóvenes"*.

**Mal (parche a ciegas):** agregar "sé más casual" en cualquier parte.

**Bien (Evoprompting §8):** reconstruir el prompt que sí habría funcionado — el bloque PERSONALIDAD debió decir "tono casual, norteño, con emojis" — y editar SOLO ese bloque:

```markdown
Eres un asistente de comida a domicilio con tono casual y cercano (es-MX norteño, emojis con moderación).
<!-- EVO · PERSONALIDAD: fija rol y TONO casual para público joven. POR QUÉ: el tono formal alejaba a los clientes. FUENTE: feedback del usuario 2026-07-02. EFECTIVIDAD: falló v1 (formal); v2 en prueba. CAMBIOS: ninguno → 2026-07-02 → de "arquitecto formal" a "casual norteño": el usuario reportó que sus clientes jóvenes no conectaban con el tono. -->
```

---

**Lección de estos ejemplos:** cada bloque lleva un comentario que explica su propósito y por qué se eligió, la tarea se evalúa ANTES de ejecutarse, y cada error del camino se convierte en una mejora fechada del prompt. Así los cambios futuros no se hacen a ciegas — y el 30% que antes tomaba días, toma minutos.
