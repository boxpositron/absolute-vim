local map = require("mini.map")
require("mini.map").setup({
    integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic()
    },
})

vim.keymap.set("n", "<leader>mc", map.close)
vim.keymap.set("n", "<leader>mo", map.open)
