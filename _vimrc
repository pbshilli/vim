set nocompatible

"-----------------------------------------------------------
" Load plugins
"-----------------------------------------------------------
call plug#begin('~/vimfiles/plugged')

Plug 'kien/ctrlp.vim'

Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'davidhalter/jedi-vim'

Plug 'romainl/Apprentice'

Plug 'scrooloose/nerdtree'

Plug 'garbas/vim-snipmate'

Plug 'm42e/trace32-practice.vim'

call plug#end()

" ----------------------------------------------------------------------------
" Don't create a backup file, don't autosave session
" ----------------------------------------------------------------------------
set nobackup
let g:session_autosave = 'no'

" ----------------------------------------------------------------------------
" Set up GVIM
" ----------------------------------------------------------------------------
if has("gui_running")
    " ------------------------------------------------------------------------
    " Set the GUI font
    " ------------------------------------------------------------------------
    set guifont=Consolas:h10

    " ------------------------------------------------------------------------
    " Set up the Apprentice color scheme
    " ------------------------------------------------------------------------
    colorscheme apprentice

    " ------------------------------------------------------------------------
    " Remove menu bar, toolbar, and scroll bars
    " ------------------------------------------------------------------------
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r

    " ------------------------------------------------------------------------
    " Set default window size
    " ------------------------------------------------------------------------
    set lines=50 columns=115

" ----------------------------------------------------------------------------
" Set up terminal VIM in ComEmu
" ----------------------------------------------------------------------------
elseif !empty($CONEMUBUILD)
    " ------------------------------------------------------------------------
    " Set up 256 color mode
    " ------------------------------------------------------------------------
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"

    " ------------------------------------------------------------------------
    " Set up the Apprentice color scheme
    " ------------------------------------------------------------------------
    colorscheme apprentice
endif

" ----------------------------------------------------------------------------
" Enable syntax highlighting
" ----------------------------------------------------------------------------
syntax enable

" ----------------------------------------------------------------------------
" Make line numbers, cursor position, and partial commmands visible
" ----------------------------------------------------------------------------
set nu ruler showcmd

" ----------------------------------------------------------------------------
" Set highlighted, incremental search
" ----------------------------------------------------------------------------
set hlsearch incsearch

" ----------------------------------------------------------------------------
" Disable word line wrapping
" ----------------------------------------------------------------------------
set nowrap

" ----------------------------------------------------------------------------
" Set tab behavior to always use/expect 4 spaces
" ----------------------------------------------------------------------------
set tabstop=4 shiftwidth=4 smarttab expandtab autoindent

" ----------------------------------------------------------------------------
" Set CTRL-A and CTRL-X to only work on decimal and hex numbers
" ----------------------------------------------------------------------------
set nrformats="hex"

" ----------------------------------------------------------------------------
" Set format options to auto-format comments 
" ----------------------------------------------------------------------------
set formatoptions=crqnj

" ----------------------------------------------------------------------------
" Set key timeout length to 700 milliseconds
" ----------------------------------------------------------------------------
set timeoutlen=700

" ----------------------------------------------------------------------------
" Set leader to space
" ----------------------------------------------------------------------------
let mapleader = " "
noremap <space> <NOP>

" ----------------------------------------------------------------------------
" Break bad habits
" ----------------------------------------------------------------------------
noremap <Up>       <NOP>
noremap <Down>     <NOP>
noremap <Left>     <NOP>
noremap <Right>    <NOP>
noremap <PageUp>   <NOP>
noremap <PageDown> <NOP>
noremap <Home>     <NOP>
noremap <End>      <NOP>

"-----------------------------------------------------------
" Smooth page up/down scrolling
"-----------------------------------------------------------
noremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
noremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

"-----------------------------------------------------------
" Buffer movement
"-----------------------------------------------------------
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"-----------------------------------------------------------
" Make Y work like C and D
"-----------------------------------------------------------
nnoremap Y y$

"-----------------------------------------------------------
" Make an 'inner underscore' movement
"-----------------------------------------------------------
nnoremap ci_ T_ct_
vnoremap i_ T_<C-C>vt_
nnoremap yi_ T_yt_
nnoremap di_ F_dt_

