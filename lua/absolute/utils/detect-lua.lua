function GetLuaPath(version)
	local path = vim.fn.expand("$HOME") .. "/.luarocks/share/lua/" .. version .. "/?.lua;"
	path = path .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/" .. version .. "/?/init.lua;"
	return path
end

function GetInstalledLuaVersion()
	-- List the directory contents of the lua rocks directory
	local rocks = vim.fn.glob(vim.fn.expand("$HOME") .. "/.luarocks/share/lua/")

	-- Split the string into a table

	rocks = vim.split(rocks, "\n")

	-- Sort the table highest to lowest

	table.sort(rocks, function(a, b)
		return tonumber(a) > tonumber(b)
	end)

	return rocks
end

function GetLatestLuaVersion()
	local rocks = GetInstalledLuaVersion()
	local preferredVersion = rocks[1]

	local path = GetLuaPath(preferredVersion)

	return path
end

M = {}

M.GetLuaPath = GetLuaPath
M.GetInstalledLuaVersion = GetInstalledLuaVersion
M.GetLatestLuaVersion = GetLatestLuaVersion

return M
