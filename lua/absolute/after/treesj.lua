local tsj = require("treesj")

tsj.setup({
    use_default_keymaps = false,
})

local opts = {}

opts.desc = "Toggle Treesitter Join"

vim.keymap.set("n", "<leader>m", "<cmd>TSJToggle<CR>", opts)
