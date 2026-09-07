setlocal foldmethod=indent 
set foldlevel=99 
nmap <space> za
let g:searchtasks_list=["TODO", "FIXME", "XXX", "HACK", "FIXME", "BUG"] 
nmap <C-T> :SearchTasks ./% <CR>
nmap nt :NERDTreeToggle<CR>
nmap tb :TagbarToggle<cr>
if has ("nvim")
    nmap <F4> :vsplit <BAR> term <CR>
    autocmd TermOpen * startinsert
else
    nmap <F4> :vertical term <CR>
endif
nmap <leader> <C-m> :make <BAR> copen<CR>
nmap <C-S> :StripWhitespace<CR>
