local incline = require("incline")
local helpers = require("incline.helpers")
local devicons = require("nvim-web-devicons")

incline.setup({
	window = {
		padding = 0,
		margin = { horizontal = 0 },
	},
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p")
		local ft_icon, ft_color = devicons.get_icon_color(filename)
		local modified = vim.bo[props.buf].modified

		local path = vim.fn.fnamemodify(filepath, ":~:.") -- Get relative path

		-- local function get_git_diff()
		--     local icons = { removed = "", changed = "", added = "" }
		--     local signs = vim.b[props.buf].gitsigns_status_dict
		--     local labels = {}
		--     if signs == nil then
		--         return labels
		--     end
		--     for name, icon in pairs(icons) do
		--         if tonumber(signs[name]) and signs[name] > 0 then
		--             table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
		--         end
		--     end
		--     if #labels > 0 then
		--         table.insert(labels, { "┊ " })
		--     end
		--     return labels
		-- end
		--
		-- local function get_diagnostic_label()
		--     local icons = { error = "", warn = "", info = "", hint = "" }
		--     local label = {}
		--
		--     for severity, icon in pairs(icons) do
		--         local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
		--         if n > 0 then
		--             table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
		--         end
		--     end
		--     if #label > 0 then
		--         table.insert(label, { "┊ " })
		--     end
		--     return label
		-- end
		--
		return {
			-- { get_diagnostic_label() },
			-- { get_git_diff() },
			ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
			" ",
			{ path, gui = modified and "bold,italic" or "bold" },
			" ",
			guibg = "#44406e",
		}
	end,
})
