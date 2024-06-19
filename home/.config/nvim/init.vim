scriptencoding utf-8

let mapleader = " " " map leader to <Space>
let maplocalleader = "  " " map localleader to <Space><Space>

" auto-install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Custom language packs
let g:polyglot_disabled = [ 'pandoc', 'ftdetect' ]

" Nvim vs Vim specific plugins, before load
if has('nvim')
  let g:polyglot_disabled += [ 'lean' ]
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
Plug 'tpope/vim-obsession'
Plug 'preservim/nerdtree'
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Completion
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'lifepillar/vim-mucomplete'
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
else
  Plug 'prabirshrestha/vim-lsp'
endif

" Languages
Plug 'dense-analysis/ale'
Plug 'kana/vim-textobj-user'
Plug 'universal-ctags/ctags'
Plug 'craigemery/vim-autotag'
Plug 'preservim/tagbar'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'vim-scripts/utl.vim'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
" Plug 'jceb/vim-orgmode'
Plug 'JuliaEditorSupport/julia-vim'
" Plug 'https://gitlab.com/HiPhish/guile.vim.git'
Plug 'pseewald/vim-anyfold'
Plug 'Konfekt/FastFold'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'whonore/Coqtail'

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
Plug 'tpope/vim-speeddating'
Plug 'easymotion/vim-easymotion'
Plug 'mbbill/undotree'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'AndrewRadev/switch.vim'

" Purely for Nvim
if has('nvim')
  " Vim in your browser!
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

  " LSP manager
  Plug 'williamboman/mason.nvim'

  " LSP support
  Plug 'kosayoda/nvim-lightbulb'
  Plug 'rmagatti/goto-preview'

  " Lean support
  Plug 'nvim-lua/plenary.nvim'
  Plug 'Julian/lean.nvim'

  " Agda support
  Plug 'neovimhaskell/nvim-hs.vim'
  Plug 'isovector/cornelis', { 'do': 'stack build' }
endif

call plug#end()

" Whose idea was this...
let g:coc_disable_startup_warning = 1

noremap <Leader>e <Plug>(easymotion-prefix)
" Open nnn in buffer's dir
nnoremap <LocalLeader>n :NnnPicker %:p:h<CR>

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
" See invisible characters
set list listchars=tab:>\ ,trail:+,eol:$
" Conceal when available
set conceallevel=2
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
set foldopen-=block " do not open folds with }, etc.

" Statusline
set statusline=%f\ %h%w%q[%{&ff}]%y\ %m%r\ %{FugitiveStatusline()}%=%{tagbar#currenttag('%s','','f')}%=%l/%L\ (%p%%)\ \|\ %3v

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

" Completion
let g:mucomplete#no_mappings = 1
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 100
set completeopt+=menuone,noinsert,preview

inoremap <silent> <plug>(MUcompleteFwdKey) <C-b>
imap <C-b> <plug>(MUcompleteCycFwd)
let g:mucomplete#chains = {
      \ 'vim': ['path', 'cmd', 'keyn'],
      \ 'default': ['path', 'keyn', 'dict', 'uspl', 'omni']
      \ }

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
if executable('latexmk') != 1 " default compiler is latexmk
  let g:vimtex_compiler_method = 'tectonic'
endif
let g:vimtex_compiler_latexmk = {
      \ 'aux_dir': {-> "latexmk/" . expand("%:t:r")},
      \ 'out_dir': {-> "latexmk/" . expand("%:t:r")},
      \}
let g:vimtex_quickfix_ignore_filters = [
      \ '[Oo]verfull',
      \ '[Uu]nderfull',
      \ '[Ww]arning',
      \ 'dash',
      \]

" anyfold
autocmd FileType scheme AnyFoldActivate

" Spacing
set autoindent
set smartindent
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

" Nvim vs Vim specific plugins
if has('nvim')
  let g:firenvim_config = {
        \ 'localSettings': {
          \ '.*': {
            \ 'takeover': 'never',
            \ }
            \ },
            \ }

  " Agda
  let g:cornelis_agda_prefix = "<Bslash>"
  au BufRead,BufNewFile *.agda call AgdaFiletype()
  au QuitPre *.agda :CornelisCloseInfoWindows
  function! AgdaFiletype()
      nnoremap <buffer> <leader>cl :CornelisLoad<CR>
      nnoremap <buffer> <leader>cr :CornelisRefine<CR>
      nnoremap <buffer> <leader>cc :CornelisMakeCase<CR>
      nnoremap <buffer> <leader>c, :CornelisTypeContext<CR>
      nnoremap <buffer> <leader>c. :CornelisTypeContextInfer<CR>
      nnoremap <buffer> <leader>cs :CornelisSolve<CR>
      nnoremap <buffer> <leader>cn :CornelisNormalize<CR>
      nnoremap <buffer> <leader>ca :CornelisAuto<CR>
      nnoremap <buffer> <leader>c<Space> :CornelisGive<CR>
      nnoremap <buffer> gd        :CornelisGoToDefinition<CR>
      nnoremap <buffer> [/        :CornelisPrevGoal<CR>
      nnoremap <buffer> ]/        :CornelisNextGoal<CR>
      nnoremap <buffer> <C-A>     :CornelisInc<CR>
      nnoremap <buffer> <C-X>     :CornelisDec<CR>
  endfunction

  au BufWritePost *.agda execute "normal! :CornelisLoad\<CR>"
  function! CornelisLoadWrapper()
    if exists(":CornelisLoad") ==# 2
      CornelisLoad
    endif
  endfunction

  au BufReadPre *.agda call CornelisLoadWrapper()
  au BufReadPre *.lagda* call CornelisLoadWrapper()

  " LSP
  nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <leader>h <cmd>lua vim.lsp.buf.hover()<CR>

  function! LSPGoto()
    echo "Preview d:defn/t:type/i:impl/D:decl/r:ref "
    let inkey = getcharstr()
    if inkey ==? "d"
      lua require('goto-preview').goto_preview_definition()
    elseif inkey ==? "t"
      lua require('goto-preview').goto_preview_type_definition()
    elseif inkey ==? "i"
      lua require('goto-preview').goto_preview_implementation()
    elseif inkey ==? "D"
      lua require('goto-preview').goto_preview_declaration()
    elseif inkey ==? "r"
      lua require('goto-preview').goto_preview_references()
    endif
  endfunction
  nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
  nnoremap gp :call LSPGoto()<CR>
endif

" OCaml config
if executable('opam')
  let g:opamshare = substitute(system('opam var share'),'\n$','','''')
  execute "set rtp+=" . g:opamshare . "/merlin/vim"
  execute "set rtp^=" . g:opamshare . "/ocp-indent/vim"
endif

" Coqtail
let g:coqtail_noimap = 1

