local venvSelector = require("venv-selector")

venvSelector.setup({
	-- name = "venv",
	auto_refresh = false,
})

local opts = { noremap = true, silent = true }

opts.desc = "Open VenvSelector to pick a venv."
vim.api.nvim_set_keymap("n", "<leader>vs", "<cmd>VenvSelect<cr>", opts)

opts.desc = "Retrieve the venv from a cache."
vim.api.nvim_set_keymap("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", opts)
