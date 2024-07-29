return {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    config = function()
        require("absolute.after.tokyonight")
    end
}
