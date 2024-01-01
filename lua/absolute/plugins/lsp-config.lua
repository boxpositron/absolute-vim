return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp",                name = "nvim_lsp" },
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        require("absolute.after.lsp-config")
    end
}
