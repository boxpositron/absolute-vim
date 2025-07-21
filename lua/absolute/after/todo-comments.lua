local todo_comments = require("todo-comments")

todo_comments.setup({})

local opts = { noremap = true, silent = true }

opts.desc = "Jump to previous comment"
vim.keymap.set("n", "[t", function()
    todo_comments.jump_prev()
end, opts)

opts.desc = "Jump to next todo comment"
vim.keymap.set("n", "]t", function()
    todo_comments.jump_next()
end, opts)

opts.desc = "Open Comments in Telescope"
vim.keymap.set("n", "<leader>pt", function()
    vim.cmd([[TodoTelescope]])
end, opts)

opts.desc = "Open Comments in Trouble"
vim.keymap.set("n", "<leader>tt", function()
    vim.cmd([[TodoTrouble]])
end, opts)
