# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# non-login shells will execute $ENV
ENV="$HOME/.env"; export ENV
# some non-compliant shells look for $SHINIT instead
SHINIT="$HOME/.env"; export SHINIT

# make sure our XDG dirs are set
XDG_CONFIG_HOME="$HOME/.config"; export XDG_CONFIG_HOME
XDG_DATA_HOME="$HOME/.local/share"; export XDG_DATA_HOME
XDG_STATE_HOME="$HOME/.local/state"; export XDG_STATE_HOME
XDG_CACHE_HOME="$HOME/.local/cache"; export XDG_CACHE_HOME

## execute tmux by default
## may cause some trouble with graphical login
## so copy to local .profile if desired
#if command -v tmux >/dev/null 2>/dev/null && [ -n "$PS1" ] && [ "$TERM" != screen ] && [ "$TERM" != tmux ] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

prepath() {
  if [ -d "$1" ] ; then
    PATH="$1:$PATH"
  fi
}

postpath() {
  if [ -d "$1" ] ; then
    PATH="$PATH:$1"
  fi
}

checksource() {
  if [ -r "$1" ] ; then
    . "$1" >/dev/null 2>&1 || true
  fi
}

# add various directories to PATH if they exist
prepath "$HOME/bin"
prepath "$HOME/.local/bin"
postpath "/usr/sandbox"
postpath "/usr/local/bin"
postpath "/usr/bin"
postpath "/bin"
postpath "/usr/local/games"
postpath "/usr/games"
postpath "/usr/share/games"
postpath "/usr/local/sbin"
postpath "/usr/sbin"
postpath "/sbin"

postpath "$HOME/.local/share/flatpak/exports/bin"
postpath "/var/lib/flatpak/exports/bin"
postpath "$HOME/.emacs.d/bin"
postpath "$HOME/.elan/bin"
postpath "${GOPATH:-$HOME/go}/bin"
[ "`command -v racket`" ] && postpath "${PLTADDONDIR:-$XDG_DATA_HOME/racket}/`racket --version | sed 's/.*v\([0-9.]*\).*/\1/'`/bin"
[ "`command -v npm`" ] && postpath "`npm -g bin 2>/dev/null`"
checksource "${GHCUP_INSTALL_BASE_PREFIX:-$HOME}/.ghcup/env"
checksource "${CARGO_HOME:-$HOME/.cargo}/env"

export PATH

EDITOR=ex; export EDITOR
VISUAL=vim; export VISUAL
PAGER=less; export PAGER

NVIM_LISTEN_ADDRESS="$HOME/.nvimsocket"; export NVIM_LISTEN_ADDRESS
NNN_PLUG='p:preview-tui;o:fzopen;d:fzcd;h:fzhist;v:rsynccp;t:preview-tabbed'; export NNN_PLUG

# make less more friendly for non-text input files
if [ "`command -v lesspipe`" ]; then
  eval "`SHELL=/bin/sh lesspipe`"
elif [ "`command -v lesspipe.sh`" ]; then
  eval "`SHELL=/bin/sh lesspipe.sh`"
fi

# Nix
if [ "`command -v nix`" ]; then
  checksource /etc/profile.d/nix.sh
  checksource $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
  XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.nix-profile/share"; export XDG_DATA_DIRS
fi

# Guix
if [ "`command -v guix`" ]; then
  GUIX_PROFILE="$HOME/.guix-profile"; export GUIX_PROFILE
  GUIX_LOCPATH="$GUIX_PROFILE/lib/locale"; export GUIX_LOCPATH
  checksource "$GUIX_PROFILE/etc/profile"
fi

# ssh-agent
if [ "`command -v ssh-agent`" ] && [ -z "$SSH_AUTH_SOCK" ]; then
  eval `ssh-agent`
  find "$HOME/.ssh/" -type f -exec grep -Zl "PRIVATE" {} \;  | xargs -0 ssh-add
fi

# Sage
if [ "`command -v sage`" ]; then
  DOT_SAGE="$XDG_CONFIG_HOME/sage"; export DOT_SAGE
fi

TEXINPUTS="$HOME/.local/share/latex:$TEXINPUTS"; export TEXINPUTS

if [ -n "${BASH_VERSINFO+x}" ]; then
  checksource "$HOME/.bashrc"
elif [ -n "${ZSH_VERSION+x}" ]; then
  checksource "$HOME/.zshrc"
else
  checksource "$ENV"
fi

