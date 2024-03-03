local silicon = require("silicon")
local current_os = require("absolute.utils.detect-os")
local get_git_root = require("absolute.utils.get-git-root")

local os_name = current_os.detect()
local supported_os = current_os.supported

local function generate_file_name()
	-- Generate a file name
	local file_name = os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"

	-- Project root
	local project_root = get_git_root()

	-- Create screenshots directory if it doesn't exist in the local directory
	local screenshot_dir = project_root .. "/Screenshots"
	if vim.fn.isdirectory(screenshot_dir) == 0 then
		vim.fn.mkdir(screenshot_dir, "p")
	end

	-- Return the full path to the file
	return screenshot_dir .. "/" .. file_name
end

function Open_local_screenshot_folder()
	local project_root = get_git_root()
	local screenshot_dir = project_root .. "/Screenshots"

	if os_name == supported_os.MACOS then
		vim.fn.jobstart("open " .. screenshot_dir, { detach = true })
		return
	end

	if os_name == supported_os.UNIX then
		vim.fn.jobstart("xdg-open " .. screenshot_dir, { detach = true })
		return
	end

	if os_name == supported_os.WINDOWS then
		vim.fn.jobstart("explorer " .. screenshot_dir, { detach = true })
		return
	end
end

-- Keymaps
local opts = { noremap = true, silent = true }

opts.desc = "Silicon: Create screenshot of highlighted code"
vim.api.nvim_set_keymap("v", "<leader>sc", ":'<,'>Silicon<CR>", opts)

opts.desc = "Silicon: Open screenshots directory"
vim.api.nvim_set_keymap("n", "<leader>so", "<cmd>lua Open_local_screenshot_folder()<cr>", opts)

silicon.setup({
	font = "JetBrains Mono=34;Noto Emoji",
	output = generate_file_name,
})
