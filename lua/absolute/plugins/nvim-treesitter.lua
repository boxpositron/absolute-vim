return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"OXY2DEV/markview.nvim",
	},
	config = function()
		vim.cmd([[:silent !TSUpdate]])
		require("absolute.after.nvim-treesitter")
	end,
}
