-- This is my attempt at writing some lua
local M = {}
-- local api = vim.api
function M.myfirsthellofunc(name)
    if name ~= nil then
        print(string.format("I like that you give me a name"))
    end
    print("Hello %s", name)
end
print('This is my tools.lua being sourced')
return M
