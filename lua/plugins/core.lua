return {
  { "tpope/vim-commentary", event = "VeryLazy" },
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-eunuch", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-sandwich", event = "VeryLazy" },
  { "tpope/vim-obsession", event = "VeryLazy" },
  { "tpope/vim-oscyank", event = "VeryLazy" },
  { "caksoylu/vim-highlighturl", event = "VeryLazy" },
  { "vim-scripts/unicode.vim", event = "VeryLazy" },
  { "tpope/vim-toml", ft = "toml" },
  { "ckolkey/vim-markdownfootnotes", ft = "markdown" },
  { "lukas-reineke/whitespace.nvim", config = function() require("whitespace-nvim").setup() end },
}
