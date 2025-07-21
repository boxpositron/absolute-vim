function SafeInvoke(func)
    -- safely invoke a functions
    -- if the function returns an error, return an empty string
    -- otherwise return the result of the function

    local ok, result = pcall(func)

    if ok then
        return result
    else
        return ""
    end
end

return SafeInvoke
