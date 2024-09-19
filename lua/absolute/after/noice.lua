local noice = require("noice")
local notify = require("notify")


notify.setup({
    top_down = false,
    animate = false,
    stages = "static",
})

noice.setup({
    routes = {
        {
            filter = {
                event = "msg_show",
                min_height = 20,
            },
            view = "cmdline_output",
        },
        {
            filter = {
                event = "lsp",
                kind = "progress",
                cond = function(message)
                    local client = vim.tbl_get(message.opts, "progress", "client")

                    return client == "lua_ls"
                end
            },
            opts = { skip = true },
        }
    },
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    cmdline = {
        format = {
            search_down = {
                view = "cmdline",
            },
            search_up = {
                view = "cmdline",
            },
        },
    },
    views = {
        cmdline_popup = {
            relative = "editor",
            position = {
                row = 5,
                col = "50%",
            },
            size = {
                width = 60,
                height = "auto",
            },
            border = {
                style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                padding = { 0, 1 },
            },
            filter_options = {},
            win_options = {
                winhighlight = {
                    Normal = "Normal",
                }
            },
        },
        popupmenu = {
            relative = "editor",
            position = {
                row = 8,
                col = "50%",
            },
            size = {
                width = 60,
                height = 10,
            },
            border = {
                style = "rounded",
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
        },
    },
})
