local M = {}

function M.detect(path)
	path = path or vim.api.nvim_buf_get_name(0)
	if path == "" then
		return vim.fn.getcwd()
	end
	local dir = vim.fs.dirname(vim.fn.fnamemodify(path, ":p"))
	local found = vim.fs.find(".git", { path = dir, upward = true, type = "file" })
	if found[1] then
		return vim.fs.dirname(found[1])
	end
	found = vim.fs.find(".git", { path = dir, upward = true, type = "directory" })
	if found[1] then
		return vim.fs.dirname(found[1])
	end
	return vim.fn.getcwd()
end

function M.root()
	local cwd = vim.fn.getcwd()
	local git_dir = cwd .. "/.git"
	local stat = vim.uv.fs_stat(git_dir)
	if stat and stat.type == "directory" then
		local wt = vim.uv.fs_stat(git_dir .. "/worktrees")
		if wt and wt.type == "directory" then
			return cwd
		end
	end
	local ws = M.detect()
	local gitlink = ws .. "/.git"
	stat = vim.uv.fs_stat(gitlink)
	if stat and stat.type == "file" then
		local line = vim.fn.readfile(gitlink, "", 1)[1] or ""
		local gitdir = line:match("^gitdir: (.+)$")
		if gitdir then
			return vim.fn.fnamemodify(gitdir, ":h:h:h")
		end
	end
	return cwd
end

function M.list(root_dir)
	root_dir = root_dir or M.root()
	local items = {}
	local handle = vim.uv.fs_scandir(root_dir)
	if not handle then
		return items
	end
	while true do
		local name, ftype = vim.uv.fs_scandir_next(handle)
		if not name then
			break
		end
		if ftype == "directory" and name:sub(1, 1) ~= "." then
			local git = root_dir .. "/" .. name .. "/.git"
			local s = vim.uv.fs_stat(git)
			if s and s.type == "file" then
				items[#items + 1] = { text = name, file = root_dir .. "/" .. name }
			end
		end
	end
	table.sort(items, function(a, b)
		return a.text < b.text
	end)
	return items
end

return M
