require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "tsserver",
        "biome",
        "rust_analyzer",
        "html",
        "emmet_ls",
        "lua_ls",
        "tailwindcss",
        "svelte",
        "cssls",
        "jedi_language_server",
        "kotlin_language_server"
    },
    automatic_installation = true,
})
require("mason-nvim-dap").setup({
    ensure_installed = {
        "debugpy", -- python
    },
    automatic_installation = true,
})
