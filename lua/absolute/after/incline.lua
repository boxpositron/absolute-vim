local incline = require("incline")
local helpers = require("incline.helpers")
local devicons = require("nvim-web-devicons")

local function shortenPath(str, max)
    if #str > max then
        local start = #str - max + 1
        return "..." .. string.sub(str, start)
    end

    return str
end

incline.setup({
    window = {
        padding = 0,
        margin = { horizontal = 0 },
        placement = {
            horizontal = "right",
        },
    },
    render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p")
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        local path = vim.fn.fnamemodify(filepath, ":~:.") -- Get relative path
        path = shortenPath(path, 30)

        -- Shorten path from the left if the entire line is longer than 100 characters

        --
        return {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { path, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#44406e",
        }
    end,
})
