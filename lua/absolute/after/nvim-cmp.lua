local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,noinsert,noselect",
		autocomplete = { types.cmp.TriggerEvent.TextChanged },
	},
	window = {
		documentation = {
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
		},
		completion = {
			side_padding = 1,
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
			scrollbar = false,
		},
	},
	snippet = { -- configure how nvim-cmp interacts with snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-.>"] = cmp.mapping.complete(), -- show completion suggestions
		["C-<BS>"] = cmp.mapping.abort(), -- close completion menu
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- accept current selection
	}),

	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "codecompanion" }, -- code companion for AI-assisted coding
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths,
		{ name = "nvim_lsp_signature_help" },
	}),
	-- configure lspkind for vs-code like pictograms in completion menu
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})
