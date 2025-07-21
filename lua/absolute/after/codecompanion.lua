local codecompanion = require("codecompanion")

codecompanion.setup({
	strategies = {
		chat = {
			adapter = "openai",
		},
	},
	extensions = {
		mcphub = {
			callback = "mcphub.extensions.codecompanion",
			opts = {
				make_vars = true,
				make_slash_commands = true,
				show_result_in_chat = true,
			},
		},
	},
})

local opts = {
	noremap = true,
	silent = true,
}

vim.keymap.set("n", "<leader>ac", function()
	vim.cmd("CodeCompanionChat")
end, opts)

vim.keymap.set({ "n", "v" }, "<leader>ai", function()
	local input = vim.fn.input("[Code Companion Inline]: ")
	local trimmed_input = vim.fn.trim(input)

	if trimmed_input == "" then
		vim.notify("No input provided for inline code companion", vim.log.levels.WARN)
		return
	end

	vim.cmd("CodeCompanion" .. " " .. vim.fn.shellescape(trimmed_input))
end, opts)
