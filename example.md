# Ejemplos de VIBE promting

Este archivo muestra cómo usar VIBE en diferentes contextos.

## Ejemplo 1: Instrucción en Markdown

```markdown
## Sección de búsqueda de empleo

Filtra ofertas que sean demasiado junior o con tech stack incompatible.

<!-- VIBE · FILTRO: descarta ofertas donde skill requerida < años de experiencia de Francisco. POR QUÉ: evita postulaciones a posiciones por debajo del nivel, que generan rechazos automáticos. FUENTE: feedback de Rockwell (falsa positiva con MBQ). EFECTIVIDAD: probada — redujo rechazos en 3 ciclos. CAMBIOS: 2026-06-27 → añadido "lic. en Seguridad" como requisito; 2026-06-28 → relajado a diplomados (feedback). -->
```

## Ejemplo 2: Instrucción en Python

```python
def validate_email(email):
    """Check if email matches expected format."""
    # VIBE · VALIDACIÓN: regex de email con RFC 5322 simplificado. POR QUÉ: prevenir inyecciones en forms; lenient pero con tope. FUENTE: propio (probado contra 10k direcciones públicas). EFECTIVIDAD: sin medir. CAMBIOS: ninguno.
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None
```

## Ejemplo 3: System prompt en YAML

```yaml
system:
  role: "job coach"
  # VIBE · IDENTIDAD: responde como coach de carrera sin ser genérico (específico a Francisco). POR QUÉ: personalización evita consejos boilerplate que no sirven para ciberseg + practicante. FUENTE: feedback de sesión 2026-06-20. EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → añadido "Monterrey" como región geográfica.

  directives:
    - "speak in Spanish (es-MX accent)"
    # VIBE · IDIOMA: español mexicano. POR QUÉ: Francisco es nativo; reduce fricción mental; aumenta confianza. FUENTE: propio. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.
```

## Ejemplo 4: Archivo compañero para JSON

`package.json`:
```json
{
  "name": "vibe-example",
  "version": "1.0.0",
  "description": "VIBE promting skill"
}
```

`package.json.vibe.md`:
```markdown
### VERSIÓN — version field

VIBE · SEMVER: sigue semantic versioning (MAJOR.MINOR.PATCH). POR QUÉ: facilita picking de bugs críticos sin obligar a usuarios a saltar menores. FUENTE: standard npm. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.

### DESCRIPCIÓN — description field

VIBE · LEGIBILIDAD: breve, clara, sin adjetivos. POR QUÉ: aparece en npm search; debe enganchar sin venderse. FUENTE: propio + crítica de npm best practices. EFECTIVIDAD: sin medir. CAMBIOS: 2026-06-27 → quitado "revolucionario".
```

## Ejemplo 5: JSX con VIBE

```jsx
export function SkillCard({ skill, onSelect }) {
  // VIBE · RENDERING: muestra tarjeta de skill con estado (favorita/descartada). POR QUÉ: UI táctil vs. lista de texto; aumenta engagement. FUENTE: feedback de UI/UX. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.

  return (
    <div className="skill-card">
      {/* VIBE · FAVORITA: ícono toggle muestra si está en cartera. POR QUÉ: feedback visual de estado → menos clicks. FUENTE: Nielsen heuristics (visibilidad). EFECTIVIDAD: probada — 60% menos errores en selection. */}
      <button onClick={() => onSelect(skill.id)}>
        ⭐ {skill.name}
      </button>
    </div>
  );
}
```

## Ejemplo 6: SQL con VIBE

```sql
-- VIBE · ÍNDICE: acelera búsquedas por skill_id. POR QUÉ: queries en cartera se hacen 100x/día; sin índice, son O(n). FUENTE: análisis de slow query log. EFECTIVIDAD: probada — query de 3.2s → 15ms. CAMBIOS: 2026-06-15 → creado; 2026-06-27 → actualizado con CAMBIOS_TYPE.
CREATE INDEX idx_jobs_skill_id ON jobs(skill_id);

-- VIBE · FILTRO: descarta ofertas con más de 2 cambios de empresa en 2 años. POR QUÉ: red flag de inestabilidad/elige ofertas volatiles. FUENTE: feedback de recruiter. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.
SELECT * FROM jobs WHERE company_stability_score > 0.7;
```

---

**Lección de estos ejemplos:** cada bloque de lógica que escribe la IA lleva un comentario que explica su propósito y por qué se eligió, no solo qué hace. Así, cambios futuros no se hacen a ciegas.
