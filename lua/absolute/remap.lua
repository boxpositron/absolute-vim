vim.g.mapleader = " "

vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<CR>") -- toggle file explorer

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])


-- Alternate Escape (Easy to Reach)
vim.keymap.set("i", "<C-c>", "<Esc>")


-- Disable Q - Nothing Good Ever Happens
vim.keymap.set("n", "Q", "<nop>")

-- Format document with LSP Formatter
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Navigation Quick Fixes

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


-- Search Regex Keymap
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- Source File Keymap
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Manage VIM Maximizer
vim.keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>")
