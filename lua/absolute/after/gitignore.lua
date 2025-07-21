local gitignore = require("gitignore")
local GetProjectRoot = require("absolute.utils.get-git-root")

-- Keymaps

local opts = { noremap = true, silent = true }

opts.desc = "GitIgnore: Generate .gitignore"

vim.keymap.set("n", "<leader>gi", function()
    local path = GetProjectRoot()

    gitignore.generate(path)
end, opts)

-- Global Settings

vim.g.gitignore_nvim_overwrite = true
