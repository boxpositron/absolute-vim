local dap = require("dap")
local dapui = require("dapui")
local virtual_text = require("nvim-dap-virtual-text")

-- Setup Virtual Text
virtual_text.setup({
	prefix = " ",
	hl = "Comment",
	lines = 3,
	enabled = true,
})

dapui.setup()

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
