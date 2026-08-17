## :construction: Install CodeArt easily
**_please backup any existing configuration files_**
🐧🍎 On linux and macOS:
```bash
git clone https://github.com/artart222/CodeArt ~/.config/nvim
chmod +x ~/.config/nvim/installer/linux-mac.sh
exec ~/.config/nvim/installer/linux-mac.sh
```
**_If you have debian, after the instalation finished you must [add debian testing repos](https://serverfault.com/a/550856) and after that run_**:
```bash
sudo apt update; sudo apt install neovim
```
**_Requires Neovim 0.12+ and [`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter/tree/master/crates/cli) ≥ 0.26.1 (install via your OS package manager, e.g. `brew install tree-sitter-cli` — not npm). After installation, open Neovim and run `:Lazy sync`, then reopen Neovim. Upgrade Neovim with your OS package manager if needed — CodeArt will refuse to load on older versions._**
#### 🌲💺Σ🖥️ Install lsp and treesitter:
- You can install lsp for a language with `:LspInstall <language>`
- Install treesitter parsers with `:TSInstall <language>`, or set `config.treesitter.ensure_installed` in `user_settings.lua`. Update with `:TSUpdate`.
#### These NeoVim configurations use many nerd fonts icons. JetBrains Mono will be installed by default. If you have problem for fonts and see weird icons you must change your terminal font.
- Run `:MasonUpdate` and `:TSUpdate` if needed
- Restart NeoVim
If CodeArt reports that your Neovim is too old after an update, upgrade Neovim first, then reopen the editor.
## :sparkles: Features:
- 😴 Lazy load plugins!. With lazy loading NeoVim starts up very fast. It took me around 20 miliseconds on a virtual machine with 4GB ram and 2 Cores
  ![LazyLoad](/utils/media/LazyLoad.png "LazyLoad")
- Σ🖥️ Native LSP code completion support with documentation
  ![CodeCompletion](/utils/media/CodeCompletion.png "CodeCompletion")
- 🌲💺 [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) based code highlighting
  ![Treesitter](/utils/media/Treesitter.png "Treesitter")
- 🌳:card_file_box: [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) as file tree
  ![FileTree](/utils/media/FileTree.png "FileTree")
- 🚏🚌 [ToggleTerm](https://github.com/akinsho/toggleterm.nvim) as built in terminal
  ![Terminal](/utils/media/Terminal.png "Terminal")
- 🔭 [Fuzzy finder](https://github.com/nvim-telescope/telescope.nvim)
  ![Telescope](/utils/media/Telescope.png "Telescope")
- :white_check_mark: [TODO viewer](https://github.com/folke/todo-comments.nvim)
  ![TODO1](/utils/media/TODO.png "TODO")
  ![TODO2](/utils/media/TODO2.png "TODO2")
- :bookmark: [Symbol outline](https://github.com/hedyhli/outline.nvim)
  ![TagViewer](/utils/media/TagViewer.png "TagViewer")
- 🤔🔑 [Whichkey](https://github.com/folke/which-key.nvim)
  ![Wichkey](/utils/media/Wichkey.png "Wichkey")
- ┇ [Status line](https://github.com/nvim-lualine/lualine.nvim) with git and lsp indicator + File manager and [bufferline](https://github.com/akinsho/nvim-bufferline.lua) lsp indicator
  ![StatusLine](/utils/media/StatusLine.png "StatusLine")
