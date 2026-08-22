-- Keymaps for Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local opts = { buffer = true, noremap = true, silent = true }

    -- Format current buffer with ruff
    vim.keymap.set("n", "<leader>r", function()
      vim.lsp.buf.format({ name = "ruff" })
    end, opts)

    -- Optimize imports with ruff
    vim.keymap.set("n", "<leader>ri", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })
    end, opts)

    -- Check with ruff (fix + unsafe fixes)
    vim.keymap.set("n", "<leader>rc", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.fixAll" } },
        apply = true,
      })
    end, opts)
  end,
})
