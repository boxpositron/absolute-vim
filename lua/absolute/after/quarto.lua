local quarto = require("quarto")
local runner = require("quarto.runner")

quarto.setup({
	debug = false,
	ft = { "quarto", "markdown" },
	closePreviewOnExit = true,
	lspFeatures = {
		enabled = true,
		chunks = "curly",
		languages = { "r", "python", "julia", "bash", "html", "markdown" },

		diagnostics = {
			enabled = true,
			triggers = { "BufWritePost" },
		},
		completion = {
			enabled = true,
		},
	},
	codeRunner = {
		enabled = false,
		default_method = nil, -- 'molten' or 'slime'
		ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
		-- Takes precedence over `default_method`
		never_run = { "yaml" }, -- filetypes which are never sent to a code runner
	},
	keymap = {
		-- set whole section or individual keys to `false` to disable
		hover = "K",
		definition = "gd",
		type_definition = "gD",
		rename = "<leader>lR",
		format = "<leader>lf",
		references = "gr",
		document_symbols = "gS",
	},
})

local opts = { noremap = true, silent = true }

opts.desc = "Quarto: Preview"
vim.keymap.set("n", "<leader>qp", "<cmd>QuartoPreview<CR>", opts)

opts.desc = "Quarto: Run Cell"
vim.keymap.set("n", "<localleader>rc", runner.run_cell, opts)

opts.desc = "Quarto: Run Cell and Above"
vim.keymap.set("n", "<localleader>ra", runner.run_above, opts)

opts.desc = "Quarto: Run All Cells"
vim.keymap.set("n", "<localleader>rA", runner.run_all, opts)

opts.desc = "Quarto: Run Line"
vim.keymap.set("n", "<localleader>rl", runner.run_line, opts)

opts.desc = "Quarto: Run Range"
vim.keymap.set("v", "<localleader>r", runner.run_range, opts)

opts.desc = "Quarto: Run All"
vim.keymap.set("n", "<localleader>RA", function()
	runner.run_all(true)
end, opts)
