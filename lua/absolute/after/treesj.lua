local tsj = require("treesj")

tsj.setup({
    use_default_keymaps = false,
    max_join_length = 1000,
})

local opts = { silent = true, noremap = true }

opts.desc = "Toggle Treesitter Join"

vim.keymap.set("n", "<leader>m", "<cmd>TSJToggle<CR>", opts)
