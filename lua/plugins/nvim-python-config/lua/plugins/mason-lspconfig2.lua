#!/usr/bin/env bash
set -e
OUTDIR="nvim-python-config"
rm -rf "$OUTDIR"
mkdir -p "$OUTDIR/lua/core"
mkdir -p "$OUTDIR/lua/plugins"

# write files
cat > "$OUTDIR/init.lua" <<'EOF'
require("core.lazy-setup")
require("core.options")
require("core.keymaps")
EOF

cat > "$OUTDIR/lua/core/lazy-setup.lua" <<'EOF'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true, version = false },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
})
EOF

cat > "$OUTDIR/lua/core/options.lua" <<'EOF'
local o = vim.opt

o.number = true
o.relativenumber = true
o.termguicolors = true
o.cursorline = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.smartindent = true
o.wrap = false
o.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath("config") .. "/undo"
o.undofile = true
o.signcolumn = "yes"
o.clipboard = "unnamedplus"
EOF

cat > "$OUTDIR/lua/core/keymaps.lua" <<'EOF'
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>fs", ":Format<CR>", opts)

map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)

map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

map("i", "<C-Space>", "cmp#complete()", { expr = true, noremap = true })

map("n", "<leader>r", ":w<CR>:!python %<CR>", opts)
map("n", "<leader>t", ":w<CR>:lua require('dap-python').test_method()<CR>", opts)
map("n", "<leader>T", ":w<CR>:lua require('dap-python').test_class()<CR>", opts)
map("n", "<leader>tp", ":w<CR>:!pytest -q %:p<CR>", opts)
EOF

cat > "$OUTDIR/lua/plugins/init.lua" <<'EOF'
return {
  require("plugins.mason"),
  require("plugins.mason-lspconfig"),
  require("plugins.nvim-lspconfig"),
  require("plugins.cmp"),
  require("plugins.treesitter"),
  require("plugins.null-ls"),
  require("plugins.indent-blankline"),
  require("plugins.telescope"),
  require("plugins.dap"),
  require("plugins.nvim-dap-python"),
}
EOF

# plugin files (mason, mason-lspconfig, nvim-lspconfig, cmp, treesitter, null-ls, indent-blankline, telescope, dap, nvim-dap-python)
cat > "$OUTDIR/lua/plugins/mason.lua" <<'EOF'
return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  config = function()
    require("mason").setup()
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/mason-lspconfig.lua" <<'EOF'
return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright", "ruff_lsp" },
    })
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/nvim-lspconfig.lua" <<'EOF'
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end

    lspconfig.pyright.setup({
      on_attach = on_attach,
      settings = {
        python = {
          analysis = { typeCheckingMode = "off" },
        },
      },
    })

    pcall(function() lspconfig.ruff_lsp.setup({ on_attach = on_attach }) end)
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/cmp.lua" <<'EOF'
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
      snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" },
      }),
    })
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/treesitter.lua" <<'EOF'
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "lua", "json" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/null-ls.lua" <<'EOF'
return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
      sources = {
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.isort,
        diagnostics.ruff.with({ extra_args = { "--select", "E,F,W" } }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", { clear = false }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/indent-blankline.lua" <<'EOF'
return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("ibl").setup({
      indent = { char = "│" },
      scope = { enabled = false },
      exclude = { filetypes = { "help", "packer" } },
    })
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/telescope.lua" <<'EOF'
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({})
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/dap.lua" <<'EOF'
return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return "python"
        end,
      },
    }
  end,
}
EOF

cat > "$OUTDIR/lua/plugins/nvim-dap-python.lua" <<'EOF'
return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-python").setup("python")
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    map("n", "<F5>", require("dap").continue, opts)
    map("n", "<F9>", require("dap").toggle_breakpoint, opts)
    map("n", "<F10>", require("dap").step_over, opts)
    map("n", "<F11>", require("dap").step_into, opts)
  end,
}
EOF

# make zip
zip -r "${OUTDIR}.zip" "$OUTDIR"
echo "Created ${OUTDIR}.zip"