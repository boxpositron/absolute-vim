return {
    "nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    event = "VimEnter",
    config = function()
        require("absolute.after.dashboard")
    end

}
