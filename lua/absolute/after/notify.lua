local notify = require("notify")

notify.setup({
	background_colour = "#000000",
	fps = 15,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	render = "default",
	stages = "static",
	time_formats = {
		notification = "%T",
		notification_history = "%FT%T",
	},
	timeout = 3000,
	top_down = true,
})

vim.notify = notify
