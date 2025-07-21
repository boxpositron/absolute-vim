return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-registry",
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("absolute.after.mason")
	end,
}
