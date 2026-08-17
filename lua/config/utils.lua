-- NOTE: Utilities - Main module that imports and re-exports from modular files
local M = {}

local substitute = require("config.utils.substitute")
local project_bootstrap = require("config.utils.project_bootstrap")
local code_runner = require("config.utils.code_runner")
local theme_picker = require("config.utils.theme_picker")

M.substitute = substitute.command
M.bootstrap_project = project_bootstrap.bootstrap_project
M.run_code = code_runner.run_code
M.theme_picker = theme_picker

return M
