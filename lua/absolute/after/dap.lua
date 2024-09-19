local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")
local virtual_text = require("nvim-dap-virtual-text")

-- Setup Virtual Text
virtual_text.setup({
    prefix = " ",
    hl = "Comment",
    lines = 3,
    enabled = true,
})


local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason")
local debugpy_path = mason_path .. "/packages/debugpy/venv/bin/python"

dapui.setup()
dap_python.setup(debugpy_path)

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Setup Mappings
local opts = { noremap = true, silent = true }

opts.desc = "Toggle breakpoint"
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint<CR>", opts)

opts.desc = "Debug Python Run"
vim.keymap.set("n", "<leader>dpr", function()
    dap_python.test_method()
end, opts)
