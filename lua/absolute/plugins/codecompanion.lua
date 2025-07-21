return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"ravitemer/mcphub.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("absolute.after.codecompanion")
	end,
}
