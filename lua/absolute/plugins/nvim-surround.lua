return {
	"kylechui/nvim-surround",
	enabled = false,
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("absolute.after.nvim-surround")
	end,
}
