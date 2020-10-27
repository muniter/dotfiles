-- Python
require'nvim_lsp'.pyls.setup({
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
require'nvim_lsp'.tsserver.setup({enable = true, on_attach = require'completion'.on_attach})
-- Lua
require'nvim_lsp'.sumneko_lua.setup({on_attach = require'completion'.on_attach})
-- JSON
require'nvim_lsp'.jsonls.setup{({on_attach = require'completion'.on_attach})}
-- YAML
require'nvim_lsp'.yamlls.setup{({on_attach = require'completion'.on_attach})}
-- HTML
require'nvim_lsp'.html.setup{({on_attach = require'completion'.on_attach})}
-- CSS
require'nvim_lsp'.cssls.setup{({on_attach = require'completion'.on_attach})}
-- Docker
require'nvim_lsp'.dockerls.setup{({on_attach = require'completion'.on_attach})}

