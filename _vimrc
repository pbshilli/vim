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

let mapleader = " "
noremap <space> <NOP>

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
" Use ctrl-space for ctrl-n ( autocomplete )
"-----------------------------------------------------------
inoremap <C-Space> <C-n>

"-----------------------------------------------------------
" Use CTRL-N, CTRL-P to cyle through grep results
"-----------------------------------------------------------
nnoremap <silent> <C-N> :cn<CR>zv
nnoremap <silent> <C-P> :cp<CR>zv

"-----------------------------------------------------------
" Use <leader>w for saving
"-----------------------------------------------------------
nnoremap <leader>w :update<CR>
vnoremap <leader>w <C-C>:update<CR>

" ----------------------------------------------------------------------------
" Set whitespace characters and key mapping
" ----------------------------------------------------------------------------
set listchars=tab:»·,trail:·,eol:$
noremap <F11> :set list!<CR>

"-----------------------------------------------------------
" Toggle spell checking on and off with Shift+F11
"-----------------------------------------------------------
noremap <S-F11> :set spell!<CR> 
set spelllang=en

" ----------------------------------------------------------------------------
" Set up Tablist window and key mapping
" ----------------------------------------------------------------------------
let Tlist_WinWidth = 50
noremap <F2> :TlistToggle<cr>
noremap <F6> :call BuildCTags()<CR>

"-----------------------------------------------------------
" Grep keys
"-----------------------------------------------------------
noremap <F3> :call GrepPrompt(1)<CR>
noremap <S-F3> :call GrepPrompt(0)<CR>
noremap <F4> :call GrepCurrentFile(1)<CR>
noremap <S-F4> :call GrepCurrentFile(0)<CR>

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
" Set DAT files's language to C
" ----------------------------------------------------------------------------
au BufNewFile,BufRead *.dat setlocal ft=c

" set diffexpr=mydiff()
" function mydiff()
"   let opt = '-a --binary '
"   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"   let arg1 = v:fname_in
"   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"   let arg2 = v:fname_new
"   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"   let arg3 = v:fname_out
"   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"   let eq = ''
"   if $vimruntime =~ ' '
"     if &sh =~ '\<cmd'
"       let cmd = '""' . $vimruntime . '\diff"'
"       let eq = '"'
"     else
"       let cmd = substitute($vimruntime, ' ', '" ', '') . '\diff"'
"     endif
"   else
"     let cmd = $vimruntime . '\diff'
"   endif
"   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
" endfunction
" 
