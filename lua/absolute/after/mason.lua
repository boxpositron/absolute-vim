require("mason").setup();
require("mason-lspconfig").setup({
    ensure_installed = {
        "tsserver",
        "eslint",
        "rust_analyzer",
        "html",
        "emmet_ls",
        "lua_ls",
        "tailwindcss",
        "svelte",
        "cssls",
        "pyright"
    },
    automatic_installation = true,
})
