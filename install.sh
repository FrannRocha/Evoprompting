#!/usr/bin/env bash
# Instalador de Evoprompting para Claude Code.
# Uso:  bash install.sh            → instala la skill + la barra integrada (statusline)
#       bash install.sh --siempre  → además, DF/Promt se califican SIEMPRE, en todos tus proyectos
set -e

CLAUDE_DIR="$HOME/.claude"
SKILL_DIR="$CLAUDE_DIR/skills/evoprompting"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SETTINGS="$CLAUDE_DIR/settings.json"
STATUS_CMD="bash $SKILL_DIR/statusline.sh"

mkdir -p "$SKILL_DIR"
if [ "$REPO_DIR" != "$SKILL_DIR" ]; then
  cp "$REPO_DIR/SKILL.md" "$REPO_DIR/statusline.sh" "$SKILL_DIR/"
fi
chmod +x "$SKILL_DIR/statusline.sh"
[ -f "$CLAUDE_DIR/evo-score" ] || printf 'DF=0\nPROMPT=0\n' > "$CLAUDE_DIR/evo-score"
echo "✓ Skill instalada en $SKILL_DIR"

if [ -f "$SETTINGS" ] && grep -q '"statusLine"' "$SETTINGS"; then
  if grep -q 'evoprompting/statusline.sh' "$SETTINGS"; then
    echo "✓ La barra integrada ya estaba configurada."
  else
    echo "⚠ Ya tienes otra statusLine en $SETTINGS — no la piso."
    echo "  Para usar la de Evoprompting, cambia su \"command\" a: $STATUS_CMD"
  fi
elif [ -f "$SETTINGS" ]; then
  if command -v python3 >/dev/null 2>&1; then
    python3 - "$SETTINGS" "$STATUS_CMD" <<'PY'
import json, sys
path, cmd = sys.argv[1], sys.argv[2]
with open(path) as f:
    data = json.load(f)
data["statusLine"] = {"type": "command", "command": cmd, "padding": 0}
with open(path, "w") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write("\n")
PY
    echo "✓ Barra integrada configurada en $SETTINGS"
  else
    echo "⚠ No encontré python3 para editar $SETTINGS sin riesgo de romperlo."
    echo "  Agrega a mano dentro de $SETTINGS:"
    echo "  \"statusLine\": { \"type\": \"command\", \"command\": \"$STATUS_CMD\", \"padding\": 0 }"
  fi
else
  mkdir -p "$CLAUDE_DIR"
  printf '{\n  "statusLine": {\n    "type": "command",\n    "command": "%s",\n    "padding": 0\n  }\n}\n' "$STATUS_CMD" > "$SETTINGS"
  echo "✓ Barra integrada configurada en $SETTINGS (archivo nuevo)"
fi

if [ "${1:-}" = "--siempre" ]; then
  MEM="$CLAUDE_DIR/CLAUDE.md"
  if grep -q 'Marcador DF/Promt' "$MEM" 2>/dev/null; then
    echo "✓ El marcador DF/Promt permanente ya estaba activo."
  else
    cat >> "$MEM" <<'EOF'

**Marcador DF/Promt siempre activo.** En cada tarea (uses o no la skill evoprompting), califica al terminar: DF = dificultad real de la tarea (1–10) y Promt = qué tan bien planteada estaba la petición (1–10). Sobrescribe `~/.claude/evo-score` con dos líneas: `DF=N` y `PROMPT=M`. Si Promt ≤ 6, sugiere en UNA línea cómo plantear la próxima iteración para que salga mejor.
<!-- EVO · MARCADOR: califica DF/Promt en todo proyecto y alimenta la barra integrada (statusline). POR QUÉ: ayuda a iterar mejor incluso fuera de Evoprompting — ves en la barra qué tan difícil fue la tarea y qué tan bueno fue tu prompt, y recibes el tip de mejora cuando el prompt salió flojo. FUENTE: Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: ninguno. -->
EOF
    echo "✓ Marcador DF/Promt permanente activado (en $MEM)"
  fi
fi

echo ""
echo "Listo. Reinicia tu sesión de Claude Code para ver /evoprompting y la barra DF/Promt."
