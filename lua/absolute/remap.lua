local opts = { noremap = true, silent = true }

opts.desc = "Show Cheatsheet"
vim.keymap.set("n", "<leader>\\", "<cmd>Cheatsheet<CR>", opts) -- toggle file explorer

opts.desc = "Show Keymap"
vim.keymap.set("n", "<leader>?", "<cmd>Telescope keymaps<CR>", opts) -- toggle file explorer

opts.desc = "Select All"
vim.keymap.set("n", "<C-a>", "gg0vG$", opts) -- select all

-- Move selected line / block of text in visual mode up
opts.desc = "Move selected line / block of text in visual mode up"
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)

-- Move selected line / block of text in visual mode down
opts.desc = "Move selected line / block of text in visual mode down"
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Join current line with the line below it
opts.desc = "Join current line with the line below it"
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Move half page down
opts.desc = "Move half page down"
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)

-- Move half page up
opts.desc = "Move half page up"
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Navigate to next search result, center screen and expand folded text
opts.desc = "Navigate to next search result, center screen and expand folded text"
vim.keymap.set("n", "n", "nzzzv", opts)

-- Navigate to previous search result, center screen and expand folded text,
opts.desc = "Navigate to previous search result, center screen and expand folded text"
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Delete selected text and paste from register
opts.desc = "Delete selected text and paste from register"
vim.keymap.set("x", "<leader>p", [["_dP]], opts)

-- Copy selected text into system clipboard
opts.desc = "Copy selected text into system clipboard"
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)

-- Copy current line into system clipboard
opts.desc = "Copy current line into system clipboard"
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- Delete (blackhole)
opts.desc = "Delete current line (blackhole)"
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Alternate Escape (Easy to Reach)
opts.desc = "Alternate Escape (Easy to Reach)"
vim.keymap.set("i", "<C-c>", "<Esc>", opts)

-- Disable Q - Nothing Good Ever Happens
-- Q is normally used to enable Ex mode. We dont want that
opts.desc = "Disable Q - Nothing Good Ever Happens"
vim.keymap.set("n", "Q", "<nop>", opts)

-- Navigation Quick Fixes
--
opts.desc = "Jump up and center screen"
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", opts)

opts.desc = "Jump down and center screen"
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", opts)

opts.desc = "Jump to next location and center screen"
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", opts)

opts.desc = "Jump to previous location and center screen"
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", opts)


-- Search Regex Keymap
opts.desc = "Regex Replace"
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

opts.desc = "Replace selected text"
vim.keymap.set("v", "<leader>ss", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Source File Keymap
opts.desc = "Source File"
vim.keymap.set("n", "<leader><leader>", function()
    -- Only source these file extensions
    local allowed_extensions = [[".vim", ".lua", ".vimrc", ".gvimrc", ".nvim", ".nvimrc", ".sh"]]

    -- Get the file extension
    local file_extension = vim.fn.expand("%:e")

    -- Check if the file extension is allowed
    if string.find(allowed_extensions, file_extension) then
        vim.cmd("so %")
    else
        print("Filetype not supported")
    end
end, opts)

-- Manage VIM Maximizer
opts.desc = "Toggle TMUX Pane"
vim.keymap.set("n", "<leader>`", "<cmd>NvimTreeToggle<CR>", opts)


-- Optimize Window Resize

-- Resize Window Right
opts.desc = "Resize Window Right"
vim.keymap.set("n", "<leader>l", "<C-w>10>", opts)

-- Resize Window Left
opts.desc = "Resize Window Left"
vim.keymap.set("n", "<leader>h", "<C-w>10<", opts)

-- Resize Window Up
opts.desc = "Resize Window Up"
vim.keymap.set("n", "<leader>k", "<C-w>10-", opts)

-- Resize Window Down
opts.desc = "Resize Window Down"
vim.keymap.set("n", "<leader>j", "<C-w>10+", opts)
