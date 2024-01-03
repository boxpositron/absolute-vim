return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        -- "nvim-telescope/telescope-dap.nvim",
        { "mfussenegger/nvim-dap-python", ft = "python", dependencies = { "mfussenegger/nvim-dap" } },
        -- "Pocco81/DAPInstall.nvim"
    },
    config = function()
        require("absolute.after.dap")
    end
}
