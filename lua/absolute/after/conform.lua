local conform = require("conform")

conform.setup({
	format_on_save = function(bufnr)
		local disable_filetypes = {}
		return {
			timeout_ms = 5000,
			lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "biome" },
		astro = { "prettier", "biome" },
		vue = { "prettier" },
	},
})

-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
