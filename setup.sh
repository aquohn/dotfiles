# Core: syncthing, git
cd shtool* && ./configure && make && make test
# modify shtool to ln -fs
shtool mkshadow ~/home ~

# Languages: conda, opam, ghc, go, guile, julia (via Jill)
# Terminal: nnn + preview-tabbed, tabbed/suckless-tools, tmux, rg, fd[find]
# Media: mpv, sxiv, zathura
# Reading: qpdfview, okular
# Hardware: ghdl, verilator, gtkwave, yosys

opam repo add coq-released https://coq.inria.fr/opam/released
opam install coq coq-vst merlin ocp-indent utop

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
