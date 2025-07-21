return {
	"sudormrfbin/cheatsheet.nvim",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},
	config = function()
		require("absolute.after.cheatsheet")

	end,
}
