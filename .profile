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
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PATH="$HOME/.emacs.d/bin:$HOME/go/bin:$PATH"

export EDITOR=vim
export VISUAL=vim
# export USE_PISTOL=1
export NNN_PLUG='p:preview-tabbed'

# opam configuration
test -r /home/aquohn/.opam/opam-init/init.sh && . /home/aquohn/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

[ -f "/home/aquohn/.ghcup/env" ] && source "/home/aquohn/.ghcup/env" # ghcup-env
