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
    set background=dark

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
nnoremap <S-tab> :tabprevious<CR>
nnoremap <C-tab> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab> <Esc>:tabnext<CR>i
inoremap <C-t> <Esc>:tabnew<CR>

" unhighlight search results
nnoremap <silent> <C-l> :nohl<CR><C-l>

" save a root file if you forgot to sudo in the first place
cmap w!! w !sudo tee >/dev/null %

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" general settings
set autoindent
set autoread        " reload file if changed (only in GUI mode)
set autowrite       " auto-save buffer (e.g. when using :make)
set copyindent
set hlsearch        " highlight search results
set ignorecase      " Do case insensitive matching
set incsearch       " Incremental search
set mouse=a         " Enable mouse usage (all modes)
set noswapfile      " prevent vim from writing .swp files
set number          " show line numbers
set ruler           " show file stats in the bottom right corner
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set smartcase       " Do smart case matching

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

" adding extensions to syntax highlighting
au BufNewFile,BufRead *.fi set filetype=fortran
