local function redirReg(command, register, silent)
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
        vim.api.nvim_command('redir ' .. '@' .. register)
        vim.api.nvim_command(string.format('%s %s', silent, command))
        vim.api.nvim_command('redir END')
    end
end

local function toggleBox()
    local line = vim.api.nvim_get_current_line()
end

local function spellSuggestions()
    -- body
    -- local word = vim.api.nvim_command('call spellbadword()')
    local word = vim.fn.spellbadword()
    if word[2] == 'bad' then
        print("Got a bad word now:", word[1])
        local suggestions = vim.fn.spellsuggest(word[2])
        print("Got this suggestions", vim.inspect(suggestions))
    end
end

-- Global function to inspect expressions
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

return {
    redirReg = redirReg,
    toggleBox = toggleBox,
    spellSuggestions = spellSuggestions
}
