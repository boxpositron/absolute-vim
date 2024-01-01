require("bufferline").setup {
    options = {
        mode = "tabs",
        separator_style = "slant",
    }
}

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", opts)


-- I want to be to close the current tab with a single keypress
vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>tabclose<CR>", opts)

-- I want to be able to create a new tab with a single keypress
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>tabnew<CR>", opts)
