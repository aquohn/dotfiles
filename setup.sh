# Core: syncthing, git
cd shtool* && ./configure && make && make test
# modify shtool to ln -fs
shtool mkshadow ~/home ~

# conda
conda config --add channels conda-forge
conda config --add channels aquohn

# Terminal: nnn + preview-tabbed (change to st), tmux, fzf, rg, fd[find]
# Media: mpv, sxiv, zathura
# Reading: qpdfview, okular
# Hardware: ghdl, verilator, gtkwave, yosys

# ocaml: opam
opam repo add coq-released https://coq.inria.fr/opam/released
opam install coq coq-vst merlin ocp-indent utop

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# julia: jill
conda install jill

# ghc, go, guile
