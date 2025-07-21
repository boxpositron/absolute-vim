function CheckPoetryVirtualEnv()
	local poetry = vim.fn.system("poetry env info -p 2>/dev/null")
	if poetry == "" then
		return nil
	end
	return poetry
end

function ResolvePythonEnvironment()
	-- Check if asdf is installed

	-- Get system global python env
	local python = vim.fn.system("which python3")
	-- Check of virtual environments exists
	local virtual = os.getenv("VIRTUAL_ENV") or CheckPoetryVirtualEnv()

	if virtual == nil then
		return {
			"--python-executable",
			python,
		}
	end

	return {
		"--python-executable",
		virtual .. "/bin/python",
	}
end

function ResolvePythonEnvironmentAsString()
	local env = ResolvePythonEnvironment()
	if env == nil then
		return ""
	end

	local path = table.concat(env, " ")

	return path
end

M = {}

M.ResolvePythonEnvironmentAsString = ResolvePythonEnvironmentAsString
M.ResolvePythonEnvironment = ResolvePythonEnvironment
M.CheckPoetryVirtualEnv = CheckPoetryVirtualEnv

return M
