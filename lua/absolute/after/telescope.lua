local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
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
                ["<C-t>"] = trouble.open,
                ["<C-q>"] = actions.send_to_qflist,
            },
            n = {
                ["<C-t>"] = trouble.open,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            hide_parent_dir = true,
            depth = 1,
            respect_gitignore = false,
            auto_depth = true,
            display_stat = {
                date = true,
                size = true,
                mode = false,
            },
        },
    },
})

telescope.load_extension("file_browser")
telescope.load_extension("flutter")
telescope.load_extension("dap")
telescope.load_extension("themes")

local find_files = function()
    builtin.find_files({
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
    })
end

local opts = { noremap = true, silent = true }

opts.desc = "Open file browser (cwd)"
vim.keymap.set("n", "<leader>af", "<cmd>Telescope file_browser<CR>", opts)

opts.desc = "Open file browser (current file)"
vim.keymap.set("n", "<leader>cf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

opts.desc = "Fuzzy find files (cwd)"
vim.keymap.set("n", "<leader>pf", find_files, opts)

opts.desc = "Fuzzy find recent files"
vim.keymap.set("n", "<leader>pr", builtin.oldfiles, opts)

opts.desc = "Fuzzy find files in git in cwd"
vim.keymap.set("n", "<C-p>", builtin.git_files, opts)

opts.desc = "Fuzzy find string under cursor in cwd"
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, opts)
