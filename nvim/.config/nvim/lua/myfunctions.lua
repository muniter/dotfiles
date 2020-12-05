local function redirReg(command, silent, register)
    -- This function takes a command and redirects it's output to a register
    -- which is very helpful when one wants to analyze the output more, since
    -- the usual vim viewer doesn't allow searching.
    if silent == 1 or silent == true then
        silent = 'silent'
    else
        silent = ''
    end
    -- If no register is provided use r
    if register == nil or register == '' or register == false then
        register = 'r'
    end
    if command ~= nil then
        vim.api.nvim_command('redir ' + '@' + register)
        vim.api.nvim_command(string.format('%s %s', silent, command))
        vim.api.nvim_command('redir END')
    end
end

local function toggleBox()
    line = vim.api.nvim_get_current_line()
end

return {
    redirReg = redirReg,
    toggleBox = toggleBox
}
