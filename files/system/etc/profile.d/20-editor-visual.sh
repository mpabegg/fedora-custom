pick_editor() {
  command -v nvim >/dev/null 2>&1 && { echo nvim; return; }
  command -v vim  >/dev/null 2>&1 && { echo vim;  return; }
  command -v vi   >/dev/null 2>&1 && { echo vi;   return; }
  echo nano
}

if [ -z "${EDITOR:-}" ]; then
  export EDITOR="$(pick_editor)"
fi

if [ -z "${VISUAL:-}" ]; then
  export VISUAL="$EDITOR"
fi
