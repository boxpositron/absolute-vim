return {
    "theprimeagen/harpoon",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("absolute.after.harpoon")
    end
}
