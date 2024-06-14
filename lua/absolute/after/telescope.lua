local telescope = require("telescope")
local builtin = require("telescope.builtin")
local trouble = require("trouble.sources.telescope")


telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        mappings = {
            i = {
                ["<C-q>"] = trouble.open,
            },
            n = {
                ["<C-q>"] = trouble.open,
            },
        },
    },
})

telescope.load_extension("flutter")
telescope.load_extension("dap")


local find_files = function()
    builtin.find_files({
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
    })
end

vim.keymap.set("n", "<leader>pf", find_files, { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>pr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find files in git in cwd" })
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find string under cursor in cwd" })
