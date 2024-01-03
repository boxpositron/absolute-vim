return {
    "wintermute-cell/gitignore.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("absolute.after.gitignore")
    end
}
