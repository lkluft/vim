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

" general settings
set autoindent              " copy indent from current when starting a new line
set autoread                " reload file if changed (only in GUI mode)
set autowrite               " auto-save buffer (e.g. when using :make)
set bs=indent,eol,start     " using backspace to delete characters
set cb=unnamed              " yank/delete to system clipboard
set copyindent              " copy existing lines indent when autoindenting
set expandtab               " Expand TABs to spaces
set hidden                  " hide buffers instead of closing them
set history=500             " history size
set hlsearch                " highlight search results
set incsearch               " Incremental search
set lcs=tab:>-,trail:-      " strings to use in list mode
set list                    " enable list mode
set mouse=a                 " Enable mouse usage (all modes)
set nobackup                " prevent vim from writing backup files
set noswapfile              " prevent vim from writing .swp files
set number                  " show line numbers
set pastetoggle=<F2>        " disable autoindent when pasting content
set ruler                   " show file stats in the bottom right corner
set shiftround              " use multiple of shiftwidth when indenting with '<'
set shiftwidth=4            " Indents will have a width of 4
set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets.
set smartcase               " Do smart case matching
set softtabstop=4           " Sets the number of columns for a TAB
set tabstop=4               " The width of a TAB is set to 4.
set textwidth=80            " wrap lines after 80 columns
set wildmenu
set wildmode=list:longest,full
setglobal commentstring=#\ %s   " commentstring for undetected filetypes

" enable syntax highlighting
if has("syntax")
    syntax on
    syntax enable
endif

set background=dark
if has('gui_running')
    " GUI mode
    set go-=T   " hide toolbar
    set go-=r   " hide scrollbar

    " different fonts on Linux/MacOS
    if has("gui_gtk2")
        set guifont=Monospace\ 10
    elseif has("gui_macvim")
        set guifont=PT\ Mono:h14
    endif
endif

" colorscheme
colorscheme meta5

if has("autocmd")
    " jump to the last position when reopening a file
    au BufWinLeave ?* mkview
    au BufWinEnter ?* silent loadview

    " load indentation rules and plugins according to the detected filetype.
    filetype plugin indent on

    " equal window sizes after resizing vim
    au VimResized * wincmd =

    " source .vimrc file after saving it
    au BufWritePost $MYVIMRC source $MYVIMRC
endif

" force myself to use hjkl
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" unhighlight search results
nmap <silent> ,/ :nohl<CR>

" save a root file if you forgot to sudo in the first place
cmap w!! w !sudo tee >/dev/null %

" highlight last inserted text
nnoremap gV `[v`]

" insert timestamp in ChangeLog format
:map <C-D> i<C-R>=strftime("%Y-%m-%d  Lukas Kluft <lukas.kluft@gmail.com>")<CR><Esc>
:imap <C-D> <C-R>=strftime("%Y-%m-%d  Lukas Kluft <lukas.kluft@gmail.com>")<CR>

" easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" toggle relative line numbers
function! NumberToggle()
    if &relativenumber == 1
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<CR>

" toggle background and colorscheme
function! BackgroundToggle()
    if &background != 'dark'
        set background=dark
        colorscheme meta5
    else
        set background=light
        colorscheme moria
    endif
endfunction
nnoremap <silent> <F5> :call BackgroundToggle()<CR>
