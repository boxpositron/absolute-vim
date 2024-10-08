local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")
local file_browser_actions = require("telescope._extensions.file_browser.actions")

local find_files = function()
    builtin.find_files({
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
    })
end

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
            respect_gitignore = vim.fn.executable "fd" == 1,
            hidden = { file_browser = true, folder_browser = false },
            auto_depth = false,
            browse_files = require("telescope._extensions.file_browser.finders").browse_files,
            display_stat = {
                date = true,
                size = true,
                mode = false,
            },
            use_fd = true,
            git_status = true,
            mappings = {
                ["i"] = {
                    ["<A-c>"] = file_browser_actions.create,
                    ["<S-CR>"] = file_browser_actions.create_from_prompt,
                    ["<A-r>"] = file_browser_actions.rename,
                    ["<A-m>"] = file_browser_actions.move,
                    ["<A-y>"] = file_browser_actions.copy,
                    ["<A-d>"] = file_browser_actions.remove,
                    ["<C-o>"] = file_browser_actions.open,
                    ["<C-g>"] = file_browser_actions.goto_parent_dir,
                    ["<C-e>"] = file_browser_actions.goto_home_dir,
                    ["<C-w>"] = file_browser_actions.goto_cwd,
                    ["<C-t>"] = file_browser_actions.change_cwd,
                    ["<C-f>"] = file_browser_actions.toggle_browser,
                    ["<C-h>"] = file_browser_actions.toggle_hidden,
                    ["<C-s>"] = file_browser_actions.toggle_all,
                    ["<bs>"] = file_browser_actions.backspace,
                },
                ["n"] = {
                    ["c"] = file_browser_actions.create,
                    ["r"] = file_browser_actions.rename,
                    ["m"] = file_browser_actions.move,
                    ["y"] = file_browser_actions.copy,
                    ["d"] = file_browser_actions.remove,
                    ["o"] = file_browser_actions.open,
                    ["g"] = file_browser_actions.goto_parent_dir,
                    ["e"] = file_browser_actions.goto_home_dir,
                    ["w"] = file_browser_actions.goto_cwd,
                    ["t"] = file_browser_actions.change_cwd,
                    ["f"] = file_browser_actions.toggle_browser,
                    ["h"] = file_browser_actions.toggle_hidden,
                    ["s"] = file_browser_actions.toggle_all,
                },
            },
        },
    },
})

telescope.load_extension("file_browser")
telescope.load_extension("flutter")
telescope.load_extension("dap")
telescope.load_extension("themes")


local opts = { noremap = true, silent = true }

opts.desc = "Open file browser (cwd)"
vim.keymap.set("n", "<leader>pf", "<cmd>Telescope file_browser<CR>", opts)

opts.desc = "Open file browser (current file)"
vim.keymap.set("n", "<leader>cf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

opts.desc = "Fuzzy find files (cwd)"
vim.keymap.set("n", "<C-p>", find_files, opts)

opts.desc = "Fuzzy find recent files"
vim.keymap.set("n", "<leader>pr", builtin.oldfiles, opts)

opts.desc = "Fuzzy find files in git in cwd"
vim.keymap.set("n", "<leader>gf", builtin.git_files, opts)

opts.desc = "Fuzzy find string under cursor in cwd"
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Global Search") })
end, opts)
