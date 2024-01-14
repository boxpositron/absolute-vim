return {
	"kevinhwang91/nvim-bqf",
    event="VeryLazy",
    dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"junegunn/fzf",
	},
	config = function()
		require("absolute.after.nvim-bqf")
	end,
}
