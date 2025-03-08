return {
	"echasnovski/mini.nvim",
	enabled = false,
	version = "*", -- Stable Version
	config = function()
		require("absolute.after.mini")
	end,
}
