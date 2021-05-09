scriptencoding utf-8

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'lervag/vimtex'
Plug 'tpope/vim-sensible'

call plug#end()

syntax on
filetype on
set notimeout
set nottimeout

" Appearance
set ruler
set number
set showmatch
set incsearch
set inccommand="nosplit"
set list

"Enable mouse click for nvim
set mouse=a
"Fix cursor replacement after closing nvim
" set guicursor=
au VimLeave * set guicursor=a:ver25
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>

"See invisible characters
set list listchars=tab:>\ ,trail:+,eol:$

" Highlight TODOs
augroup vimrc_todo
  au!
  au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMISE|XXX)/
        \ containedin=.*Comment,vimCommentTitle
augroup END
hi! def link MyTodo Todo

" Show completion menu only if there's more than one match
set completeopt=menu

let g:ale_echo_msg_format = '%linter%: %s'"

let g:plantuml_set_mkprg = '$HOME/winhome/Software/plantuml.jar'

let g:load_doxygen_syntax = 1

let g:tex_flavor = "latex"
" https://castel.dev/post/lecture-notes-1/#sympy-and-mathematica - something to consider
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_general_options_latexmk = ''
let g:vimtex_quickfix_ignore_filters = [
          \ '[Oo]verfull',
          \ '[Uu]nderfull',
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
nnoremap <esc><esc> :noh<return>
nnoremap <F5> <Esc>:e<CR>
inoremap <F5> <C-o>:e<CR>

map <C-Tab> gt
map <C-S-Tab> gT

" Graphical movement
noremap <silent> <C-k> k
noremap <silent> <C-j> j
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> <C-4> $
noremap <silent> <C-6> ^
noremap <silent> $ g$
noremap <silent> ^ g^

" Do not clear visual mode on shift
vnoremap > >gv
vnoremap < <gv

" Return to normal mode
tnoremap <C-]> <C-\><C-n>

" Faster tab commands
command Q tabclose
command WQ wa|tabclose
command Vimrc tabnew $HOME/.config/nvim/init.vim
