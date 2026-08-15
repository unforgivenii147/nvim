-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Build base capabilities, prefer blink's augmentation if available
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink_lsp = pcall(require, "blink.lsp")
      if ok and blink_lsp and type(blink_lsp.update_capabilities) == "function" then
        capabilities = blink_lsp.update_capabilities(capabilities)
      else
        vim.notify("blink.lsp not available; using default LSP capabilities", vim.log.levels.WARN)
      end

      -- Common on_attach pattern: set keymaps or buffer-local features
      local function on_attach(client, bufnr)
        -- disable server formatting if using null-ls (ruff)
        if client.server_capabilities then client.server_capabilities.documentFormattingProvider = false end
        -- buffer-local LSP mappings could go here (like vim.lsp.buf.hover, etc.)
      end

      -- Pyright
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },
}
