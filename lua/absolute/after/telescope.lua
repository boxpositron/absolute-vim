local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")
local file_browser_actions = require("telescope._extensions.file_browser.actions")
local live_grep_shortcuts = require("telescope-live-grep-args.shortcuts")
local live_grep_actions = require("telescope-live-grep-args.actions")

local image_preview = require("absolute.utils.telescope_image_preview")

-- local function chafa_previewer_mime_hook(filepath, bufnr, opts)
-- 	local is_image = function(current_filepath)
-- 		local image_extensions = { "png", "jpg", "jpeg", "gif" } -- Supported image formats
-- 		local split_path = vim.split(current_filepath:lower(), ".", { plain = true })
-- 		local extension = split_path[#split_path]
-- 		return vim.tbl_contains(image_extensions, extension)
-- 	end
-- 	if is_image(filepath) then
-- 		local term = vim.api.nvim_open_term(bufnr, {})
-- 		local function send_output(_, data, _)
-- 			for _, d in ipairs(data) do
-- 				vim.api.nvim_chan_send(term, d .. "\r\n")
-- 			end
-- 		end
-- 		vim.fn.jobstart("chafa --passthrough tmux --exact-size off --format=symbols " .. filepath, {
-- 			on_stdout = send_output,
-- 			stdout_buffered = true,
-- 		})
-- 	else
-- 		require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
-- 	end
-- end

telescope.setup({
	defaults = {
		file_previewer = image_preview.file_previewer,
		buffer_previewer_maker = image_preview.buffer_previewer_maker,

		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--follow",
			"--hidden",
			"--glob=!.git/",
		},
		mappings = {
			i = {
				["<C-t>"] = trouble.open,
				["<C-q>"] = actions.send_to_qflist,
			},
			n = {
				["<C-t>"] = trouble.open,
				["<C-q>"] = actions.send_to_qflist,
			},
		},
	},
	extensions = {
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
			find_cmd = "rg",
		},
		live_grep_args = {
			auto_quoting = false,
			mappings = {
				i = {
					["C-space"] = live_grep_actions.to_fuzzy_refine,
				},
			},
		},

		file_browser = {
			hijack_netrw = true,
			hide_parent_dir = true,
			depth = 1,
			respect_gitignore = vim.fn.executable("fd") == 1,
			hidden = { file_browser = true, folder_browser = false },
			auto_depth = false,
			browse_files = require("telescope._extensions.file_browser.finders").browse_files,
			display_stat = {
				date = true,
				size = true,
				mode = false,
			},
			use_fd = true,
			git_status = true,
			mappings = {
				["i"] = {
					["<A-c>"] = file_browser_actions.create,
					["<S-CR>"] = file_browser_actions.create_from_prompt,
					["<A-r>"] = file_browser_actions.rename,
					["<A-m>"] = file_browser_actions.move,
					["<A-y>"] = file_browser_actions.copy,
					["<A-d>"] = file_browser_actions.remove,
					["<C-o>"] = file_browser_actions.open,
					["<C-g>"] = file_browser_actions.goto_parent_dir,
					["<C-e>"] = file_browser_actions.goto_home_dir,
					["<C-w>"] = file_browser_actions.goto_cwd,
					["<C-t>"] = file_browser_actions.change_cwd,
					["<C-f>"] = file_browser_actions.toggle_browser,
					["<C-h>"] = file_browser_actions.toggle_hidden,
					["<C-s>"] = file_browser_actions.toggle_all,
					["<bs>"] = file_browser_actions.backspace,
				},
				["n"] = {
					["c"] = file_browser_actions.create,
					["r"] = file_browser_actions.rename,
					["m"] = file_browser_actions.move,
					["y"] = file_browser_actions.copy,
					["d"] = file_browser_actions.remove,
					["o"] = file_browser_actions.open,
					["g"] = file_browser_actions.goto_parent_dir,
					["e"] = file_browser_actions.goto_home_dir,
					["w"] = file_browser_actions.goto_cwd,
					["t"] = file_browser_actions.change_cwd,
					["f"] = file_browser_actions.toggle_browser,
					["h"] = file_browser_actions.toggle_hidden,
					["s"] = file_browser_actions.toggle_all,
				},
			},
		},
	},
})

telescope.load_extension("live_grep_args")
telescope.load_extension("file_browser")
telescope.load_extension("media_files")
telescope.load_extension("themes")
telescope.load_extension("dap")

local find_files = function()
	builtin.find_files({
		find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
	})
end

local default_grep_files = function()
	local input = vim.fn.input("[Global Search]: ")
	local trimmed_input = vim.fn.trim(input)

	-- Check the length of the input

	local live_grep_args = telescope.extensions.live_grep_args
	-- If the input is empty open the search prompt

	if trimmed_input == "" then
		live_grep_args.live_grep_args()
		return
	end

	builtin.grep_string({ search = trimmed_input })
end

-- Function to get the visually selected text

-- Pipe the visual selection into Telescope find_files
local opts = { noremap = true, silent = true }

opts.desc = "Open file browser (cwd)"
vim.keymap.set("n", "<leader>pf", "<cmd>Telescope file_browser<CR>", opts)

opts.desc = "Open file browser (current file)"
vim.keymap.set("n", "<leader>cf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

opts.desc = "Fuzzy find files (cwd)"
vim.keymap.set("n", "<C-p>", find_files, opts)

opts.desc = "Fuzzy find recent files"
vim.keymap.set("n", "<leader>pr", builtin.oldfiles, opts)

opts.desc = "Fuzzy find files in git in cwd"
vim.keymap.set("n", "<leader>gf", builtin.git_files, opts)

opts.desc = "Fuzzy find files in cwd"
vim.keymap.set("n", "<leader>ps", default_grep_files, opts)

opts.desc = "Fuzzy find word under cursor in cwd"
vim.keymap.set("n", "<leader>sb", live_grep_shortcuts.grep_word_under_cursor, opts)
