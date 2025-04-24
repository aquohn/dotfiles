# `dotfiles`

This is my personal dotfiles setup, meant to be portable across a wide variety of distributions, with a variety of available software. Where possible,
* The existence of commands is tested using `command -v` before they are invoked/configured
* Configuration is done in POSIX-compliant `sh`
- The [XDG base directory](https://wiki.archlinux.org/title/XDG_Base_Directory) specification is followed (config audited using [xdg-ninja](https://github.com/b3nj5m1n/xdg-ninja), unless it is only supported by relatively recent versions of software
* Paths are constructed using environment variables

## Contents

This repository contains three directories:
- `home`, which the home directory is supposed to be a symlink mirror of. The symlink mirror can be created/updated with `cp -as "$PWD/." ~`.
- `template`, which contains templates for local copies of `.env`, `.profile` and `.bashrc` to be put in `$HOME`. The local copies should source the top-level `.env`, `.profile` etc. in this repo, and apply any local configuration specific to this device.
- `software`, for miscellaneous config files which have not been brought in for various reasons.

Amongst the top-level files in this repo, `.profile` sets and exports environment variables, especially `$PATH`, sources various other `profile` files, and starts `ssh-agent`. `.bash` and `.env` implement standard aliases and functions.

## Programs Used

`guix home` is used to manage certain more annoying configuration files (such as `fonts.conf` and `mimeapps.list`). However, it overwrites `$HOME/.profile`, with no ability to change this behaviour. Therefore, `ghomereconf` in `.env` should be used for reconfiguring, which restores `$HOME/.profile`.

`nix` is used to install/run stuff not available on Guix.