"-----------------------------------------------------------
" Use <leader>bd to delete a buffer without closing the
" window
"-----------------------------------------------------------
nnoremap <silent> <leader>bd :bp\|bd #<CR>

"-----------------------------------------------------------
" Use CTRL-N, CTRL-P to cyle through grep results
"-----------------------------------------------------------
nnoremap <silent> <C-N> :update<CR>:cn<CR>zv
nnoremap <silent> <C-P> :update<CR>:cp<CR>zv

"-----------------------------------------------------------
" Use <leader>w for saving
"-----------------------------------------------------------
nnoremap <leader>w :update<CR>
vnoremap <leader>w <C-C>:update<CR>

"-----------------------------------------------------------
" Use <leader>8  and <C-v> for pasting from the clipboard
"-----------------------------------------------------------
nnoremap <leader>8 "*p
vnoremap <leader>8 "*p
inoremap <C-v> <C-R>*

" ----------------------------------------------------------------------------
" Set whitespace characters and key mapping
" ----------------------------------------------------------------------------
set listchars=tab:»·,trail:·,eol:$
noremap <F11> :set list!<CR>

" ----------------------------------------------------------------------------
" Ctags
" ----------------------------------------------------------------------------
let g:ctags_cmd = "ctags -B --excmd=p"
noremap <F6> :call BuildCTags()<CR>

function BuildCTags()
    execute "silent !start /MIN cmd /c \"" . g:ctags_cmd .
          \ " & \"" . $VIMRUNTIME . "\\gvim.exe\" --remote-send "
          \ "\"<ESC>:echo 'CTags build complete'<CR>\" --servername " . v:servername . "\""
endfunction
  
"-----------------------------------------------------------
" Vimgrep keys
"-----------------------------------------------------------
let g:vimgrep_file_set_default = "*.*"
function VimgrepPrompt()
    let pattern = input( "Vimgrep Pattern: ", expand( "<cword>" ) )
    let file_set = input( "File Set: ", g:vimgrep_file_set_default, "file" )
    if( file_set != "" )
        let vimgrep_cmd = "vimgrep /" . pattern . "/gj " . file_set . " | copen"
        execute vimgrep_cmd
        call histadd( "cmd", vimgrep_cmd )
    endif
endfunction

noremap <F3> :call VimgrepPrompt()<CR>
noremap <leader>/ :call VimgrepPrompt()<CR>

" ----------------------------------------------------------------------------
" Map commenting
" ----------------------------------------------------------------------------
nnoremap <leader>cv :call LineComment()<CR>
if( !exists( "*LineComment" ) )
    function LineComment()
        if virtcol('$') >= 37
            execute "normal! o\<Esc>36i \<esc>"
        else
            execute "normal! 37A \<Esc>37|dw"
        endif
        execute "normal! a/* */\<Esc>h" 
        startinsert
        " TODO set colorcolumn and textwidth
        " TODO pull numbers out to global
    endfunction
endif

nnoremap <leader>cb :call BlockComment()<CR>
if( !exists( "*BlockComment" ) )
    function BlockComment()
        execute "normal! ^\"iy0O\<Esc>i\<C-R>i/*\<esc>61a-\<Esc>61|dw"
        execute "normal! o\<Esc>\"ip59a-\<Esc>59|dwa*/\<Esc>"
        execute "normal! O\<Esc>\"ip"
        startinsert!
        " TODO pull numbers out to global
        " TODO make a comment fixer
    endfunction
endif

" ----------------------------------------------------------------------------
" Ctrl-P
" ----------------------------------------------------------------------------
let g:ctrlp_map               = '<nop>'
let g:ctrlp_cmd               = 'CtrlP'
let g:ctrlp_working_path_mode = 'c'
noremap <leader>p :CtrlP<CR>

" ----------------------------------------------------------------------------
" Jedi-Vim
" ----------------------------------------------------------------------------
let g:jedi#use_tabs_not_buffers = 0

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
noremap <leader>nt :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['\.pyc$']

" ----------------------------------------------------------------------------
" File autocommands
" ----------------------------------------------------------------------------
if !exists( "autocommands_loaded" )
    let autocommands_loaded = 1

    " ------------------------------------------------------------------------
    " Format git commits for readability
    " ------------------------------------------------------------------------
    autocmd FileType gitcommit set textwidth=72 formatoptions+=t
endif
