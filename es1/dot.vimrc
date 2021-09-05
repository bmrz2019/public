"------------------------------------------------------------------------------
" File: $HOME/.vimrc
" Author: Uwe Hermann <uwe@hermann-uwe.de>
" URL: http://www.hermann-uwe.de/files/vimrc
" $Id: .vimrc 331 2005-09-07 21:09:32Z uh1763 $
"------------------------------------------------------------------------------

" version 6.3


"------------------------------------------------------------------------------
" Standard stuff.
"------------------------------------------------------------------------------

" set nocompatible        " Disable vi compatibility.
"set spell spelllang=en_us
set nobackup            " Do not keep a backup file.
set history=100         " Number of lines of command line history.
set undolevels=200      " Number of undo levels.
set textwidth=0         " Don't wrap words by default.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set ignorecase          " Case insensitive matching.
set incsearch           " Incremental search.
set noautoindent        " I indent my code myself.
set nocindent           " I indent my code myself.
set scrolloff=5         " Keep a context when scrolling.
" set digraph             " Required for e.g. German umlauts.
set noerrorbells        " No beeps.
" set nomodeline          " Disable modeline.
set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set tabstop=3           " Number of spaces <tab> counts for.
set ttyscroll=0         " Turn off scrolling (this is faster).
set ttyfast             " We have a fast terminal connection.
set hlsearch            " Highlight search matches.
" set encoding=utf-8      " Set default encoding to UTF-8.
" set showbreak=+         " Show a '+' if a line is longer than the screen.
set laststatus=2        " When to show a statusline.
" set autowrite           " Automatically save before :next, :make etc.

set nostartofline       " Do not jump to first character with page commands,
                        " i.e., keep the cursor in the current column.
set viminfo='20,\"50    " Read/write a .viminfo file, don't store more than
                        " 50 lines of registers.

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Tell vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
set listchars=tab:>-,trail:�,eol:$

" Path/file expansion in colon-mode.
set wildmode=list:longest
set wildchar=<TAB>

" Enable syntax-highlighting.
if has("syntax")
  syntax on
endif

set background=light
" Use brighter colors if your xterm has a dark background.
"if &term =~ "xterm"
"  set background=dark
"endif


"------------------------------------------------------------------------------
" Function keys.
"------------------------------------------------------------------------------

" F1: Toggle hlsearch (highlight search matches).
nmap <F1> :1<CR>

" F2: Toggle list (display unprintable characters).
"nnoremap <F2> :set list!<CR>
nmap <F2> :set nospell<CR>

" F3: Toggle expansion of tabs to spaces.
"nmap <F3> :set expandtab!<CR>
nmap <F3> :set spell spelllang=en_us<CR>

" F4: Write a ChangeLog entry. then enter insert mode
" nmap <F4> :r !date<CR>A Uwe Hermann <uwe@hermann-uwe.de><CR><CR> * |
nmap <F4> :$<CR>

" F5: Insert current date.
" map <F5> :r !date<CR>#!/bin/bash<CR><CR>
" F5: duplicating end columns
map <F5> :%s= \f\+$=&&=<CR>

" delete html tags, leave text (non-greedy)
map <F6> :%s#<[^>]\+>##g<CR>

" delete html tags possibly multi-line (non-greedy)
map <F7> :%s#<\_.\{-1,}>##g<CR>

"------------------------------------------------------------------------------
" Correct typos.
"------------------------------------------------------------------------------

" English.
iab beacuse    because
iab becuase    because
iab acn        can
iab cna        can
iab centre     center
iab chnage     change
iab chnages    changes
iab chnaged    changed
iab chnagelog  changelog
iab Chnage     Change
iab Chnages    Changes
iab ChnageLog  ChangeLog
iab debain     debian
iab Debain     Debian
iab defualt    default
iab Defualt    Default
iab differnt   different
iab diffrent   different
iab emial      email
iab Emial      Email
iab figth      fight
iab figther    fighter
iab fro        for
iab fucntion   function
iab ahve       have
iab homepgae   homepage
iab logifle    logfile
iab lokk       look
iab lokking    looking
iab mial       mail
iab Mial       Mail
iab miantainer maintainer
iab amke       make
iab mroe       more
iab nwe        new
iab recieve    receive
iab recieved   received
iab erturn     return
iab retrun     return
iab retunr     return
iab seperate   separate
iab shoudl     should
iab soem       some
iab taht       that
iab thta       that
iab teh        the
iab tehy       they
iab truely     truly
iab waht       what
iab wiht       with
iab whic       which
iab whihc      which
iab yuo        you
iab databse    database
iab versnio    version
iab obnsolete  obsolete
iab flase      false
iab recrusive  recursive
iab Recrusive  Recursive

" German.
iab cioa       ciao
iab Cioa       Ciao
iab nciht      nicht
iab zeimlicher ziemlicher
iab zeimlich   ziemlich
iab scheisse   schei�e
iab Scheisse   Schei�e
iab morgne     morgen
iab Morgne     Morgen

" Days of week.
iab monday     Monday
iab tuesday    Tuesday
iab wednesday  Wednesday
iab thursday   Thursday
iab friday     Friday
iab saturday   Saturday
iab sunday     Sunday

" Enable this if you mistype :w as :W or :q as :Q.
" nmap :W :w
" nmap :Q :q


"------------------------------------------------------------------------------
" Abbreviations.
"------------------------------------------------------------------------------


" Helpfile.
" set helpfile=$VIMRUNTIME/doc/help.txt


"------------------------------------------------------------------------------
" Local settings.
"------------------------------------------------------------------------------

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Return to last edit position (You want this!) *N*
" autocmd BufReadPost *
"   \ if line("'\"") > 0 && line("'\"") <= line("$") |
"   \   exe "normal! g`\"" |
"   \ endif


"au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



" Helpfile.
" set helpfile=$VIMRUNTIME/doc/help.txt


"------------------------------------------------------------------------------
" Local settings.
"------------------------------------------------------------------------------

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Return to last edit position (You want this!) *N*
" autocmd BufReadPost *
"   \ if line("'\"") > 0 && line("'\"") <= line("$") |
"   \   exe "normal! g`\"" |
"   \ endif


"au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


