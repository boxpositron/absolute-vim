require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"rust",
		"javascript",
		"typescript",
		"python",
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown_inline",
		"markdown",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	textobjects = {
		move = {
			enable = true,
			set_jumps = false, -- you can change this if you want.
			goto_next_start = {
				--- ... other keymaps
				["]b"] = { query = "@code_cell.inner", desc = "next code block" },
			},
			goto_previous_start = {
				--- ... other keymaps
				["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
			},
		},
		select = {
			enable = true,
			lookahead = true, -- you can change this if you want
			keymaps = {
				--- ... other keymaps
				["ib"] = { query = "@code_cell.inner", desc = "in block" },
				["ab"] = { query = "@code_cell.outer", desc = "around block" },
			},
		},
		swap = { -- Swap only works with code blocks that are under the same
			-- markdown header
			enable = true,
			swap_next = {
				--- ... other keymap
				["<leader>sbl"] = "@code_cell.outer",
			},
			swap_previous = {
				--- ... other keymap
				["<leader>sbh"] = "@code_cell.outer",
			},
		},
	},
})
