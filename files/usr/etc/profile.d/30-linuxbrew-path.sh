BREW_PREFIX="/home/linuxbrew/.linuxbrew"

if [ -d "$BREW_PREFIX" ]; then
  case ":$PATH:" in
    *":$BREW_PREFIX/bin:"*) ;;
    *) PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH" ;;
  esac
fi

export PATH
