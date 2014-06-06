set nocompatible

"-----------------------------------------------------------
" Enable pathogen so that plugins can be kept in bundles under
" one repository
"-----------------------------------------------------------
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#helptags()

" ----------------------------------------------------------------------------
" Don't create a backup file, don't autosave session
" ----------------------------------------------------------------------------
set nobackup
let g:session_autosave = 'no'

" ----------------------------------------------------------------------------
" Set up Solarized color scheme for GVIM
" ----------------------------------------------------------------------------
if has("gui_running")
    " ------------------------------------------------------------------------
    " Set up Solarized color scheme for GVIM
    " ------------------------------------------------------------------------
    let g:solarized_visibility = "high"
    syntax enable
    set background=dark
    colorscheme solarized
    set guifont=Consolas:h10

    " ------------------------------------------------------------------------
    " Remove menu bar, toolbar, and scroll bars
    " ------------------------------------------------------------------------
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r

" ----------------------------------------------------------------------------
" Set up terminal editor
" ----------------------------------------------------------------------------
else

endif

" ----------------------------------------------------------------------------
" Make line numbers, cursor position, and partial commmands visible
" ----------------------------------------------------------------------------
set nu ruler showcmd

" ----------------------------------------------------------------------------
" Set highlighted, incremental search
" ----------------------------------------------------------------------------
set hlsearch incsearch

" ----------------------------------------------------------------------------
" Set default window size and disable word line wrapping
" ----------------------------------------------------------------------------
set lines=50 columns=115 nowrap

" ----------------------------------------------------------------------------
" Set tab behavior to always use/expect 4 spaces
" ----------------------------------------------------------------------------
set tabstop=4 shiftwidth=4 smarttab expandtab autoindent smartindent

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
" Use CTRL-N, CTRL-P to cyle through grep results
"-----------------------------------------------------------
nnoremap <silent> <C-N> :update<CR>:cn<CR>zv
nnoremap <silent> <C-P> :update<CR>:cp<CR>zv

nnoremap <silent> <leader>n :update<CR>:cn<CR>zv
nnoremap <silent> <leader>N :update<CR>:cp<CR>zv

"-----------------------------------------------------------
" Use <leader>w for saving
"-----------------------------------------------------------
nnoremap <leader>w :update<CR>
vnoremap <leader>w <C-C>:update<CR>

" ----------------------------------------------------------------------------
" Set whitespace characters and key mapping
" ----------------------------------------------------------------------------
set listchars=tab:��,trail:�,eol:$
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
    let file_set = input( "File Set: ", g:vimgrep_file_set_default )
    if( file_set != "" )
        execute "vimgrep /" . pattern . "/gj " . file_set
        execute "copen"
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
