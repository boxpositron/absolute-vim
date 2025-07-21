return {
	"rcarriga/nvim-notify",
	lazy = false,
	priority = 1000,
	config = function()
		require("absolute.after.notify")
	end,
}
