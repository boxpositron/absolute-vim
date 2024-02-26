local hologram = require("hologram")
local image = require("hologram.image")

-- Image should appear below this line, then disappear after 5 seconds
hologram.setup({
	auto_display = true,
})

--[[
id: (number) autocommand id
event: (string) name of the triggered event |autocmd-events|
group: (number|nil) autocommand group id, if any
match: (string) expanded value of |<amatch>|
buf: (number) expanded value of |<abuf>|
file: (string) expanded value of |<afile>|
data: (any) arbitrary data passed |nvim_exec_autocmds()| ]]

local new_image = nil

local function handle_image_preview(arguments)
	-- get the file path
	local file = arguments.file
	local buf = arguments.buf

	--[[
    print("Hologram activated")
    print("File: " .. file) ]]

	new_image = image:new(file, {}):display(5, 0, buf, {})

	vim.defer_fn(function()
		new_image:delete(0, { free = true })
	end, 10000)
end

local function handle_image_preview_close()
	-- Check if New Image is not nil explicitly

	--     if new_image == nil then
	--         return
	--     end
	--
	--     new_image:delete(0, { free = true })
	--     new_image = nil
end

local image_pattern = { ".png", ".jpg", ".jpeg", ".gif" }

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = image_pattern,
	callback = handle_image_preview,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
	pattern = image_pattern,
	callback = handle_image_preview_close,
})
