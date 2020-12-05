local function redirReg(command, silent)
    -- redirect command output to register, if silent argument is true, then
    -- execute silently.
    if silent == 1 or silent == true then
        silent = 'silent'
    else
        silent = ''
    end
    if command ~= nil then
        vim.api.nvim_command('redir @r')
        vim.api.nvim_command(string.format('%s %s', silent, command))
        vim.api.nvim_command('redir END')
    end
end

-- redirReg('reg', true)

return {
    redirReg
}
