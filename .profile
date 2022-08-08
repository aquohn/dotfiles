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
test -f "/var/run/login_hooks/$USER" || (test -f "$HOME/.login_hook" && sudo "$HOME/.login_hook" "$USER")

# fix the annoying numlock stuff
setxkbmap -option 'numpad:microsoft'
# fix mousepad scrolling on xfce
synclient VertScrollDelta=-77 HorizScrollDelta=-77

# Program settings

# nvim
export NVIM_LISTEN_ADDRESS=~/.nvimsocket
export EDITOR=vim
export VISUAL=vim

# nnn
export NNN_PLUG='t:preview-tabbed;d:diffs;o:fzopen;r:fzcd;h:fzhist;p:rsynccp'

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
[ -f "/home/aquohn/.ghcup/env" ] && . "/home/aquohn/.ghcup/env"

# rust
. "$HOME/.cargo/env"

# julia
export JULIA_NUM_THREADS=4

# racket
PATH="$HOME/.local/share/racket/$(racket --version | sed 's/.*v\([0-9.]*\).*/\1/')/bin:$PATH"

# spral
export OMP_CANCELLATION=TRUE
export OMP_NESTED=TRUE
export OMP_PROC_BIND=TRUE

export PATH
