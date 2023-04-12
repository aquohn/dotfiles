" Vim color file
" Maintainer:	Shian Lee 
" Last Change:	2014 Mar 6 (for vim 7.4)
" Remark:	"industry" stands for 'industrial' color scheme. In industrial
"		HMI (Human-Machine-Interface) programming, using a standard color
"               scheme is mandatory in many cases (in traffic-lights for example): 
"               LIGHT_RED is	    'Warning' 
"               LIGHT_YELLOW is	    'Attention' 
"               LIGHT_GREEN is	    'Normal' 
"               LIGHT_MAGENTA is    'Warning-Attention' (light RED-YELLOW)
"               LIGHT_CYAN is	    'Attention-Normal'  (light YELLOW-GREEN).
"               BLACK is	    Dark-High-Contrast Background for maximum safety.
"               BLUE is		    Shade of BLACK (not supposed to get attention).
"
"               Industrial color scheme is by nature clear, safe and productive. 
"               Yet, depends on the file type's syntax, it might appear incorrect. 

" Reset to dark background, then reset everything to defaults:
set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "martial"

" First set Normal to regular white on black text colors:
hi Normal ctermfg=LightGray ctermbg=Black guifg=#dddddd	guibg=Black
hi Visual ctermfg=Black ctermbg=LightGray guifg=Black	guibg=#dddddd

" Syntax highlighting (other color-groups using default, see :help group-name):
hi Comment    cterm=NONE ctermfg=DarkCyan    	gui=NONE guifg=#00aaaa   	 
hi Constant   cterm=NONE ctermfg=LightCyan   	gui=NONE guifg=#00ffff   	
hi Identifier cterm=NONE ctermfg=LightMagenta   gui=NONE guifg=#ff00ff   
hi Function   cterm=NONE ctermfg=LightGreen   	gui=NONE guifg=#00ff00   	
hi Statement  cterm=NONE ctermfg=White	     	gui=bold guifg=#ffffff	     	
hi PreProc    cterm=NONE ctermfg=Yellow		gui=NONE guifg=#ffff00 	
hi Type	      cterm=NONE ctermfg=LightGreen	gui=bold guifg=#00ff00 		
hi Special    cterm=NONE ctermfg=LightRed    	gui=NONE guifg=#ff0000    	
hi Delimiter  cterm=NONE ctermfg=Yellow    	gui=NONE guifg=#ffff00    	

" In diffs, added lines are green, changed lines are yellow, deleted lines are
" red, and changed text (within a changed line) is bright yellow and bold.
highlight DiffAdd        ctermfg=0    ctermbg=2
highlight DiffChange     ctermfg=0    ctermbg=3
highlight DiffDelete     ctermfg=0    ctermbg=1
highlight DiffText       ctermfg=0    ctermbg=11   cterm=bold

" Dim line numbers, color columns, the status line, splits and sign
" columns.
if &background == "light"
  " highlight LineNr       ctermfg=7
  highlight CursorLineNr ctermfg=8
  highlight ColorColumn  ctermfg=8    ctermbg=7
  highlight Folded       ctermfg=8    ctermbg=7
  highlight FoldColumn   ctermfg=8    ctermbg=7
  highlight Pmenu        ctermfg=0    ctermbg=7
  highlight PmenuSel     ctermfg=7    ctermbg=0
  highlight SpellCap     ctermfg=8    ctermbg=7
  highlight StatusLine   ctermfg=0    ctermbg=7    cterm=bold
  highlight StatusLineNC ctermfg=8    ctermbg=7    cterm=NONE
  highlight VertSplit    ctermfg=8    ctermbg=7    cterm=NONE
  highlight SignColumn                ctermbg=7
else
  " highlight LineNr       ctermfg=8
  highlight CursorLineNr ctermfg=7
  highlight ColorColumn  ctermfg=7    ctermbg=8
  highlight Folded       ctermfg=7    ctermbg=8
  highlight FoldColumn   ctermfg=7    ctermbg=8
  highlight Pmenu        ctermfg=15   ctermbg=8
  highlight PmenuSel     ctermfg=8    ctermbg=15
  highlight SpellCap     ctermfg=7    ctermbg=8
  highlight StatusLine   ctermfg=15   ctermbg=8    cterm=bold
  highlight StatusLineNC ctermfg=7    ctermbg=8    cterm=NONE
  highlight VertSplit    ctermfg=7    ctermbg=8    cterm=NONE
  highlight SignColumn                ctermbg=8
endif
