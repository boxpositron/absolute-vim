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
    extensions = {
        file_browser = {
            hijack_netrw = true,
        }
    }
})

telescope.load_extension("file_browser")
telescope.load_extension("flutter")
telescope.load_extension("dap")


local find_files = function()
    builtin.find_files({
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
    })
end

local opts = { noremap = true, silent = true }

opts.desc = "Open file browswer"
vim.keymap.set("n", "<leader>`", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

opts.desc = "Fuzzy find files in cwd"
vim.keymap.set("n", "<leader>pf", find_files, opts)

opts.desc = "Fuzzy find recent files"
vim.keymap.set("n", "<leader>pr", builtin.oldfiles, opts)

opts.desc = "Fuzzy find files in git in cwd"
vim.keymap.set("n", "<C-p>", builtin.git_files, opts)

opts.desc = "Fuzzy find string under cursor in cwd"
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, opts)
