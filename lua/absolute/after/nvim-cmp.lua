local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

cmp.setup({
    completion = {
        completeopt = "menu,menuone,preview,noselect",
    },
    window = {
        completion = {
            side_padding = 1,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
            scrollbar = false,
        },
        documentation = {
            border = border "CmpDocBorder",
            winhighlight = "Normal:CmpDoc",
        },
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),            -- show completion suggestions
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- accept current selection
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
        { name = "otter" },   -- custom source for otter completion
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" },  -- text within current buffer
        { name = "path" },    -- file system paths
    }),
    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
        }),
    },
})
