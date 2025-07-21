local smear_cursor = require("smear_cursor")

smear_cursor.setup({
	stiffness = 0.5,
	trailing_stiffness = 0.49,
	never_draw_over_target = false,
	smear_insert_mode = false,
	smear_between_buffers = true,
	cursor_color = "#7DF9FF",
})
