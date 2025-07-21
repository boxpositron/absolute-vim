return {
	"linux-cultist/venv-selector.nvim",
	lazy = false,
	branch = "regexp", -- This is the regexp branch, use this for the new version
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		require("absolute.after.venv-selector")
	end,
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
}
