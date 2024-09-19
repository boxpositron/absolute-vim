local function SetupWindowPreferences()
    -- Utility function to get the blend value or set a default
    local function get_blend_value(group_name, default_blend)
        -- Retrieve highlight settings for the group using the new API
        local current_highlight = vim.api.nvim_get_hl(0, { name = group_name })
        return current_highlight.blend or default_blend
    end

    -- Set the Normal group with dynamic blend
    local normal_blend = get_blend_value("Normal", 50)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none", blend = normal_blend })

    -- Set the NormalFloat group with dynamic blend
    local normal_float_blend = get_blend_value("NormalFloat", 50)
    vim.api.nvim_set_hl(1, "NormalFloat", { bg = "none", blend = normal_float_blend })

    -- Set the NormalNC group with dynamic blend
    local normal_nc_blend = get_blend_value("NormalNC", 50)
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", blend = normal_nc_blend })
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
