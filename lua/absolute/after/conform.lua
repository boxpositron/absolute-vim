local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { "biome" },
        astro = { { "prettierd", "prettier" } },
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
