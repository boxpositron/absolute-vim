return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        vim.cmd([[:silent !TSUpdate]])
        require("absolute.after.nvim-treesitter")
    end
}
