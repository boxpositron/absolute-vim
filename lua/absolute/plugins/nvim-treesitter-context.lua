return {
	enabled = true,
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("absolute.after.nvim-treesitter-context")
	end,
}
