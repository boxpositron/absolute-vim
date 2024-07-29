local function SetupWindowPreferences()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end



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

local function SyncWezTerm()
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true }),
        callback = function(args)
            SetupWindowPreferences()

            local colorscheme = colorschemes[args.match]
            if not colorscheme then
                return
            end

            -- Write the colorscheme to a file
            local filename = vim.fn.expand("$XDG_CONFIG_HOME/wezterm/colorscheme")
            assert(type(filename) == "string")
            local file = io.open(filename, "w")
            assert(file)
            file:write(colorscheme)
            file:close()
            -- vim.notify("Setting WezTerm color scheme to " .. colorscheme, vim.log.levels.INFO)
        end,
    })
end

-- Setup Autocommand if wezterm is available in the system
if vim.fn.executable("wezterm") == 1 then
    SyncWezTerm()
end

SetupWindowPreferences()
