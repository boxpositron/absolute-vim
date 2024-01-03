vim.g.poetv_executables = { "poetry", "pipenv" }
vim.g.poetv_auto_activate = 1
vim.g.poetv_set_environment = 1
vim.g.poetv_statusline_symbol = "🐍"


-- Keybindings

local opts = { noremap = true, silent = true }

-- Poetv: Activate Virtualenv
opts.desc = "Poetv: Activate virtualenv"
vim.keymap.set("n", "<leader>pva", "<cmd>PoetvActivate<CR>", opts)

-- Poetv: Deactivate Virtualenv
opts.desc = "Poetv: Deactivate virtualenv"
vim.keymap.set("n", "<leader>pvd", "<cmd>PoetvDeactivate<CR>", opts)
