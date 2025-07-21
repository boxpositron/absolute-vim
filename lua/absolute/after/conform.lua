local conform = require("conform")

conform.setup({
	format_on_save = function(bufnr)
		local disable_filetypes = {}
		return {
			timeout_ms = 500,
			lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
		}
	end,
	formatters_by_ft = {
		sh = { "shfmt" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = {

			-- To fix auto-fixable lint errors.
			"ruff_fix",
			-- To run the Ruff formatter.
			"ruff_format",
			-- To organize the imports.
			"ruff_organize_imports",
		},
		-- Use a sub-list to run only the first available formatter
		javascript = { "biome" },
		astro = { "prettierd", "prettier", "biome" },
		vue = { "prettierd", "prettier" },
		proto = { "buf" },
		yaml = { "prettierd", "prettier" },
	},
})

-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
