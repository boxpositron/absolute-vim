local cheatsheet = require("cheatsheet")

cheatsheet.setup({})


local opts = { noremap = true, silent = true }

opts.desc = "Show Cheatsheet"
vim.keymap.set("n", "<leader>\\", "<cmd>Cheatsheet<CR>", opts) -- toggle file explorer
