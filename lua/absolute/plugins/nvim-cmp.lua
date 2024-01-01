return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',           --source for text in buffer
        'hrsh7th/cmp-path',             --source for file system paths
        'hrsh7th/cmp-cmdline',
        "saadparwaiz1/cmp_luasnip",     --source for autocompletion
        "onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip",             --Snippet Engine
        "rafamadriz/friendly-snippets", --Useful snippets
    },
    config = function()
        require("absolute.after.nvim-cmp")
    end
}
