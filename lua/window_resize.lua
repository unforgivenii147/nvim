-- window_resize.lua

local M = {}

-- Helper: check if we can move in a direction
local function can_move(direction)
    local oldw = vim.fn.winnr()
    vim.cmd("silent! wincmd " .. direction)
    local neww = vim.fn.winnr()
    vim.cmd(oldw .. "wincmd w")  -- return to original window
    return oldw == neww
end

-- Direction checks
function M.is_right_most()
    return can_move("l")
end

function M.is_bottom_most()
    return can_move("j")
end

function M.is_top_most()
    return can_move("k")
end

function M.is_left_most()
    return can_move("h")
end

-- Resize functions
function M.resize_up(n)
    local count = n or 1
    if M.is_bottom_most() then
        if M.is_top_most() then
            vim.cmd("silent! " .. count .. "wincmd -")
        else
            vim.cmd("silent! " .. count .. "wincmd +")
        end
    else
        vim.cmd("silent! " .. count .. "wincmd -")
    end
end

function M.resize_down(n)
    local count = n or 1
    if M.is_bottom_most() then
        if M.is_top_most() then
            vim.cmd("silent! " .. count .. "wincmd +")
        else
            vim.cmd("silent! " .. count .. "wincmd -")
        end
    else
        vim.cmd("silent! " .. count .. "wincmd +")
    end
end

function M.resize_left(n)
    local count = n or 1
    if M.is_right_most() then
        if not M.is_left_most() then
            vim.cmd("silent! " .. count .. "wincmd >")
        end
    else
        vim.cmd("silent! " .. count .. "wincmd <")
    end
end

function M.resize_right(n)
    local count = n or 1
    if M.is_right_most() then
        if not M.is_left_most() then
            vim.cmd("silent! " .. count .. "wincmd <")
        end
    else
        vim.cmd("silent! " .. count .. "wincmd >")
    end
end

return M
