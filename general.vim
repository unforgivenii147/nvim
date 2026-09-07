set encoding=utf-8
syntax on
set number
set relativenumber
set ruler
set laststatus=2
set cursorline
set mouse=a 
set clipboard+=unnamedplus
set hlsearch 
set incsearch 
nnoremap <CR> :noh<CR><CR>
set splitbelow splitright
set backspace=indent,eol,start
set termbidi
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>
nmap <S-h> :vertical resize +5<CR>
nmap <S-l> :vertical resize -5<CR>
nmap <S-k> :resize -5<CR>
nmap <S-j> :resize +5<CR>
nmap <C-F> :RnvimrToggle <CR>
nmap <C-O> :MaximizerToggle<CR>
augroup cursorline
    autocmd!
    autocmd WinEnter,BufEnter * set cursorline
    autocmd WinLeave,BufLeave * set nocursorline
augroup END
augroup help_config
    autocmd!
    autocmd FileType help :set number
    autocmd FileType help :only
augroup END
