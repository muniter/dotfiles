-- Python
require'lspconfig'.pyls.setup({
    enable = true,
    on_attach = require'completion'.on_attach,
    settings = {
        pyls = {
            plugins = {
                pycodestyle = {
                    enable = true,
                    ignore = "W191"
                }
            }
        }
    }
})
-- Typescript, Javascript
require'lspconfig'.tsserver.setup({enable = true, on_attach = require'completion'.on_attach})
-- JSON
require'lspconfig'.jsonls.setup{({on_attach = require'completion'.on_attach})}
-- YAML
require'lspconfig'.yamlls.setup{({on_attach = require'completion'.on_attach})}
-- HTML
require'lspconfig'.html.setup{({on_attach = require'completion'.on_attach})}
-- CSS
require'lspconfig'.cssls.setup{({on_attach = require'completion'.on_attach})}
-- Docker
require'lspconfig'.dockerls.setup{({on_attach = require'completion'.on_attach})}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local sumneko_root_path = "/home/muniter/software/lua-language-server/"
local sumneko_binary = "/home/muniter/software/lua-language-server/bin/Linux/lua-language-server"

-- Lua
require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
