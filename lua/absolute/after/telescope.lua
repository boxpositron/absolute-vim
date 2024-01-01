local telescope = require("telescope")
local builtin = require('telescope.builtin')

telescope.setup {}

vim.keymap.set("n", '<leader>pf', builtin.find_files, { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", '<leader>pr', builtin.oldfiles, { desc = "Fuzzy find recent files" })
vim.keymap.set("n", '<C-p>', builtin.git_files, { desc = "Fuzzy find files in git in cwd" })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = "Find string under cursor in cwd" })
