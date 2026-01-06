# Show a small welcome banner for interactive shells
case $- in
  *i*)
    echo "Welcome to $(hostname)"
    ;;
esac
