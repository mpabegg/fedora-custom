# Ensure UTF-8 locale without forcing a specific language
if [ -z "${LANG:-}" ]; then
  export LANG="C.UTF-8"
fi
