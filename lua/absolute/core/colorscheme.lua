local function SetupWindowPreferences()
	-- Utility function to get the blend value or set a default
	local function get_blend_value(group_name, default_blend)
		-- Retrieve highlight settings for the group using the new API
		local current_highlight = vim.api.nvim_get_hl(0, { name = group_name })
		return current_highlight.blend or default_blend
	end

	-- Set the Normal group with dynamic blend
	local normal_blend = get_blend_value("Normal", 0)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none", blend = normal_blend })

	-- Set the NormalFloat group with dynamic blend
	local normal_float_blend = get_blend_value("NormalFloat", 0)
	vim.api.nvim_set_hl(1, "NormalFloat", { bg = "none", blend = normal_float_blend })

	-- Set the NormalNC group with dynamic blend
	local normal_nc_blend = get_blend_value("NormalNC", 0)
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", blend = normal_nc_blend })
end

local function SyncWezTerm()
	local colorschemes = {
		["tokyonight-day"] = "Tokyo Night Day",
		["tokyonight-night"] = "Tokyo Night Night",
		["tokyonight-storm"] = "Tokyo Night Storm",
		["tokynight-moon"] = "Tokyo Night Moon",
		["catppuccin-frappe"] = "Catppuccin Frappe",
		["catppuccin-latte"] = "Catppuccin Latte",
		["catppuccin-macchiato"] = "Catppuccin Macchiato",
		["catppuccin-mocha"] = "Catppuccin Mocha",
	}

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true }),
		callback = function(args)
			SetupWindowPreferences()

			local colorscheme = colorschemes[args.match]
			if not colorscheme then
				return
			end

			-- if the file does not exists, exit early
			local filename = vim.fn.expand("$XDG_CONFIG_HOME/wezterm/colorscheme")
			if not vim.fn.filereadable(filename) then
				return
			end

			-- Write the colorscheme to a file
			assert(type(filename) == "string")

			local file = io.open(filename, "w")

			assert(file)

			file:write(colorscheme)
			file:close()
			-- vim.notify("Setting WezTerm color scheme to " .. colorscheme, vim.log.levels.INFO)
		end,
	})
end

local function SyncGhostyTerm()
	vim.api.nvim_create_user_command("SendCmdShiftComma", function()
		os.execute(
			'osascript -e \'tell application "System Events" to keystroke "," using {command down, shift down}\''
		)
	end, {})

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("ghostty_colorscheme", { clear = true }),
		callback = function(args)
			SetupWindowPreferences()

			local notifyOpts = { title = "Set Ghostty Theme" }

			-- if the file does not exists, exit early

			local filename = vim.fn.expand("$XDG_CONFIG_HOME/ghostty/colorscheme")
			if not vim.fn.filereadable(filename) then
				vim.notify("Ghostty colorscheme file not found", vim.log.levels.ERROR, notifyOpts)
				return
			end

			-- lets check if ghostty supports the theme
			-- ghostty +list-themes | xargs -I {} echo {} | grep <theme>

			local cmd = "ghostty +list-themes | sed 's/ (resources)//g' | grep '^" .. args.match .. "$'"

			local status = vim.fn.system(cmd)
			local trimmed_output = vim.fn.substitute(status, "^s+|s+$", "", "g")
			-- check if status is empty

			if trimmed_output == "" then
				vim.notify(args.match .. " is not supported by Ghostty", vim.log.levels.ERROR, notifyOpts)
				return
			end

			assert(type(filename) == "string")

			local file = io.open(filename, "w")

			assert(file)

			local theme_string = 'theme = "' .. args.match .. '"'

			file:write(theme_string)
			file:close()

			vim.cmd([[SendCmdShiftComma]])

			-- send a key combination to reload the theme
			-- cmd + shift + ,
			-- vim.api.nvim_feedkeys("<Cmd-Shift-,>", "n", true)
		end,
	})
end

local function is_wezterm()
	return os.getenv("TERM_PROGRAM") == "WezTerm"
		or os.getenv("WEZTERM_EXECUTABLE") ~= nil
		or vim.fn.executable("wezterm") == 1
end

local function is_ghostty()
	return os.getenv("TERM_PROGRAM") == "Ghostty"
		or os.getenv("GHOSTTY_EXECUTABLE") ~= nil
		or vim.fn.executable("ghostty") == 1
end

local function SetupAutocommands()
	-- Setup Autocommand if wezterm is available in the system
	if is_wezterm() then
		SyncWezTerm()
	end

	-- Setup Autommand if the terminal is Ghostty
	if is_ghostty() then
		SyncGhostyTerm()
	end
end

SetupWindowPreferences()
SetupAutocommands()

local opts = { noremap = true, silent = true }

opts.desc = "Fuzzy find colorschemes"
vim.api.nvim_set_keymap("n", "<leader>cs", "<cmd>Telescope colorscheme<CR>", opts)

opts.desc = "Fuzzy find themes"
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>Telescope themes<CR>", opts)
