-- Setup language servers.
local lspconfig    = require('lspconfig')
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local opts         = { noremap = true, silent = true }
local on_attach    = function(client, bufnr)
    opts.buffer = bufnr

    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'


    opts.desc = "Go to declaration"
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = "Go to definitions"
    vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    opts.desc = "Show LSP Implementation"
    vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "Get Help"
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)

    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)

    opts.desc = "Show LSP type definitions"
    vim.keymap.set('n', 'gt', "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "Smart rename"
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    opts.desc = "See available code actions"
    vim.keymap.set({ 'n', 'v' }, '<leader>vca', vim.lsp.buf.code_action, opts)

    opts.desc = "Show LSP references"
    vim.keymap.set('n', '<leader>vrr', "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Format File"
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    opts.desc = "Restart LSP"
    vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs        = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


-- configure html server
lspconfig["html"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure typescript server with plugin
lspconfig["tsserver"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure svelte server
lspconfig["svelte"].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
                if client.name == "svelte" then
                    client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
                end
            end,
        })
    end,
})


-- configure emmet language server
lspconfig["emmet_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure python server
lspconfig["pyright"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
    -- Server-specific settings. See `:help lspconfig-setup`
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {},
    },
})



-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})
