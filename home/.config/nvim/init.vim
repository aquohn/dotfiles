scriptencoding utf-8

let mapleader = " " " map leader to <Space>
let maplocalleader = " " " map localleader to <Space><Space>
noremap <Leader>e <Plug>(easymotion-prefix)

" auto-install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugged')

" Core/Meta
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
if has('nvim')
  Plug 'Iron-E/nvim-libmodal'
else
  Plug 'Iron-E/vim-libmodal'
endif

" Files
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Languages
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim'
Plug 'universal-ctags/ctags'
Plug 'craigemery/vim-autotag'
Plug 'preservim/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'

" Colours
Plug 'gerw/vim-HiLinkTrace'
Plug 'editorconfig/editorconfig-vim'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'chriskempson/base16-vim'

" Editing
Plug 'tommcdo/vim-lion'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'mbbill/undotree'
Plug 'jasonccox/vim-wayland-clipboard'

if has('nvim')
  " Vim in your browser!
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif

call plug#end()

" Whose idea was this...
let g:coc_disable_startup_warning = 1

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
if has('nvim')
  set inccommand=nosplit
endif
set background=dark
"See invisible characters
set list listchars=tab:>\ ,trail:+,eol:$
try
  colorscheme martial
catch
endtry

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
if has('wsl')
  vnoremap <C-c> y:!echo <C-r>=escape(substitute(shellescape(getreg('"')), '\n', '\r', 'g'), '%!')<CR> <Bar> clip.exe<CR><CR>
endif

" Folding
set foldmethod=syntax
set nofoldenable " open files unfolded

" Statusline
set statusline=%f\ %h%w%q[%{&ff}]%y\ %m%r\ %{FugitiveStatusline()}%=%{tagbar#currenttag('%s','','f')}%=%04l/%04L\ (%p%%)\ \|\ %03v

" Enable mouse click
" set mouse=a
" Fix cursor replacement after closing nvim
" set guicursor=
" Set cursor to block
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
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

" LaTeX
let g:tex_flavor = "latex"
" https://castel.dev/post/lecture-notes-1/#sympy-and-mathematica - something to consider
" if executable('sioyek')
"   let g:vimtex_view_method = 'sioyek'
" else
  let g:vimtex_view_method = 'general'
  if executable('zathura')
    let g:vimtex_view_general_viewer = 'zathura'
  else
    let g:vimtex_view_general_viewer = 'mupdf'
  endif
" endif
let g:vimtex_view_automatic = 1
" if executable('tectonic')
"   let g:vimtex_compiler_method = 'tectonic'
" else
  let g:vimtex_compiler_method = 'latexmk'
" endif
let g:vimtex_quickfix_ignore_filters = [
      \ '[Oo]verfull',
      \ '[Uu]nderfull',
      \ '[Ww]arning',
      \ 'dash',
      \]

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
command Vimrc tabnew $MYVIMRC

" Firenvim config
if has('nvim')
  let g:firenvim_config = {
        \ 'localSettings': {
          \ '.*': {
            \ 'takeover': 'never',
            \ }
            \ },
            \ }
endif

" OCaml config
if executable('opam')
  let g:opamshare = substitute(system('opam var share'),'\n$','','''')
  execute "set rtp+=" . g:opamshare . "/merlin/vim"
  execute "set rtp^=" . g:opamshare . "/ocp-indent/vim"
endif

