set nocompatible
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
let g:polyglot_disabled = [ 'pandoc', 'ftdetect', 'ada', 'rescript' ]

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
if has('nvim')
  if has('nvim-0.10')
    Plug 'neovim/nvim-lspconfig'
  else
    Plug 'neovim/nvim-lspconfig', { 'tag': 'v1.6.0' }
  endif
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-git'
  Plug 'hrsh7th/cmp-vsnip'
else
  Plug 'prabirshrestha/vim-lsp'
  Plug 'lifepillar/vim-mucomplete'
endif
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" Code
Plug 'dense-analysis/ale'
Plug 'kana/vim-textobj-user'
Plug 'universal-ctags/ctags'
Plug 'craigemery/vim-autotag'
Plug 'preservim/tagbar'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/utl.vim'
Plug 'jpalardy/vim-slime'

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
" Plug 'jceb/vim-orgmode'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'petRUShka/vim-sage'
" Plug 'https://gitlab.com/HiPhish/guile.vim.git'
Plug 'pseewald/vim-anyfold'
Plug 'Konfekt/FastFold'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'whonore/Coqtail'
Plug 'rescript-lang/vim-rescript'

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

  " Lean support
  Plug 'nvim-lua/plenary.nvim'
  if has('nvim-0.10')
    Plug 'Julian/lean.nvim'
  else
    Plug 'Julian/lean.nvim', { 'tag': 'nvim-0.9' }
  endif

  " Agda support
  Plug 'neovimhaskell/nvim-hs.vim'
  Plug 'isovector/cornelis', { 'do': 'stack build' }

  Plug 'nvim-treesitter/nvim-treesitter'
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
set list listchars=tab:>\ ,trail:+
" Conceal when available
set conceallevel=2
try
  colorscheme martial
catch
  try
    colorscheme lunaperche
  catch
    colorscheme industry
  endtry
endtry
let g:rainbow_active = 1

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
let g:remws_on_write = 0
function Remws(do_remws)
  let remws = get(a:, 1, 1)
  " filetypes where trailing whitespace cannot be nuked
  for t in ["vim"]
    if &ft ==? t | let remws = 0 | endif
  endfor
  if remws | :%s/\s\+$//e | endif
endfunction
autocmd BufWrite * call Remws(g:remws_on_write)

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_no_mappings = 1
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeMotionSend
nmap <leader>ss <Plug>SlimeLineSend
let g:slime_python_ipython = 1

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
set guicursor=n-v-o-sm:block,i-r-c-ci-cr:ver25
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

" Scratchspaces

" redirect the output of a Vim or external command into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let cmd = a:cmd =~' %'
          \ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
          \ : matchstr(a:cmd, '^!\zs.*')
    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . " <<< $" . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif
  vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, output)
endfunction

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
command! -nargs=1 -complete=command -range RedirQ silent call Redir(<q-args>, <range>, <line1>, <line2>)

" Put search results in location list and show it
nnoremap <leader>f :lvimgrep // % \| lwindow<CR>
" Use :cw/:lw to open and close qf/loclist

" Completion
set completeopt=menuone,noselect
if has('patch-8.1.1880') || has('nvim-10.2')
  set completeopt+=popup
endif
set completefunc=syntaxcomplete#Complete

if !has('nvim')
  let g:mucomplete#no_mappings = 1
  let g:mucomplete#no_popup_mappings = 1
  let g:mucomplete#enable_auto_at_startup = 1
  let g:mucomplete#completion_delay = 100
  inoremap <silent> <plug>(MUcompleteBwdKey) <C-b>
  imap <C-b> <plug>(MUcompleteCycBwd)
  let g:mucomplete#chains = {
        \ 'vim': ['path', 'cmd', 'c-n'],
        \ 'default': ['path', 'omni', 'user', 'c-p', 'dict', 'uspl']
        \ }
endif
" mucomplete of nvim lsp broken by https://github.com/lifepillar/vim-mucomplete/issues/180
" upstream: https://github.com/neovim/neovim/issues/12390

let g:load_doxygen_syntax = 1
let g:ale_echo_msg_format = '%linter%: %s'"
let g:ale_linters_ignore = {
      \ 'python': ['pylint'],
      \ 'cpp': ['ccls', 'clangcheck', 'clangtidy', 'clazy', 'cppcheck', 'cpplint', 'cquery', 'cspell']
      \ }

" C
let g:ale_c_build_dir_names=['build', 'bin', 'Debug', 'debug']
autocmd FileType c,cpp setlocal equalprg=clang-format

" C++
let g:ale_cpp_cc_executable = 'g++'
let g:ale_cpp_cc_options = '-std=c++20 -Wall'

" Verilog/SystemVerilog
autocmd FileType verilog let g:ale_verilog_verilator_options='--default-language "1364-2005"'

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
let g:vimtex_fold_enabled = 1
if executable('latexmk') != 1 " default compiler is latexmk
  let g:vimtex_compiler_method = 'tectonic'
endif
let g:vimtex_compiler_latexmk = {
      \ 'aux_dir': 'latexmk',
      \ 'out_dir': 'latexmk',
      \ 'options': [
      \   '-shell-escape',
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ]
      \}
let g:vimtex_quickfix_ignore_filters = [
      \ '[Oo]verfull',
      \ '[Uu]nderfull',
      \ '[Ww]arning',
      \ 'dash',
      \ 'punctuation in front of quotes',
      \ 'Missing character: There is no .* in font nullfont!',
      \]

" OCaml config
if executable('opam')
  let g:opamshare = substitute(system('opam var share'),'\n$','','''')
  execute "set rtp+=" . g:opamshare . "/merlin/vim"
  execute "set rtp^=" . g:opamshare . "/ocp-indent/vim"
endif

" Coqtail
let g:coqtail_noimap = 1

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
" :qa
nnoremap ZA :qa<CR>

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
        \     '.*': {
        \       'takeover': 'never',
        \     }
        \   },
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
  nnoremap <leader>? <cmd>lua vim.diagnostic.open_float()<CR>

  function! LSPGoto()
    echo "Go to d:defn/t:type/i:impl/D:decl/r:ref "
    let inkey = getcharstr()
    if inkey ==? "d"
      lua vim.lsp.buf.definition()
    elseif inkey ==? "t"
      lua vim.lsp.buf.type_definition()
    elseif inkey ==? "i"
      lua vim.lsp.buf.implementation()
    elseif inkey ==? "D"
      lua vim.lsp.buf.declaration()
    elseif inkey ==? "r"
      lua vim.lsp.buf.references()
    endif
    messages clear
  endfunction
  nnoremap gp :call LSPGoto()<CR>
endif
