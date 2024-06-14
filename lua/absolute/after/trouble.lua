local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble_sources = require("trouble.sources.telescope")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-t>"] = trouble_sources.open,
                ["<C-q>"] = actions.send_to_qflist,
            },
            n = {
                ["<C-t>"] = trouble_sources.open,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
})

-- Keybindings
local opts = { noremap = true, silent = true }

opts.desc = "Trouble: Open Document Diagnostics"
vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", opts)

opts.desc = "Trouble: Open Workspace Diagnostics"
vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)

opts.desc = "Trouble: Open Quickfix List"
vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<CR>", opts)
