" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

syntax enable
if has('gui_running')
    " GUI mode
    " switch dark/light depending on time
    let hr=strftime("%H")
    if hr > 6 && hr < 18
        set background=light
    else
        set background=dark
    endif

    " function to toggle between background modes
    call togglebg#map("<F5>")

    set go-=T   " hide toolbar
    set go-=r   " hide scrollbar
    " different fonts on Linux/MacOS
    if has("gui_gtk2")
        set guifont=Monospace\ 10
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    endif
else
    " VIM in terminal
    set background=dark
    let g:solarized_termcolors=256
    set t_Co=256
endif

" colorscheme
colorscheme solarized

" tab bar color
:hi TabLineSel  ctermfg=White   ctermbg=Black       " active label
:hi TabLine     ctermfg=Grey    ctermbg=DarkGrey    " other labels
:hi TabLineFill ctermfg=Black   ctermbg=DarkGrey    " rest of the bar

" tab navigation
nnoremap <S-tab>    :tabprevious<CR>
nnoremap <C-tab>    :tabnext<CR>
nnoremap <C-t>      :tabnew<CR>
inoremap <S-tab>    <Esc>:tabprevious<CR>i
inoremap <C-tab>    <Esc>:tabnext<CR>i
inoremap <C-t>      <Esc>:tabnew<CR>

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set hlsearch        " highlight search results
set autoindent
set copyindent
set mouse=a         " Enable mouse usage (all modes)
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set number          " show line numbers
set autoread        " reload file if changed (only in GUI mode)

" highlight tabs and trailing spaces
set listchars=tab:>-,trail:-
set list

" highlight last inserted text
nnoremap gV `[v`]

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

set shiftwidth=4    " Indents will have a width of 4
set shiftround      " use multiple of shiftwidth when indenting with '<'

" using backspace to delete characters
set backspace=indent,eol,start

" tab completition
set wildmenu
set wildmode=list:longest,full

" adding extensions to syntax highlighting
au BufNewFile,BufRead *.fi set filetype=fortran
