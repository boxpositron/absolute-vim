function GetProjectRoot()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if git_root == nil then
        return vim.fn.getcwd()
    else
        return git_root
    end
end

return GetProjectRoot
