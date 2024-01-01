return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        vim.cmd([[:TSUpdate]])
        require("absolute.after.nvim-treesitter")
    end
}
