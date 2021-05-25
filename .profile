# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# source the user's environment file, if it exists
test -f "$HOME/.env" && . "$HOME/.env"

# run the login hook (sudo stuff in here)
test -f /var/run/login_hooks/$USER || (test -f "$HOME/.login_hook" && sudo ~/.login_hook $USER)

# fix the annoying numlock stuff
setxkbmap -option 'numpad:microsoft'
# fix mousepad scrolling on xfce
synclient VertScrollDelta=-77 HorizScrollDelta=-77

export EDITOR=vim
export VISUAL=vim
# export USE_PISTOL=1
export NNN_PLUG='p:preview-tabbed'

# emacs
PATH="$HOME/.emacs.d/bin:$PATH"
# eclipse
PATH="$HOME/Downloads/eclipse:$PATH"

# provers
PATH="$HOME/.elan/bin:$HOME/.opam/default/bin:$PATH"

# go
PATH="$HOME/go/bin:$PATH"
# ocaml
test -r /home/aquohn/.opam/opam-init/init.sh && . /home/aquohn/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
# haskell
[ -f "/home/aquohn/.ghcup/env" ] && source "/home/aquohn/.ghcup/env"
# rust
. "$HOME/.cargo/env"

export PATH

# run the login hook (sudo stuff in here)
test -f /var/run/login_hooks/$USER || (test -f "$HOME/.login_hook" && sudo ~/.login_hook $USER)

