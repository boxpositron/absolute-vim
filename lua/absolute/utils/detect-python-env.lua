function CheckPoetryVirtualEnv()
    local poetry = vim.fn.system("poetry env info -p 2>/dev/null")
    if poetry == "" then
        return nil
    end
    return poetry
end

function ResolvePythonEnvironment()
    -- Get system global python env
    local python = vim.fn.system("which python3")
    -- Check of virtual environments exists
    local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or CheckPoetryVirtualEnv()

    if virtual == nil then
        -- Check if poetry environment exists

        return {
            "--python-executable", python
        }
    end

    return {
        "--python-executable", virtual .. "/bin/python"
    }
end

M = {}

M.ResolvePythonEnvironment = ResolvePythonEnvironment
M.CheckPoetryVirtualEnv = CheckPoetryVirtualEnv

return M
