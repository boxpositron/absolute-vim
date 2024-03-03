SUPPORTED_OS = {
    WINDOWS = "Windows",
    UNIX = "Unix",
    MACOS = "macOS",
}

local function isMacOS()
    -- Try to execute `sw_vers` command which is specific to macOS
    local result = os.execute("sw_vers > /dev/null 2>&1")

    -- `os.execute` returns true on success for Lua versions 5.2 and above
    -- For Lua 5.1 and below, it returns the exit code of the command. On success, it should be zero.
    -- Adjust the check if you're using Lua 5.1 or below:
    -- if result == 0 then
    if result then
        return true
    else
        return false
    end
end

local function detectOS()
    if os.getenv("OS") ~= nil then
        return os.getenv("OS") -- This can be useful in Windows environments
    elseif os.getenv("PATH"):find(";") then
        return SUPPORTED_OS.WINDOWS
    else
        local is_macos = isMacOS()

        if is_macos then
            return SUPPORTED_OS.MACOS
        else
            return SUPPORTED_OS.UNIX
        end
    end
end

M = {}

M.detect = detectOS
M.supported = SUPPORTED_OS

return M
