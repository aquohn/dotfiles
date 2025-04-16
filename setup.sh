# Core: syncthing, git

cp -as "$PWD/home/." ~
cp template/.* -t ~

XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$HOME/.local/bin"

# Guix Home
guix home reconfigure "$HOME/.config/guix/home-configuration.scm"

# Nix Home
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch

# Github: dra
mkdir /tmp/dra 2>/dev/null
libc=`ldd /bin/ls | grep 'musl' | head -1 | cut -d ' ' -f1`
([ -z libc ] && libcname=musl) || libcname=gnu
dradir=`curl -s https://api.github.com/repos/devmatteini/dra/releases/latest \
| grep "browser_download_url.*x86_64.*linux-$libcname" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qO- -i - \
| tar xvz -C /tmp/dra \
| grep "^[^/]*/$"`
cp "/tmp/dra/$dradir/dra" ~/.local/bin/dra

# conda: miniconda
conda config --add channels conda-forge
conda config --add channels aquohn
conda env update environment.yml

# Ocaml: opam
opam repo add coq-released https://coq.inria.fr/opam/released
opam install coq coq-vst merlin ocp-indent utop

# Rust: rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Julia: jill
conda install jill
# cp Project.toml .julia/environments/<version>
# Pkg.update
# cp -r ~/.local/share/jupyter/kernels/julia-<version> ~/.conda/envs/aquohn/share/jupyter/kernels

# Haskell: ghc

# golang, guile

# Terminal: nnn + preview-tabbed (change to st), tmux, fzf, rg, fd[find]
# Media: mpv, sxiv, zathura
# Reading: sioyek
# Flatpak: Spotify, Zoom
