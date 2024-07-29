return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "andrew-george/telescope-themes",
    },
    config = function()
        require("absolute.after.telescope")
    end
}
