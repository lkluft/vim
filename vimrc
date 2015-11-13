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

" enable syntax highlighting
if has("syntax")
    syntax on
endif

syntax enable
if has('gui_running')
    " GUI mode
    set background=dark

    " function to toggle between background modes
    call togglebg#map("<F5>")

    set go-=T   " hide toolbar
    set go-=r   " hide scrollbar
    " different fonts on Linux/MacOS
    if has("gui_gtk2")
        set guifont=Monospace\ 10
    elseif has("gui_macvim")
        set guifont=PT\ Mono:h14
    endif
else
    " VIM in terminal
    set background=dark
    let g:solarized_termcolors=256
    set t_Co=256
endif

" colorscheme
colorscheme solarized

if has("autocmd")
    " jump to the last position when reopening a file
    au BufWinLeave ?* mkview
    au BufWinEnter ?* silent loadview

    " load indentation rules and plugins according to the detected filetype.
    filetype plugin indent on

    " source .vimrc file after saving it
    au BufWritePost $MYVIMRC source $MYVIMRC
endif

" general settings
set autoindent          " copy indent from current when when starting a new line
set autoread            " reload file if changed (only in GUI mode)
set autowrite           " auto-save buffer (e.g. when using :make)
set bs=indent,eol,start " using backspace to delete characters
if exists ("&colorcolumn")
    set colorcolumn=+1  " visualize textwidth with vertical bar
endif
set copyindent          " copy existing lines indent when autoindenting
set expandtab           " Expand TABs to spaces
set hlsearch            " highlight search results
set ignorecase          " Do case insensitive matching
set incsearch           " Incremental search
set lcs=tab:>-,trail:-  " strings to use in list mode
set list                " enable list mode
set mouse=a             " Enable mouse usage (all modes)
set noswapfile          " prevent vim from writing .swp files
set number              " show line numbers
set pastetoggle=<F2>    " disable autoindent when pasting content
set ruler               " show file stats in the bottom right corner
set shiftround          " use multiple of shiftwidth when indenting with '<'
set shiftwidth=4        " Indents will have a width of 4
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set smartcase           " Do smart case matching
set softtabstop=4       " Sets the number of columns for a TAB
set tabstop=4           " The width of a TAB is set to 4.
set textwidth=80        " wrap lines after 80 columns
set wildmenu
set wildmode=list:longest,full

" unhighlight search results
nnoremap <silent> <C-l> :nohl<CR><C-l>

" save a root file if you forgot to sudo in the first place
cmap w!! w !sudo tee >/dev/null %

" highlight last inserted text
nnoremap gV `[v`]

" toggle relative line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

