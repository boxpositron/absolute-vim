local lua_utils = require("absolute.utils.detect-lua")

package.path = package.path .. lua_utils.GetLatestLuaVersion()



-- disable nvim intro
vim.opt.shortmess:append "sI"


vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.statuscolumn = "%s %l %r  "
vim.opt.cursorline = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backspace = "indent,eol,start"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

vim.o.completeopt = "menuone"
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,"
    .. "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
    .. "sm:block-blinkwait175-blinkoff150-blinkon175"

-- Function to change cursor color
local function set_cursor_color(color)
    vim.api.nvim_set_hl(0, "Cursor", { fg = color, bg = color })
end

-- Autocommands to change cursor color based on mode
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        set_cursor_color("#ffffff") -- Red in insert mode
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        set_cursor_color("#7DF9FF") -- Blue in visual mode
    end,
})

-- Add similar autocommands for other modes as needed
