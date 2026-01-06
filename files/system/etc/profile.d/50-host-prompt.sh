# Simple, readable Bash prompt
if [ -n "${BASH_VERSION:-}" ]; then
  PS1='\u@\h:\w\$ '
fi
