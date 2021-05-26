# Core: syncthing, git
cd shtool* && ./configure && make && make test
# modify mkshadow to ln -fs
shtool mkshadow ~/home ~

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
# Reading: qpdfview, okular
# Hardware: ghdl, verilator, gtkwave, yosys
