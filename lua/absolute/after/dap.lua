local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
dap_python.setup(path)

-- Setup Mappings
local opts = { noremap = true, silent = true }

opts.desc = "Toggle breakpoint"
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint<CR>", opts)

opts.desc = "Debug Python Run"
vim.keymap.set("n", "<leader>dpr", function()
    dap_python.test_method()
end, opts)
