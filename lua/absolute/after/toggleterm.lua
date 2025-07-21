local toggle_term = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

toggle_term.setup({
	direction = "float",
})

local opts = { noremap = true, silent = true }

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		vim.cmd("startinsert!")
	end,
})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

-- Todo prompt model to run
local ollama = Terminal:new({
	cmd = "ollama run llama3",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		vim.cmd("startinsert!")
	end,
})

function _OLLAMA_TOGGLE()
	ollama:toggle()
end

opts.desc = "Open lazygit"
vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

opts.desc = "Open ollama"
vim.api.nvim_set_keymap("n", "<leader>ol", "<cmd>lua _OLLAMA_TOGGLE()<CR>", opts)

-- opts.desc = "Open a terminal"
-- vim.api.nvim_set_keymap("n", "<C-`>", "<cmd>ToggleTerm<CR>", opts)
