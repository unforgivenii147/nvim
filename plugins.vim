set nocompatible              
filetype off                  
call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
if index(argv(), ".") >= 0
    edit [NO NAME]
    bd 1
    autocmd VimEnter * NERDTree | wincmd w
endif
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mhinz/vim-startify'
Plug 'alpertuna/vim-header'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'kevinhwang91/rnvimr'
Plug 'szw/vim-maximizer'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf'
Plug 'puremourning/vimspector'
Plug 'majutsushi/tagbar'
Plug 'gilsondev/searchtasks.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/a.vim'
Plug 'vhdirk/vim-cmake'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'cdelledonne/vim-cmake'
Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'KeitaNakamura/neodark.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ap/vim-css-color'
Plug 'alvan/vim-closetag'
call plug#end()
filetype plugin indent on    
