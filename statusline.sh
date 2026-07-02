#!/usr/bin/env bash
# Evoprompting statusline para Claude Code — muestra DF (dificultad de la tarea)
# y Promt (calidad de tu petición) integrados en la barra nativa, leyendo ~/.claude/evo-score.
# EVO · STATUSLINE: pinta "carpeta  DF N/10  Promt M/10" en la barra de Claude Code, con color por rango (DF alto = rojo; Promt alto = verde). POR QUÉ: Francisco quería la calificación integrada a la UI como los contadores +/− de GitHub, no solo en el chat; la statusLine es el único punto de extensión visual que Claude Code ofrece. FUENTE: docs de statusLine de Claude Code + Francisco 2026-07-02. EFECTIVIDAD: sin medir. CAMBIOS: ninguno.

input=$(cat 2>/dev/null)
dir=$(printf '%s' "$input" | sed -n 's/.*"current_dir"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)
[ -n "$dir" ] || dir=$PWD

score_file="${EVO_SCORE_FILE:-$HOME/.claude/evo-score}"
df=""; pr=""
if [ -f "$score_file" ]; then
  df=$(sed -n 's/^DF=\([0-9][0-9]*\).*/\1/p' "$score_file" | head -n1)
  pr=$(sed -n 's/^PROMPT=\([0-9][0-9]*\).*/\1/p' "$score_file" | head -n1)
fi

color_df() { if [ "$1" -le 3 ]; then printf '32'; elif [ "$1" -le 6 ]; then printf '33'; else printf '31'; fi; }
color_pr() { if [ "$1" -le 3 ]; then printf '31'; elif [ "$1" -le 6 ]; then printf '33'; else printf '32'; fi; }

dim='\033[2m'; off='\033[0m'; bold='\033[1m'
out="${dim}$(basename "$dir")${off}"
if [ -n "$df" ] && [ "$df" -gt 0 ] 2>/dev/null; then
  out="$out  ${bold}DF ${off}\033[$(color_df "$df")m${df}/10${off}"
else
  out="$out  ${dim}DF —${off}"
fi
if [ -n "$pr" ] && [ "$pr" -gt 0 ] 2>/dev/null; then
  out="$out  ${bold}Promt ${off}\033[$(color_pr "$pr")m${pr}/10${off}"
else
  out="$out  ${dim}Promt —${off}"
fi
printf '%b' "$out"
