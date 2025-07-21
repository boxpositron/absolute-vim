local current_os = require("absolute.utils.detect-os")
local get_git_root = require("absolute.utils.get-git-root")

local os_name = current_os.detect()
local supported_os = current_os.supported

function Open_project_root()
	local project_root = get_git_root()

	if os_name == supported_os.MACOS then
		vim.fn.jobstart("open " .. project_root, { detach = true })
		return
	end

	if os_name == supported_os.UNIX then
		vim.fn.jobstart("xdg-open " .. project_root, { detach = true })
		return
	end

	if os_name == supported_os.WINDOWS then
		vim.fn.jobstart("explorer " .. project_root, { detach = true })
		return
	end
end

local opts = { noremap = true, silent = true }

opts.desc = "Open project root"

vim.api.nvim_set_keymap("n", "<leader>op", "<cmd>lua Open_project_root()<cr>", opts)
