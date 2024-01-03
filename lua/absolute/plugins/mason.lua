return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = {
                "mfussenegger/nvim-dap",

            }
        }
    },
    config = function()
        require("absolute.after.mason")
    end

}
