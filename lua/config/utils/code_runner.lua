-- Code running utilities

local M = {}

M.run_code = function()
  local file_extension = vim.fn.expand("%:e")
  local term_cmd = "bot 10 new | term "

  -- Helper to search upwards for project build markers
  local function find_marker(marker)
    return vim.fs.find({ marker }, { upward = true, path = vim.fn.expand("%:p:h") })[1]
  end

  -- Handles Python framework execution with automatic virtual environment resolution
  local function run_python()
    local current_file = vim.fn.expand("%")
    local venv_markers = { ".venv", "venv" }
    local venv_path = nil

    for _, marker in ipairs(venv_markers) do
      local found = find_marker(marker)
      if found then
        venv_path = found
        break
      end
    end

    if venv_path then
      local project_root = vim.fs.dirname(venv_path)
      local python_bin = venv_path .. "/bin/python"
      vim.notify("  Using virtual environment: " .. venv_path, vim.log.levels.INFO)

      if find_marker("manage.py") then
        vim.cmd(
          string.format("%s cd %s && %s manage.py runserver", term_cmd, vim.fn.shellescape(project_root), python_bin)
        )
      elseif find_marker("app.py") or find_marker("main.py") then
        local entry = vim.fn.filereadable(project_root .. "/app.py") == 1 and "app.py" or "main.py"
        vim.cmd(string.format("%s cd %s && %s %s", term_cmd, vim.fn.shellescape(project_root), python_bin, entry))
      else
        vim.cmd(string.format("%s %s %s", term_cmd, python_bin, current_file))
      end
    else
      vim.cmd(term_cmd .. "python3 " .. current_file)
    end
  end

  -- Centralized Dispatch Registry Table
  local supported_filetypes = {
    py = {
      ["󰐊  Run Python Environment"] = function()
        run_python()
      end,
    },
  }

  if supported_filetypes[file_extension] then
    local choices = vim.tbl_keys(supported_filetypes[file_extension])

    local function execute_action(action)
      if type(action) == "function" then
        action()
      elseif type(action) == "string" then
        vim.cmd(term_cmd .. require("config.utils.substitute").command(action))
      end
    end

    if #choices == 0 then
      vim.notify("It doesn't contain any command", vim.log.levels.WARN, { title = "Code Runner" })
    elseif #choices == 1 then
      local selected_action = supported_filetypes[file_extension][choices[1]]
      execute_action(selected_action)
    else
      vim.ui.select(choices, { prompt = "Choose an action: " }, function(choice)
        if choice then
          local selected_action = supported_filetypes[file_extension][choice]
          execute_action(selected_action)
        end
      end)
    end
  else
    vim.notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = "Code Runner" })
  end
end

return M
