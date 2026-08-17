-- Project bootstrapping utilities

local M = {}

M.bootstrap_project = function()
  local categories = {
    {
      name = "  Python",
      items = {
        {
          name = "  Flask",
          cmd = "mkdir $project_name && cd $project_name && python3 -m venv venv && source venv/bin/activate.fish && pip install flask && echo \"from flask import Flask\\napp = Flask(__name__)\\n@app.route('/')\\ndef home():\\n    return 'Hello, Flask!'\\n\\nif __name__ == '__main__':\\n    app.run(debug=True)\" > app.py",
        },
        {
          name = "  Django",
          cmd = "mkdir $project_name && cd $project_name && python3 -m venv venv && source venv/bin/activate.fish && pip install django && python3 -m django startproject $project_name .",
        },
        { name = "  uv", cmd = "uv init $project_name" },
        { name = "  venv", cmd = "mkdir $project_name && cd $project_name && python3 -m venv venv" },
        { name = "  conda", cmd = "conda create -y -n $project_name python=3.12" },
        { name = "  plain", cmd = "mkdir $project_name && cd $project_name" },
      },
    },
  }

  -- Spawns background tasks cleanly without messing with active UI buffers
  local function run_in_terminal(dir, cmd, msg)
    vim.notify(msg or ("Running: " .. cmd), vim.log.levels.INFO)

    -- Using the system shell safely to execute the string sequence
    local shell = vim.o.shell
    local shellcmdflag = vim.o.shellcmdflag

    vim.fn.jobstart({ shell, shellcmdflag, string.format("cd %s && %s", vim.fn.shellescape(dir), cmd) }, {
      cwd = dir,
      on_exit = function(_, exit_code, _)
        if exit_code ~= 0 then
          vim.schedule(function()
            vim.notify("󰚌 Bootstrap command failed with exit code " .. exit_code, vim.log.levels.ERROR)
          end)
        end
      end,
    })
  end

  local function ask_git_init(path, framework)
    vim.ui.select({ "Yes", "No" }, { prompt = " Initialize a Git repository?" }, function(choice)
      if choice == "Yes" then
        if vim.fn.isdirectory(path) == 1 then
          local gi_map = {
            ["Flask"] = "python,flask",
            ["Django"] = "python,django",
            ["uv"] = "python",
            ["venv"] = "python",
            ["conda"] = "python",
            ["plain"] = "python",
          }

          local target = gi_map[framework] or ""
          local gi_cmd = ""
          if target ~= "" then
            gi_cmd =
              string.format("curl -sL https://www.toptal.com/developers/gitignore/api/%s > .gitignore && ", target)
          end

          local cmd = string.format(
            "cd %s && %sgit init -q && git add . && git commit -m 'Initial commit' >/dev/null 2>&1",
            path,
            gi_cmd
          )
          os.execute(cmd)
          vim.notify(" Initialized Git repository with .gitignore in " .. path, vim.log.levels.INFO)
        end
      end
    end)
  end

  local function wait_for_project_ready(path, framework, callback)
    local attempts = 0
    local max_attempts = 120
    local timer = vim.loop.new_timer()

    local markers = {
      ["Flask"] = "app.py",
      ["Django"] = "manage.py",
      ["uv"] = "pyproject.toml",
      ["venv"] = "venv",
      ["conda"] = "main.py",
      ["plain"] = "main.py",
    }

    local marker = markers[framework] or ""

    if timer ~= nil then
      timer:start(2000, 2000, function()
        attempts = attempts + 1
        local ready = false

        if marker ~= "" then
          ready = vim.fn.filereadable(path .. "/" .. marker) == 1
            or vim.fn.filereadable(path .. "/" .. marker .. ".kts") == 1
            or vim.fn.isdirectory(path .. "/" .. marker) == 1
        else
          ready = vim.fn.isdirectory(path) == 1
        end

        if ready then
          vim.schedule(function()
            vim.notify("  Project ready: " .. path, vim.log.levels.INFO)
            timer:stop()
            timer:close()
            callback(path)
          end)
        elseif attempts >= max_attempts then
          vim.schedule(function()
            vim.notify("  Timeout waiting for project to finish setup: " .. path, vim.log.levels.WARN)
          end)
          timer:stop()
          timer:close()
        end
      end)
    end
  end

  local function finalize_project(target_path, framework, project_name)
    wait_for_project_ready(target_path, framework, function(path)
      vim.cmd("cd " .. path)
      vim.notify("  Changed directory to " .. path, vim.log.levels.INFO)

      local main_files = {
        ["Flask"] = { "app.py" },
        ["Django"] = { "manage.py" },
        ["uv"] = { "src/" .. project_name .. "/__init__.py", "main.py", "src/main.py" },
        ["venv"] = { "main.py" },
        ["conda"] = { "main.py" },
        ["plain"] = { "main.py" },
      }

      local opened_file = false

      -- Look for target file
      local target_entry = nil
      local candidates = main_files[framework] or {}
      for _, rel_path in ipairs(candidates) do
        local full_path = path .. "/" .. rel_path
        if vim.fn.filereadable(full_path) == 1 then
          target_entry = full_path
          break
        end
      end

      -- Clear layouts / wipe any existing Alpha dashboards out before jumping to your code
      pcall(function()
        vim.cmd("only")
      end)

      if target_entry then
        vim.cmd("edit " .. vim.fn.fnameescape(target_entry))
        opened_file = true
      end

      if not opened_file then
        if pcall(require, "oil") then
          vim.cmd("Oil " .. path)
        elseif vim.fn.exists(":Neotree") == 2 then
          vim.cmd("Neotree " .. path)
        else
          vim.cmd("Explore " .. path)
        end
      end

      ask_git_init(path, framework)
    end)
  end

  local function choose_framework(category, dir, name, selected)
    local target_path = dir .. "/" .. name

    -- Python Custom Handling
    run_in_terminal(
      dir,
      selected.cmd:gsub("$project_name", name),
      string.format("  Creating Python project '%s' using %s...", name, selected.name)
    )
    finalize_project(target_path, selected.name, name)
  end

  vim.ui.select(
    vim.tbl_map(function(c)
      return c.name
    end, categories),
    { prompt = "Select a project category:" },
    function(category_choice)
      if not category_choice then
        return
      end
      local category = vim.tbl_filter(function(c)
        return c.name == category_choice
      end, categories)[1]
      if not category then
        return
      end

      local function pick_framework(selected)
        vim.ui.input({ prompt = "Project name:" }, function(name)
          if not name or name == "" then
            return
          end
          vim.ui.input({ prompt = "Target directory (default: cwd):", default = vim.fn.getcwd() }, function(dir)
            dir = (dir and dir ~= "") and dir or vim.fn.getcwd()
            choose_framework(category, dir, name, selected)
          end)
        end)
      end

      vim.ui.select(
        vim.tbl_map(function(f)
          return f.name
        end, category.items),
        { prompt = "Choose a framework to bootstrap:" },
        function(framework_choice)
          if not framework_choice then
            return
          end
          local selected = vim.tbl_filter(function(f)
            return f.name == framework_choice
          end, category.items)[1]
          if selected then
            pick_framework(selected)
          end
        end
      )
    end
  )
end

return M
