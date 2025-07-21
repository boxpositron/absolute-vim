return {
    "https://github.com/apple/pkl-neovim",
    enabled = false,
    lazy = true,
    event = "BufReadPre *.pkl",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    build = function()
        vim.cmd("TSInstall! pkl")
    end,
}
