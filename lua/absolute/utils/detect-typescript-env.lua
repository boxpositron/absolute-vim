M = {}
local function trim(s)
	return s:gsub("^%s*(.-)%s*$", "%1")
end

local ResolveTypescriptServer = function()
	-- Find the package.json file
	local viable = vim.fn.system("find . -name 'package.json' -maxdepth 3 | xargs dirname")
	viable = trim(viable)

	if viable == "" then
		return nil
	end

	-- Check for lock files
	local find_npm_result = trim(vim.fn.system("find . -name 'package-lock.json' -maxdepth 3 | wc -l"))
	local find_pnpm_result = trim(vim.fn.system("find . -name 'pnpm-lock.yaml' -maxdepth 3 | wc -l"))
	local find_yarn_result = trim(vim.fn.system("find . -name 'yarn.lock' -maxdepth 3 | wc -l"))

	local is_npm = find_npm_result == "1"
	local is_pnpm = find_pnpm_result == "1"
	local is_yarn = find_yarn_result == "1"

	-- if no package lock files are found, end early
	if not is_npm and not is_pnpm and not is_yarn then
		return nil
	end

	-- Determine the preferred package manager
	local ppm = "pnpm" -- Default to pnpm
	if is_npm then
		ppm = "npm"
	end
	if is_yarn then
		ppm = "yarn"
	end

	-- Resolve TypeScript server path
	local base_command = ppm .. " list typescript --dir " .. viable .. " --json"
	local base_result = trim(vim.fn.system(base_command))

	if base_result == "" then
		vim.notify("Failed to run " .. base_command, vim.log.levels.ERROR)
		return nil
	end

	local typescript_path = nil

	if ppm == "pnpm" or ppm == "npm" or ppm == "yarn" then
		local ok, parsed = pcall(vim.fn.json_decode, base_result)
		if ok and parsed and #parsed > 0 and parsed[1].path then
			typescript_path = parsed[1].path .. "/node_modules/typescript/lib"
		end
	end

	if not typescript_path or typescript_path == "" then
		vim.notify("TypeScript not found. Please install TypeScript globally or in the project.", vim.log.levels.ERROR)
		return nil
	end

	return typescript_path
end

M.ResolveTypescriptServer = ResolveTypescriptServer
M.trim = trim

return M
