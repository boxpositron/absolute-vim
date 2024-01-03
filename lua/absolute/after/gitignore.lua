local gitignore = require("gitignore")

function GetProjectRoot()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if git_root == nil then
        return vim.fn.getcwd()
    else
        return git_root
    end
end

-- Keymaps

local opts = { noremap = true, silent = true }

opts.desc = "Generate .gitignore"

vim.keymap.set("n", "<leader>gi", function()
    local path = GetProjectRoot()

    gitignore.generate(path)
end, opts)

-- Global Settings

vim.g.gitignore_nvim_overwrite = true
