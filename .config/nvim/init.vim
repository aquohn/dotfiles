scriptencoding utf-8

let mapleader = " " " map leader to <Space>
let maplocalleader = " " " map localleader to <Space><Space>
noremap <Leader>e <Plug>(easymotion-prefix)

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')

" Core/Meta
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'Iron-E/nvim-libmodal'

" Files
" Plug 'nathom/filetype.nvim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'junegunn/fzf.vim'

" Languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'universal-ctags/ctags'
Plug 'preservim/tagbar'
Plug 'lervag/vimtex'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'habamax/vim-asciidoctor'
Plug 'axvr/org.vim'
Plug 'derekwyatt/vim-scala'

" Colours
Plug 'gerw/vim-HiLinkTrace'
Plug 'editorconfig/editorconfig-vim'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'noahfrederick/vim-noctu'
Plug 'glepnir/oceanic-material'
Plug 'altercation/vim-colors-solarized'
" Plug 'Soares/base16.nvim'

" Editing
Plug 'tommcdo/vim-lion'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'mbbill/undotree'

" Vim in your browser!
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

syntax on
filetype on
set notimeout
set nottimeout

" Appearance
set ruler
set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
set showmatch incsearch
set inccommand=nosplit
set background=dark
"See invisible characters
set list listchars=tab:>\ ,trail:+,eol:$
colorscheme martial

" Buffers
set hidden " editing other files will hide the current buffer
nnoremap <Leader>b :buffers<CR>:b<Space>
" Close buffer without closing split
command Bdelete bp | sp | bn | bd
command Bunload bp | sp | bn | bun
command Bwipe bp | sp | bn | bw
" Open file in buffer and close previous buffer
command -nargs=1 -complete=file Bopen e <args> | sp | bp | bun

" Navigation
nnoremap <Leader>t :NERDTree
nnoremap <Leader>o :TagbarToggle

" Diffs
nnoremap <Leader>d :diff

" Editing
nnoremap <Leader>u :UndotreeToggle<CR>

" Folding
set foldmethod=syntax
set nofoldenable " open files unfolded

" Statusline
" set statusline+=%{FugitiveStatusline()}

"Enable mouse click for nvim
" set mouse=a
"Fix cursor replacement after closing nvim
" set guicursor=
au VimLeave * set guicursor=a:ver25
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>

" Highlight TODOs
augroup admon
  " \v: very magic, <: begining of word, (|) alternation
  au Syntax * syntax match Admon /\v<(FIXME|NOTE|TODO|OPTIMISE|XXX|DEPRECATED|HACK|REVIEW|WARNING)/
        \ containedin=.*Comment.*
augroup END
hi! def link Admon Todo

" Show completion menu only if there's more than one match
set completeopt=menu

let g:load_doxygen_syntax = 1
let g:ale_echo_msg_format = '%linter%: %s'"
let g:ale_fixers = {
      \ 'python': ['black']
      \ }
let g:ale_linters_ignore = {
      \ 'python': ['pylint']
      \ }

" C
let g:ale_c_build_dir_names=['build', 'bin', 'Debug', 'debug']
autocmd FileType c,cpp setlocal equalprg=clang-format

" Org
autocmd FileType org setlocal fo-=t
" PlantUML
let g:plantuml_set_mkprg = '$HOME/winhome/Software/plantuml.jar'

" LaTeX
let g:tex_flavor = "latex"
" https://castel.dev/post/lecture-notes-1/#sympy-and-mathematica - something to consider
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_automatic = 1
" let g:vimtex_compiler_method = 'tectonic'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_quickfix_ignore_filters = [
          \ '[Oo]verfull',
          \ '[Uu]nderfull',
          \ 'dash',
          \]
let g:vimtex_compiler_progname = 'nvr'

" Spacing
set autoindent
set smartindent
set expandtab
set fo-=t
set textwidth=80
set linebreak
set tabstop=2
set shiftwidth=2

" Shortcuts 
" Clearing highlighting and refereshing
nnoremap <esc> :noh<return><esc>
nnoremap <F5> <Esc>:e<CR>
inoremap <F5> <C-o>:e<CR>

" Graphical movement
noremap <silent> <C-k> k
noremap <silent> <C-j> j
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> $ g$
noremap <silent> ^ g^
noremap <silent> gk k
noremap <silent> gj j
noremap <silent> g$ $
noremap <silent> g^ ^

" Do not clear visual mode on shift
vnoremap > >gv
vnoremap < <gv

" Faster tab commands
command Q tabclose
command WQ wa|tabclose
command Vimrc tabnew $HOME/.config/nvim/init.vim

" Firenvim config

let g:firenvim_config = {
    \ 'localSettings': {
      \ '.*': {
        \ 'takeover': 'never',
        \ }
      \ },
    \ }

" OCaml config
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
set rtp^="/home/aquohn/.opam/default/share/ocp-indent/vim"
