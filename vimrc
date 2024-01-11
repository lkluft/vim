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

" load bundles (pathogen)
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
Helptags

" general settings
set autochdir               " change working directory to location of current file
set autoindent              " copy indent from current when starting a new line
set autoread                " reload file if changed (only in GUI mode)
set autowrite               " auto-save buffer (e.g. when using :make)
set bs=indent,eol,start     " using backspace to delete characters
set cb=unnamed              " yank/delete to system clipboard
set colorcolumn=+1          " indicate textwidth
set copyindent              " copy existing lines indent when autoindenting
set expandtab               " expand TABs to spaces
set foldlevel=99            " do not fold anything when opening a file
set foldmethod=indent       " use indented blocks to recognize fold ranges
set hidden                  " hide buffers instead of closing them
set history=500             " history size
set hlsearch                " highlight search results
set incsearch               " incremental search
set lcs=tab:>-,trail:-      " strings to use in list mode
set list                    " enable list mode
set mouse=a                 " enable mouse usage (all modes)
set nobackup                " prevent vim from writing backup files
set noswapfile              " prevent vim from writing .swp files
set number                  " show line numbers
set paste                   " disable autoindent when pasting content
set ruler                   " show file stats in the bottom right corner
set scrolloff=5             " show lines around cursor position
set shiftround              " use multiple of shiftwidth when indenting with '<'
set shiftwidth=4            " indents will have a width of 4
set showcmd                 " show (partial) command in status line.
set showmatch               " show matching brackets.
set smartcase               " do smart case matching
set softtabstop=4           " sets the number of columns for a TAB
set splitbelow              " open new horizontal split panes below
set splitright              " open new vertical split panels right
set tabstop=4               " the width of a TAB is set to 4.
set tags=tags;              " search parent directories for tags file
set virtualedit=onemore     " allow for cursor behind last character
setglobal commentstring=#\ %s   " commentstring for undetected filetypes

" enable syntax highlighting
if has("syntax")
    syntax on
    syntax enable
    colorscheme Monokai
endif

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

if has("autocmd")
    " jump to the last position when reopening a file
    au BufWinLeave ?* mkview
    au BufWinEnter ?* silent loadview

    " load indentation rules and plugins according to the detected filetype.
    filetype plugin indent on

    " equal window sizes after resizing vim
    au VimResized * wincmd =

    " use autopep8 to correct python files.
    au FileType python setlocal formatprg=autopep8\ -

    " set textwidth (72) and tabstop (8) for commits.
    au FileType changelog,gitcommit,svn setlocal tw=72 ts=8 sw=8

    " source .vimrc file after saving it
    au BufWritePost $MYVIMRC source $MYVIMRC
endif

" unhighlight search results
nnoremap <silent> ,/ :nohl<CR>

" save a root file if you forgot to sudo in the first place
cmap w!! w !sudo tee >/dev/null %

" highlight last inserted text
nnoremap gV `[v`]

" yank from cursor to the end of the line
nnoremap Y y$

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" re-format Python block comments (72 column widths following PEP8)
nnoremap gqb :set textwidth=72<CR>vipgq :set textwidth=79<CR>

" undo all changes since last file write
noremap <silent> <S-U> :earlier 1f<CR>

" insert timestamp in ChangeLog format
noremap <F3> O<C-R>=strftime("%Y-%m-%d  Lukas Kluft  <lukas.kluft@gmail.com>")<CR><Esc>j0

" map jk to Escape
inoremap jk <Esc>

" easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" variables used by file templates
let g:user = 'Lukas Kluft'
let g:email = 'lukas.kluft@gmail.com'
let g:templates_directory = '~/.vim/templates'

" toggle all foldings
function! FoldToggle()
    if &foldlevel == 99
        set foldlevel=0
    else
        set foldlevel=99
    endif
endfunction
nnoremap <silent> zz :call FoldToggle()<CR>
