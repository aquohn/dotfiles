[ -r "$HOME/home/.profile" ] && . "$HOME/home/.profile"

test -f "/var/run/login_hooks/$USER" || (test -f "$HOME/.login_hook" && sudo "$HOME/.login_hook" "$USER")
