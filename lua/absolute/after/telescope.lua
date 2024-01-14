local telescope = require("telescope")
local builtin = require("telescope.builtin")
local trouble = require("trouble.providers.telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-q>"] = trouble.open_with_trouble,
			},
			n = {
				["<C-q>"] = trouble.open_with_trouble,
			},
		},
	},
})

vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>pr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find files in git in cwd" })
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find string under cursor in cwd" })
