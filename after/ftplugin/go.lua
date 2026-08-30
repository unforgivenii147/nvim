local utils = require("core.utils")
local opts = { silent = true }
-- test
utils.map("n", "<localleader>tf", "<cmd>GoTestFunc<CR>", opts)
utils.map("n", "<localleader>ts", "<cmd>GoTestFunc -s<CR>", opts)
utils.map("n", "<localleader>tF", "<cmd>GoTestFile<CR>", opts)
utils.map("n", "<localleader>tp", "<cmd>GoTestPkg<CR>", opts)
utils.map("n", "<localleader>taf", "<cmd>GoAddTest [-parallel]<CR>", opts)
utils.map("n", "<localleader>tae", "<cmd>GoAddExpTest [-parallel]<CR>", opts)
utils.map("n", "<localleader>taa", "<cmd>GoAddAllTest [-parallel]<CR>", opts)
-- tags
utils.map("n", "<localleader>Ta", "<cmd>GoAddTag<CR>", opts)
utils.map("n", "<localleader>Tr", "<cmd>GoRemoveTag<CR>", opts)
-- Comment
utils.map("n", "<localleader>c", "<cmd>GoCmt<CR>", opts)
-- binaries
utils.map("n", "<localleader>bi", "<cmd>GoInstallBinaries<CR>", opts)
utils.map("n", "<localleader>bu", "<cmd>GoUpdateBinaries<CR>", opts)
-- Fill
utils.map("n", "<localleader>fs", "<cmd>GoFillStruct<CR>", opts)
utils.map("n", "<localleader>fS", "<cmd>GoFillSwitch<CR>", opts)
utils.map("n", "<localleader>fe", "<cmd>GoIfErr<CR>", opts)
utils.map("n", "<localleader>fp", "<cmd>GoFixPlurals<CR>", opts)
local u = require("functions.utils")
-- Show codelenses on LSP client attach
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  pattern = "*.go",
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})
local function goimports()
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
  vim.lsp.buf.format({ async = false })
end
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    goimports()
  end,
  desc = "Run goimports on save in Golang files",
})
local function add_json_tag()
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  -- Extract the first word (field name)
  local field_name = u.get_first_word()
  if not field_name then
    print("Could not determine field name.")
    return
  end
  -- Convert field name to snake_case
  local json_key = u.pascal_to_snake_case(field_name)
  -- Append JSON tag
  local new_line = line:gsub("%s*$", "") .. string.format(' `json:"%s"`', json_key)
  -- Update line in buffer
  vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_line })
end
-- Go to the SQL query for the word under the cursor
local function go_to_query()
  local word = u.get_word_under_cursor()
  require("functions.search-word").go_to_word({
    word = word,
    filetype = "sql",
  })
end
vim.keymap.set("n", "<localleader>jt", add_json_tag, merge(local_keymap_opts, { desc = "Add JSON tag" }))
vim.keymap.set("n", "gq", go_to_query, merge(local_keymap_opts, { desc = "Go to SQL query" }))
-- Go formatting settings (follows Go community standards)
vim.opt_local.expandtab = false -- Use tabs (Go standard)
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "120"
vim.opt_local.textwidth = 120
-- Ensure whitespace characters are visible in Go files
vim.opt_local.list = true
vim.opt_local.listchars = {
  tab = "→ ",
  trail = "·",
  nbsp = "␣",
  extends = "⟩",
  precedes = "⟨",
}
-- Go-specific keymaps
-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)
-- Organize imports (gopls code action)
vim.keymap.set("n", "<leader>ri", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind and action.kind:match("source.organizeImports")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Organize imports" })
-- Run current test file
vim.keymap.set("n", "<leader>rt", function()
  vim.cmd("!go test -v ./...")
end, { buffer = true, desc = "Run tests" })
-- Run verbose tests for current directory
vim.keymap.set("n", "<leader>rvt", function()
  vim.cmd("!go test -v -race ./...")
end, { buffer = true, desc = "Run tests (verbose, race)" })
-- Run test coverage for current directory
vim.keymap.set("n", "<leader>rc", function()
  vim.cmd("!go test -cover ./...")
end, { buffer = true, desc = "Run test coverage" })
-- Run all tests in workspace
vim.keymap.set("n", "<leader>re", function()
  vim.cmd("!go test -v ./...")
end, { buffer = true, desc = "Run all tests" })
-- Run benchmark
vim.keymap.set("n", "<leader>rab", function()
  vim.cmd("!go test -bench=. -benchmem ./...")
end, { buffer = true, desc = "Run benchmark" })
-- Add struct tags helper (gopls code action)
vim.keymap.set("n", "<leader>rats", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind and action.kind:match("source.addMissingTag")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Add struct tags" })
