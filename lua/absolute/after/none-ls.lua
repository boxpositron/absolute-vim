local null_ls = require("null-ls")


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

        print("No virtual environment detected, using system python")
        return {
            "--python-executable", python
        }
    end

    print("Using virtual environment: " .. virtual)
    return {
        "--python-executable", virtual .. "/bin/python3"
    }
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy.with({
            extra_args = ResolvePythonEnvironment()
        }),
    },
})
